function e_header
    set -l normal (set_color normal)
    set -l magenta (set_color magenta -o)

    echo $magenta
    printf "==========  %s  ==========" "$argv"
    echo $normal
end
