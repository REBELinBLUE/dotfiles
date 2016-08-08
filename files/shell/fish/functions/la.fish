function la --wraps=ls
    set -l path "."

    if count $argv > /dev/null
        set path $argv
    end

    command ls -lA --color=auto --quoting-style=literal $path
end
