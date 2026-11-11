#!/usr/bin/env bash

err() {
    echo "Error: $*" >&2
}

usage() {
    cat <<EOF
Usage:
  worktree init <repo-url> [folder]                 Create [folder] with a bare repo and default branch worktree
                                                        (<repo-url> can be a full URL or GitHub org/repo;
                                                        [folder] defaults to the repo name;
                                                        creates a personal .worktreeinclude with
                                                        .gitignore's lines commented out)
  worktree add [--verbose] [--from <ref>] <branch> [path]
                                                    Add a worktree for <branch> (creates the branch if needed;
                                                        [path] defaults to <branch> in the repo root;
                                                        --from <ref> bases a new branch on <ref> instead of
                                                        the default branch (only valid when <branch> doesn't
                                                        already exist locally or on origin);
                                                        copies gitignored files listed in .worktreeinclude;
                                                        --verbose lists each path copied)
  worktree list [args]                              List worktrees (git worktree list)
  worktree move <worktree> <new-path>               Move a worktree (git worktree move)
  worktree remove [--delete-branch] [--verbose] <path> [args]
                                                    Remove a worktree (git worktree remove);
                                                        --delete-branch also deletes its local branch;
                                                        offers to copy changed .worktreeinclude files back)
  worktree prune [args]                             Prune stale worktrees (git worktree prune)
  worktree repair [path...]                         Fix links between worktrees and the repo after moving
                                                        them by hand (git worktree repair; run it inside a
                                                        moved worktree, or pass the new paths)
EOF
}

# Turn a path into an absolute, symlink-resolved one (the path itself doesn't need to exist,
# its parent does). Resolving symlinks keeps this comparable with git's own output (e.g. git
# worktree list --porcelain), which also reports resolved paths.
abs_path() {
    local dir
    dir=$(cd -P "$(dirname "$1")" 2>/dev/null && pwd) || return 1
    echo "$dir/$(basename "$1")"
}

# Remove empty folders from $1 upwards, stopping at $2 (e.g. feature/ left behind by feature/x)
remove_empty_parents() {
    local dir=$1 stop=$2
    while [ "$dir" != "$stop" ] && [ "$dir" != "/" ] && [ -d "$dir" ] && [ -z "$(ls -A "$dir")" ]; do
        rmdir "$dir" || break
        dir=$(dirname "$dir")
    done
}

