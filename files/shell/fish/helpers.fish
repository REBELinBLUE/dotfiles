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
