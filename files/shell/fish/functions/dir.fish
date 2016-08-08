function dir --wraps=ls
    set -l path "."

    if count $argv > /dev/null
        set path "$argv"
    end

    command dir -F -G --color=auto --quoting-style=literal "$path"
end
