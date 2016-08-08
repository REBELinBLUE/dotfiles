function l1 --wraps=ls
    set -l path "."

    if count $argv > /dev/null
        set path "$argv"
    end

    command ls -1 --color=auto --quoting-style=literal "$path"
end
