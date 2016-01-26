extract () {
    if [ $# -ne 1 ]; then
        echo "Error: No file specified."
        return 1
    fi

    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

explain () {
    if [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

# function usage ()
# {
#     if [ -n $1 ]; then
#         du -hd $1
#     else
#         du -hd 1
#     fi
# }

export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/Applications/VirtualBox.app/Contents/MacOS:/usr/local/sbin:$PATH"
export PATH="~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:~/.composer/vendor/bin:$PATH"
export PATH="$(brew --prefix findutils)/bin:$PATH"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
export EDITOR="nano -w"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768;
export HISTFILESIZE=${HISTSIZE};
export HISTCONTROL=ignoredups:erasedups;

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

export LANG="en_GB.UTF-8";
export LC_ALL="en_GB.UTF-8";

black=$(tput -Txterm setaf 0)
red=$(tput -Txterm setaf 1)
green=$(tput -Txterm setaf 2)
yellow=$(tput -Txterm setaf 3)
dk_blue=$(tput -Txterm setaf 4)
pink=$(tput -Txterm setaf 5)
lt_blue=$(tput -Txterm setaf 6)

bold=$(tput -Txterm bold)
reset=$(tput -Txterm sgr0)

alias ls='ls -F -G --color=auto'
alias dir='dir -F -G --color=auto'
alias ll='ls -l --color=auto'
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'
alias grep='grep --color=auto -in'
alias _='sudo'
alias l1='ls -1'
alias sl=ls

alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias flush='dscacheutil -flushcache'
alias dsclean='find . -type f -name .DS_Store -delete'
alias showhidden='defaults write com.apple.finder AppleShowAllFiles TRUE'
alias hidehidden='defaults write com.apple.finder AppleShowAllFiles FALSE'

function parse_vagrant_status {
    if [[ ! -a 'Vagrantfile' ]]; then
        return
    fi

    status=`vagrant status 2>&1`

    if [[ -n `echo ${status} | grep "poweroff"` ]]; then
        echo "-[\[$pink\]vagrant \[$yellow\]●\[$black\]]"
    fi

    if [[ -n `echo ${status} | grep "running"` ]]; then
        echo "-[\[$pink\]vagrant \[$green\]✔\[$black\]]"
    fi

    if [[ -n `echo ${status} | grep "aborted"` ]]; then
        echo "-[\[$pink\]vagrant \[$red\]✘\[$black\]]"
    fi

    return
}

# function prompt_callback {
#     parse_vagrant_status
# }

if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
    source `brew --prefix`/etc/bash_completion.d/vagrant
fi

if [ -f `brew --prefix`/etc/bash_completion ]; then
    source `brew --prefix`/etc/bash_completion
fi

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Default
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_PREFIX='-['
    GIT_PROMPT_SUFFIX='\[$black\]]'
    GIT_PROMPT_LEADING_SPACE=0
    GIT_PROMPT_SEPARATOR=' '

    GIT_PROMPT_START='\n\[$bold\]\[$black\][\[$dk_blue\]\@\[$black\]]-[\[$green\]\u\[$yellow\]@\[$green\]\h\[$black\]]-[\[$pink\]\]\w\[$black\]]'
    GIT_PROMPT_END='\[$reset\]\n\[$reset\]\$ '

    source `brew --prefix bash-git-prompt`/share/gitprompt.sh
fi