# Completions for the worktree function (scripts/worktree.sh)

set -l __worktree_commands init add list move remove prune repair help

# Count the positional (non-option) arguments typed after the subcommand
function __worktree_arg_count
    set -l tokens (commandline -opc)
    set -l count 0
    set -l skip_next 0
    for token in $tokens[3..-1]
        if test $skip_next -eq 1
            set skip_next 0
            continue
        end
        if test "$token" = --from
            set skip_next 1
            continue
        end
        string match -q -- '-*' $token; or set count (math $count + 1)
    end
    echo $count
end

# True if the current subcommand is $argv[1] and $argv[2] positional args have been typed
function __worktree_at_arg
    __fish_seen_subcommand_from $argv[1]; or return 1
    test (__worktree_arg_count) -eq $argv[2]
end

# Local branches plus origin's branches (without the origin/ prefix), for 'add'
function __worktree_branches
    begin
        git for-each-ref --format='%(refname:short)' refs/heads/ 2>/dev/null
        git for-each-ref --format='%(refname:short)' refs/remotes/origin/ 2>/dev/null \
            | string replace -r '^origin/' '' | string match -v -r '^(origin|HEAD)$'
    end | sort -u
end

# Worktree paths (relative to the current folder when inside the repo), with their branch as description
function __worktree_paths
    set -l common (git rev-parse --path-format=absolute --git-common-dir 2>/dev/null); or return
    set -l root (path dirname -- $common)
    set -l path
    git worktree list --porcelain 2>/dev/null | while read -l line
        switch $line
            case 'worktree *'
                set path (string replace -- 'worktree ' '' $line)
            case bare
                set path ''
            case 'branch *' detached
                test -n "$path"; or continue
                printf '%s\t%s\n' (__worktree_relative $path $root) (string replace -- 'branch refs/heads/' '' $line)
                set path ''
        end
    end
end

# Make $argv[1] relative to $PWD, walking up no further than $argv[2] (the repo root)
function __worktree_relative
    set -l target $argv[1]
    set -l root $argv[2]
    set -l dir (path resolve -- $PWD)
    set -l up ''

    while true
        if test "$target" = "$dir"
            if test -n "$up"
                string replace -r '/$' '' -- $up
            else
                echo .
            end
            return
        else if string match -q -- "$dir/*" $target
            echo $up(string replace -- "$dir/" '' $target)
            return
        end
        if test "$dir" = "$root"; or test "$dir" = /
            break
        end
        set dir (path dirname -- $dir)
        set up "../$up"
    end

    echo $target
end

complete -c worktree -f

# Subcommands
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a init -d 'Create a bare repo setup with a default branch worktree'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a add -d 'Add a worktree for a branch'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a list -d 'List worktrees'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a move -d 'Move a worktree'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a remove -d 'Remove a worktree'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a prune -d 'Prune stale worktrees'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a repair -d 'Fix worktree links after moving them by hand'
complete -c worktree -n "not __fish_seen_subcommand_from $__worktree_commands" -a help -d 'Show usage'

# init <repo-url> [folder]
complete -c worktree -n '__worktree_at_arg init 1' -F

# add [--verbose] [--from <ref>] <branch> [path]
complete -c worktree -n '__worktree_at_arg add 0' -a '(__worktree_branches)'
complete -c worktree -n '__worktree_at_arg add 1' -a '(__fish_complete_directories)'
complete -c worktree -n '__fish_seen_subcommand_from add' -l verbose -d 'List each path copied and direnv allow run'
complete -c worktree -n '__fish_seen_subcommand_from add' -l from -r -d 'Base a new branch on this ref instead of the default branch' -a '(__worktree_branches)'

# list [args]
complete -c worktree -n '__fish_seen_subcommand_from list' -l porcelain -d 'Machine-readable output'
complete -c worktree -n '__fish_seen_subcommand_from list' -s v -l verbose -d 'Show extra details'
complete -c worktree -n '__fish_seen_subcommand_from list' -s z -d 'NUL-terminate lines (with --porcelain)'
complete -c worktree -n '__fish_seen_subcommand_from list' -l expire -r -d 'Annotate missing worktrees older than <time> as prunable'

# move <worktree> <new-path>
complete -c worktree -n '__worktree_at_arg move 0' -a '(__worktree_paths)'
complete -c worktree -n '__worktree_at_arg move 1' -a '(__fish_complete_directories)'
complete -c worktree -n '__fish_seen_subcommand_from move' -s f -l force -d 'Move even if locked'

# remove [--delete-branch] [--verbose] <path> [args]
complete -c worktree -n '__worktree_at_arg remove 0' -a '(__worktree_paths)'
complete -c worktree -n '__fish_seen_subcommand_from remove' -l delete-branch -d 'Also delete the local branch'
complete -c worktree -n '__fish_seen_subcommand_from remove' -l verbose -d 'Report each direnv allow run'
complete -c worktree -n '__fish_seen_subcommand_from remove' -s f -l force -d 'Remove even with changes or untracked files'

# prune [args]
complete -c worktree -n '__fish_seen_subcommand_from prune' -s n -l dry-run -d 'Show what would be pruned'
complete -c worktree -n '__fish_seen_subcommand_from prune' -s v -l verbose -d 'Report all removals'
complete -c worktree -n '__fish_seen_subcommand_from prune' -l expire -r -d 'Only prune worktrees older than <time>'

# repair [path...]
complete -c worktree -n '__fish_seen_subcommand_from repair' -a '(__fish_complete_directories)'