cmd_init() {
    REPO_URL=$1
    TARGET_DIR=$2

    if [ -z "$REPO_URL" ]; then
        err "Missing repository URL."
        echo "Usage: worktree init <repo-url> [folder]" >&2
        exit 1
    fi

    # Expand GitHub shorthand (org/repo) to a full SSH URL
    if [[ "$REPO_URL" =~ ^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$ ]] && [ ! -e "$REPO_URL" ]; then
        REPO_URL="git@github.com:${REPO_URL%.git}.git"
    fi

    # Default the folder to the repo name (like git clone does)
    if [ -z "$TARGET_DIR" ]; then
        TARGET_DIR="${REPO_URL%/}"
        TARGET_DIR="${TARGET_DIR##*/}"
        TARGET_DIR="${TARGET_DIR##*:}"
        TARGET_DIR="${TARGET_DIR%.git}"

        if [ -z "$TARGET_DIR" ]; then
            err "Could not work out a folder name from '$REPO_URL'."
            echo "Usage: worktree init <repo-url> [folder]" >&2
            exit 1
        fi
    fi

    if [ -e "$TARGET_DIR" ]; then
        err "'$TARGET_DIR' already exists!"
        echo "Please give a folder name that doesn't exist yet." >&2
        exit 1
    fi

    if ! mkdir -p "$TARGET_DIR"; then
        err "Could not create folder '$TARGET_DIR'."
        exit 1
    fi

    INIT_DIR=$(cd "$TARGET_DIR" && pwd) || exit 1
    INIT_DONE=""

    # If anything below fails, remove the half-built folder so a retry starts clean
    cleanup_init() {
        if [ -z "$INIT_DONE" ] && [ -n "$INIT_DIR" ] && [ -d "$INIT_DIR" ]; then
            echo "Setup failed, removing $INIT_DIR" >&2
            cd / && rm -rf "$INIT_DIR"
        fi
    }
    trap cleanup_init EXIT

    cd "$INIT_DIR" || exit 1

    echo "Initializing Worktree setup in $TARGET_DIR..."

    # Clone as bare repo into a hidden directory
    if ! git clone --bare "$REPO_URL" .bare; then
        err "Failed to clone $REPO_URL"
        exit 1
    fi

    # Link the root to the bare repository
    echo "gitdir: ./.bare" > .git || exit 1

    # Enable remote tracking
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" || exit 1

    # New branches push without needing -u, and fetches drop branches deleted on the remote
    git config push.autoSetupRemote true || exit 1
    git config fetch.prune true || exit 1

    # fetch everything
    if ! git fetch --all; then
        err "Failed to fetch from origin."
        exit 1
    fi

    # Record the remote's default branch as origin/HEAD, so we can follow it if it changes
    git remote set-head origin --auto >/dev/null || err "Could not record origin's default branch, carrying on."

    DEFAULT_BRANCH=$(default_branch)

    if [ -z "$DEFAULT_BRANCH" ]; then
        err "Could not determine the default branch."
        exit 1
    fi

    # The bare clone copies every remote branch as a local one, frozen at clone time.
    # Drop all but the default so 'add' sets them up fresh from origin, with tracking.
    git for-each-ref --format='%(refname:short)' refs/heads/ | while read -r branch; do
        if [ "$branch" != "$DEFAULT_BRANCH" ]; then
            git branch -D "$branch" >/dev/null || exit 1
        fi
    done || exit 1

    # Link the default branch to origin so git pull/push work
    if ! git branch --set-upstream-to="origin/$DEFAULT_BRANCH" "$DEFAULT_BRANCH" >/dev/null; then
        err "Could not set upstream for '$DEFAULT_BRANCH'."
        exit 1
    fi

    echo "Default branch is '$DEFAULT_BRANCH', creating worktree..."
    if ! git worktree add "$DEFAULT_BRANCH" "$DEFAULT_BRANCH"; then
        err "Failed to create the '$DEFAULT_BRANCH' worktree."
        exit 1
    fi

    ensure_root_include "$INIT_DIR" "$INIT_DIR/$DEFAULT_BRANCH"

    INIT_DONE=1
    echo "Setup complete! Your $DEFAULT_BRANCH worktree is in $TARGET_DIR/$DEFAULT_BRANCH"
}

# Find the folder that holds .bare, so new worktrees sit alongside the others
repo_root() {
    local common_dir
    common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)

    if [ -z "$common_dir" ]; then
        err "Not inside a worktree setup. Run this from the repo folder or one of its worktrees."
        exit 1
    fi

    dirname "$common_dir"
}

# The remote's default branch (from origin/HEAD), falling back to the bare repo's HEAD
default_branch() {
    local ref
    ref=$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)

    if [ -n "$ref" ]; then
        echo "${ref#origin/}"
    else
        git symbolic-ref --quiet --short HEAD 2>/dev/null
    fi
}

