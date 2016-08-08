function e_error
    set -l normal (set_color normal)
    set -l red (set_color red)

    echo -n $red
    printf "✖ %s" "$argv"
    echo $normal
end
