function fish_prompt --description 'Write out the prompt'
    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l magenta (set_color magenta)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)

    # FIXME: See about changing to bash-git-prompt
    # https://github.com/fish-shell/fish-shell/blob/master/share/functions/__fish_git_prompt.fish
    set -g __fish_git_prompt_show_informative_status 1
    set -g __fish_git_prompt_showstashstate 1
    set -g __fish_git_prompt_show_untrackedfiles 1
    set -g __fish_git_prompt_showupstream "informative"
    set -g __fish_git_prompt_char_upstream_ahead "↑·"
    set -g __fish_git_prompt_char_upstream_behind "↓·"
    set -g __fish_git_prompt_char_upstream_prefix " "
    set -g __fish_git_prompt_char_stagedstate "●"
    set -g __fish_git_prompt_char_dirtystate "✚ "
    set -g __fish_git_prompt_char_stateseparator " "
    set -g __fish_git_prompt_char_untrackedfiles "…"
    set -g __fish_git_prompt_char_stashstate "⚑ "
    set -g __fish_git_prompt_char_conflictedstate "✖ "
    set -g __fish_git_prompt_char_cleanstate "✔"
    set -g __fish_git_prompt_color_branch blue
    set -g __fish_git_prompt_color_cleanstate green
    set -g __fish_git_prompt_color_dirtystate blue
    set -g __fish_git_prompt_color_stagedstate yellow
    set -g __fish_git_prompt_color_invalidstate red
    set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    set -g __fish_git_prompt_describe_style "describe"
    set -g __fish_git_prompt_showcolorhints 1

    set -l last_status $status

    set -g __fish_prompt_normal (set_color normal)

    set -l color_cwd
    set -l suffix

    # FIXME: Still need to fix the prompt if connected via SSH

    switch $USER
        case root toor
            set color_cwd $red
            set suffix '#'
        case '*'
            set color_cwd $magenta
            set suffix '$'
    end


    set -l cwd $magenta (pwd | sed "s:^$HOME:~:")

    set -l hostname (hostname | sed "s:.lan::")

    set -l whowhere $green (whoami) $normal ' at ' $green $hostname $normal ' in '

    # Add a newline before new prompts
    echo -e ''

    # Show username and host
    echo -n -s $whowhere

    # Print path
    echo -n -s $cwd $normal

    # Print VCS status
    echo -n -s (__fish_git_prompt ' on %s')

    if not test $last_status -eq 0
        set_color $fish_color_error
    end

    echo -e ''
    echo -e -n -s "$suffix " $normal
end