cmd_add() {
    BRANCH=""
    WORKTREE_PATH=""
    FROM_REF=""
    SAW_FROM=""

    while [ $# -gt 0 ]; do
        case "$1" in
            --verbose)
                VERBOSE=1
                ;;
            --from)
                SAW_FROM=1
                shift
                FROM_REF=$1
                ;;
            *)
                if [ -z "$BRANCH" ]; then
                    BRANCH=$1
                elif [ -z "$WORKTREE_PATH" ]; then
                    WORKTREE_PATH=$1
                fi
                ;;
        esac
        shift
    done

    if [ -z "$BRANCH" ]; then
        err "Missing branch name."
        echo "Usage: worktree add [--verbose] [--from <ref>] <branch> [path]" >&2
        exit 1
    fi

    if [ -n "$SAW_FROM" ] && [ -z "$FROM_REF" ]; then
        err "Missing ref after --from."
        exit 1
    fi

    ROOT=$(repo_root) || exit 1

    if [ -z "$WORKTREE_PATH" ]; then
        WORKTREE_PATH="$ROOT/$BRANCH"
    fi

    if [ -e "$WORKTREE_PATH" ]; then
        err "'$WORKTREE_PATH' already exists!"
        exit 1
    fi

    echo "Fetching latest from origin..."
    git fetch origin

    # Pick up any change to the remote's default branch (e.g. master -> main)
    git remote set-head origin --auto >/dev/null 2>&1

    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        if [ -n "$FROM_REF" ]; then
            err "'$BRANCH' already exists, so --from has no effect."
            exit 1
        fi
        echo "Adding worktree for existing branch '$BRANCH'..."
        git worktree add "$WORKTREE_PATH" "$BRANCH" || exit 1
    elif git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
        if [ -n "$FROM_REF" ]; then
            err "'origin/$BRANCH' already exists, so --from has no effect."
            exit 1
        fi
        echo "Adding worktree for remote branch 'origin/$BRANCH'..."
        git worktree add --track -b "$BRANCH" "$WORKTREE_PATH" "origin/$BRANCH" || exit 1
    elif [ -n "$FROM_REF" ]; then
        if ! git rev-parse --verify --quiet "${FROM_REF}^{commit}" >/dev/null; then
            err "'$FROM_REF' is not a valid ref."
            exit 1
        fi

        echo "Creating new branch '$BRANCH' from '$FROM_REF'..."
        git worktree add --no-track -b "$BRANCH" "$WORKTREE_PATH" "$FROM_REF" || exit 1
    else
        DEFAULT_BRANCH=$(default_branch)

        if git show-ref --verify --quiet "refs/remotes/origin/$DEFAULT_BRANCH"; then
            BASE="origin/$DEFAULT_BRANCH"
        else
            BASE="$DEFAULT_BRANCH"
        fi

        echo "Creating new branch '$BRANCH' from '$BASE'..."
        git worktree add --no-track -b "$BRANCH" "$WORKTREE_PATH" "$BASE" || exit 1
    fi

    copy_worktree_includes "$ROOT" "$WORKTREE_PATH"

    echo "Worktree ready in $WORKTREE_PATH"
}

# Find the worktree that has the default branch checked out. If the remote's default has
# changed (e.g. master -> main) and there's no worktree for it yet, use the original one.
default_worktree() {
    local branch path line

    for branch in "$(default_branch)" "$(git symbolic-ref --quiet --short HEAD 2>/dev/null)"; do
        [ -z "$branch" ] && continue
        while read -r line; do
            case "$line" in
                "worktree "*) path=${line#worktree } ;;
                "branch refs/heads/$branch") echo "$path"; return 0 ;;
            esac
        done < <(git worktree list --porcelain)
    done

    return 1
}

