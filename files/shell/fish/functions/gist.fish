# Open gists in browser
function gist --wraps=gist
    command gist -o -p $argv
end
