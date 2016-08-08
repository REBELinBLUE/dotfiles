function e_success
    set -l normal (set_color normal)
    set -l green (set_color green)

    echo -n $green
    printf "✔ %s" "$argv"
    echo $normal
end
