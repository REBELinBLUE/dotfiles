function ll --wraps=ls
    set -l path "."

    if count $argv > /dev/null
        set path "$argv"
    end

    command ls -l --color=auto --quoting-style=literal "$path"
end