# .worktreeinclude patterns use .gitignore syntax and are read from:
#   <default worktree>/.worktreeinclude  (committed, shared with the team)
#   <repo root>/.worktreeinclude         (next to .bare, personal to you)
# Sets INCLUDE_ARGS for list_includes; returns 1 if there are no .worktreeinclude files.
load_include_patterns() {
    local root=$1 main=$2
    INCLUDE_ARGS=()

    if [ -f "$main/.worktreeinclude" ]; then
        INCLUDE_ARGS+=(--exclude-from="$main/.worktreeinclude")
    fi
    if [ -f "$root/.worktreeinclude" ]; then
        INCLUDE_ARGS+=(--exclude-from="$root/.worktreeinclude")
    fi

    [ ${#INCLUDE_ARGS[@]} -gt 0 ]
}

# Create the personal <repo root>/.worktreeinclude if it doesn't exist yet, seeded with the
# default worktree's .gitignore commented out, so it's easy to pick what to copy.
ensure_root_include() {
    local root=$1 main=$2 file="$1/.worktreeinclude" line

    [ -e "$file" ] && return 0

    {
        echo "# Gitignored files and folders to copy from the default branch's worktree into"
        echo "# new worktrees (e.g. .envrc, .terraform/). Uses .gitignore syntax."
        echo "# This file is personal to you; commit a .worktreeinclude to share with the team."
        echo "# Uncomment any of the lines below (taken from .gitignore) to include them."

        if [ -n "$main" ] && [ -f "$main/.gitignore" ]; then
            echo "#"
            echo "# --- .gitignore ---"
            while IFS= read -r line || [ -n "$line" ]; do
                if [ -z "$line" ]; then
                    echo
                else
                    echo "# $line"
                fi
            done <"$main/.gitignore"
        fi
    } >"$file" || { err "Could not create $file"; return 1; }

    echo "Created $file (edit it to choose which gitignored files new worktrees get)"
}

# List (NUL-separated) the paths in worktree $1 that match .worktreeinclude and are gitignored.
# A whole matching folder (e.g. .terraform/) is listed once, with a trailing slash.
list_includes() {
    git -C "$1" ls-files -z --others --ignored --directory "${INCLUDE_ARGS[@]}" |
        git -C "$1" check-ignore -z --stdin
}

# Copy a file or folder using APFS copy-on-write clones: no extra disk space until one
# copy changes. /bin/cp because GNU cp (e.g. Homebrew coreutils) has no -c.
# cp clones file by file (via copyfile(3)), so huge folders like node_modules still take a
# while. clonefile(2) can clone a whole folder in one call, but Apple's man page strongly
# discourages that, so we don't.
copy_clone() {
    /bin/cp -Rpc "$1" "$2" 2>/dev/null && return 0

    # Not on APFS (e.g. an external drive): clean up any partial copy and do a normal one
    rm -rf "$2"
    /bin/cp -Rp "$1" "$2"
}

# Run direnv allow on each .envrc given, since direnv blocks them in new locations or once changed
allow_envrcs() {
    [ $# -eq 0 ] && return 0

    if ! command -v direnv >/dev/null 2>&1; then
        err "Copied .envrc file(s) but direnv isn't installed, so they weren't allowed."
        return 0
    fi

    local file
    for file in "$@"; do
        if direnv allow "$file"; then
            [ -n "$VERBOSE" ] && echo "Ran direnv allow on $file"
        else
            err "direnv allow failed for $file"
        fi
    done
}

# Copy gitignored files and folders matching .worktreeinclude (e.g. .envrc, .terraform)
# from the default branch's worktree into a new worktree.
copy_worktree_includes() {
    local root=$1 target=$2 source entry count=0 skipped=0 envrcs=() file

    source=$(default_worktree) || return 0
    ensure_root_include "$root" "$source"
    load_include_patterns "$root" "$source" || return 0

    echo "Copying files listed in .worktreeinclude from $source..."

    while IFS= read -r -d '' entry; do
        entry=${entry%/}

        # Don't recreate folders this branch doesn't have, or overwrite anything it does have
        if [ ! -d "$target/$(dirname "$entry")" ]; then
            skipped=$((skipped + 1))
            [ -n "$VERBOSE" ] && echo "  Skipped $entry (folder doesn't exist on this branch)"
            continue
        fi
        [ -e "$target/$entry" ] && continue

        if copy_clone "$source/$entry" "$target/$entry"; then
            count=$((count + 1))
            [ -n "$VERBOSE" ] && echo "  Copied $entry"
            while IFS= read -r -d '' file; do
                envrcs+=("$file")
            done < <(find "$target/$entry" -name .envrc -type f -print0)
        else
            err "Could not copy $entry"
        fi
    done < <(list_includes "$source")

    echo "Copied $count file(s)/folder(s)"
    if [ "$skipped" -gt 0 ]; then
        echo "Skipped $skipped whose folder doesn't exist on this branch"
    fi

    allow_envrcs "${envrcs[@]}"
}

# Show the differences between two files, using delta if it's installed
show_diff() {
    if command -v delta >/dev/null 2>&1; then
        delta --paging=never "$1" "$2"
    else
        diff -u "$1" "$2"
    fi
}

# Before a worktree is removed, offer to copy back any .worktreeinclude files that were
# changed (or created) in it, so edits to e.g. an .envrc aren't lost
sync_back_includes() {
    local root=$1 worktree=$2 main entry answer envrcs=()

    main=$(default_worktree) || return 0
    [ "$(cd "$worktree" && pwd -P)" = "$(cd "$main" && pwd -P)" ] && return 0
    load_include_patterns "$root" "$main" || return 0

    while IFS= read -r -d '' entry; do
        # Only single files; folders like .terraform are caches, not something to copy back
        if [ ! -f "$worktree/$entry" ] || [ -L "$worktree/$entry" ]; then
            continue
        fi
        if [ -f "$main/$entry" ] && cmp -s "$worktree/$entry" "$main/$entry"; then
            continue
        fi

        if ! (: </dev/tty) 2>/dev/null; then
            err "$entry differs from $main, but there's no terminal to ask about copying it back."
            continue
        fi

        if [ -f "$main/$entry" ]; then
            echo "$entry has changed in this worktree:"
            show_diff "$main/$entry" "$worktree/$entry"
        else
            echo "$entry exists in this worktree but not in $main"
        fi

        printf "Copy %s back to %s? [y/N] " "$entry" "$main"
        read -r answer </dev/tty

        if [[ "$answer" =~ ^[Yy]$ ]]; then
            if mkdir -p "$main/$(dirname "$entry")" && /bin/cp -p "$worktree/$entry" "$main/$entry"; then
                echo "Copied $entry back"
                [ "$(basename "$entry")" = ".envrc" ] && envrcs+=("$main/$entry")
            else
                err "Could not copy $entry back"
            fi
        fi
    done < <(list_includes "$worktree")

    allow_envrcs "${envrcs[@]}"
}

cmd_list() {
    git worktree list "$@"
}

cmd_move() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        err "Missing worktree or new path."
        echo "Usage: worktree move <worktree> <new-path>" >&2
        exit 1
    fi

    ROOT=$(repo_root) || exit 1
    OLD_PATH=$(abs_path "$1")

    git worktree move "$@" || exit 1

    # Tidy up folders left empty by the move (e.g. feature/ after moving feature/x)
    [ -n "$OLD_PATH" ] && remove_empty_parents "$(dirname "$OLD_PATH")" "$ROOT"

    echo "Moved $1 to $2"
}

# Print the paths in 'git worktree list --porcelain' output $1, one per line
worktree_paths() {
    awk '/^worktree /{print substr($0, 10)}' <<<"$1"
}

# Look up the branch for worktree path $1 in 'git worktree list --porcelain' output $2
branch_for_worktree() {
    local target=$1 path line

    while IFS= read -r line; do
        case "$line" in
            "worktree "*) path=${line#worktree } ;;
            "branch refs/heads/"*)
                if [ "$path" = "$target" ]; then
                    echo "${line#branch refs/heads/}"
                    return 0
                fi
                ;;
        esac
    done <<<"$2"

    return 1
}

cmd_remove() {
    DELETE_BRANCH=""
    GIT_ARGS=()
    WORKTREE_PATH=""

    for arg in "$@"; do
        if [ "$arg" = "--delete-branch" ]; then
            DELETE_BRANCH=1
        elif [ "$arg" = "--verbose" ]; then
            VERBOSE=1
        else
            if [ -z "$WORKTREE_PATH" ] && [[ "$arg" != -* ]]; then
                WORKTREE_PATH=$arg
            fi
            GIT_ARGS+=("$arg")
        fi
    done

    if [ -z "$WORKTREE_PATH" ]; then
        err "Missing worktree path."
        echo "Usage: worktree remove [--delete-branch] [--verbose] <path> [args]" >&2
        exit 1
    fi

    ROOT=$(repo_root) || exit 1

    if [ -d "$WORKTREE_PATH" ]; then
        sync_back_includes "$ROOT" "$WORKTREE_PATH"
    fi

    BEFORE=$(git worktree list --porcelain)

    git worktree remove "${GIT_ARGS[@]}" || exit 1

    # git matches <path> against its registered worktrees rather than our cwd (so
    # feat/x works from inside master/), so diff the lists to see which one went
    REMOVED_PATH=$(comm -23 <(worktree_paths "$BEFORE" | sort) \
        <(worktree_paths "$(git worktree list --porcelain)" | sort))
    BRANCH=""

    if [ -n "$REMOVED_PATH" ]; then
        BRANCH=$(branch_for_worktree "$REMOVED_PATH" "$BEFORE")
        # Tidy up folders left empty by the removal (e.g. feature/ after removing feature/x)
        remove_empty_parents "$(dirname "$REMOVED_PATH")" "$ROOT"
    fi

    echo "Removed worktree $WORKTREE_PATH"

    if [ -n "$DELETE_BRANCH" ]; then
        if [ -z "$BRANCH" ]; then
            err "Worktree wasn't on a branch, so there was no branch to delete."
            exit 1
        fi

        # -d refuses to delete unmerged work; say how to force it rather than doing so
        if git branch -d "$BRANCH"; then
            echo "Deleted branch $BRANCH"
        else
            err "Branch '$BRANCH' was kept because it has unmerged changes."
            echo "If you're sure, delete it with: git branch -D $BRANCH" >&2
            exit 1
        fi
    fi
}

cmd_prune() {
    git worktree prune "$@"
}

cmd_repair() {
    git worktree repair "$@"
}

# Make sure git is installed and new enough (2.31+ for rev-parse --path-format)
MIN_GIT_MAJOR=2
MIN_GIT_MINOR=31

check_git_version() {
    if ! command -v git >/dev/null 2>&1; then
        err "git is not installed."
        exit 1
    fi

    local version major minor
    version=$(git --version | awk '{print $3}')
    major=$(echo "$version" | cut -d. -f1)
    minor=$(echo "$version" | cut -d. -f2)

    if ! [[ "$major" =~ ^[0-9]+$ && "$minor" =~ ^[0-9]+$ ]]; then
        err "Could not work out the git version from '$(git --version)'."
        exit 1
    fi

    if [ "$major" -lt "$MIN_GIT_MAJOR" ] || { [ "$major" -eq "$MIN_GIT_MAJOR" ] && [ "$minor" -lt "$MIN_GIT_MINOR" ]; }; then
        err "git $MIN_GIT_MAJOR.$MIN_GIT_MINOR or newer is required (you have $version)."
        exit 1
    fi
}

invalid() {
    printf "worktree: '%s' is not a valid command.\n\n" "$1"
    usage
    exit 1
}

VERBOSE=""

COMMAND=$1
shift

case "$COMMAND" in
    ""|-h|--help|help) ;;
    *) check_git_version ;;
esac

case "$COMMAND" in
    init)   cmd_init "$@";;
    add)    cmd_add "$@";;
    list)   cmd_list "$@";;
    move)   cmd_move "$@";;
    remove) cmd_remove "$@";;
    prune)  cmd_prune "$@";;
    repair) cmd_repair "$@";;
    -h|--help|help|"") usage;;
    *) invalid "$COMMAND";;
esac
