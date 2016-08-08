function e_warning
    set -l normal (set_color normal)
    set -l yellow (set_color yellow)

    echo -n $yellow
    printf "➜ %s" "$argv"
    echo $normal
end
