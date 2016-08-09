function e_arrow
    printf "➜ $argv\n"
end

function e_header
    set -l normal (set_color normal)
    set -l magenta (set_color magenta -o)

    echo $magenta
    printf "==========  %s  ==========" "$argv"
    echo $normal
end

function e_error
    set -l normal (set_color normal)
    set -l red (set_color red)

    echo -n $red
    printf "✖ %s" "$argv"
    echo $normal
end

function e_success
    set -l normal (set_color normal)
    set -l green (set_color green)

    echo -n $green
    printf "✔ %s" "$argv"
    echo $normal
end

function e_warning
    set -l normal (set_color normal)
    set -l yellow (set_color yellow)

    echo -n $yellow
    printf "➜ %s" "$argv"
    echo $normal
end

function e_underline
    set -l normal (set_color normal)
    set -l underline (set_color -u)

    echo -n $underline
    printf "%s" "$argv"
    echo $normal
end

function e_bold
    set -l normal (set_color normal)
    set -l bold (set_color -o)

    echo -n $bold
    printf "%s" "$argv"
    echo $normal
end

function e_note
    set -l normal (set_color normal)
    set -l underline (set_color -u)
    set -l note (set_color -o blue)

    echo -n $underline
    echo -n $note
    echo -n "Note"
    echo -n $normal
    echo -n $note
    printf ": %s" "$argv"
    echo $normal
end

function e_tabbed
    set -l normal (set_color normal)
    set -l yellow (set_color yellow)

    printf "$yellow%-25s$normal%s\n" $argv[1] $argv[2]
end

function e_help
    e_header "I am a header message - e_header"
    e_success "I am a success message - e_success"
    e_error "I am an error message - e_error"
    e_warning "I am a warning message - e_warning"
    e_underline "I am underlined text - e_underline"
    e_bold "I am bold text - e_bold"
    e_note "I am a note - e_note"
    e_tabbed "e_tabbed" "I am a tabbed item"
end
