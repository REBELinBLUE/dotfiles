


# Make nano the default editor.
export EDITOR='nano -w'

# Default log level for NPM
export NPM_CONFIG_LOGLEVEL='error'

# Easier navigation ~ and -
alias -- -='cd -'        # Go back
alias ~='cd ~'           # `cd` is probably faster to type though

# List files
alias ls='ls -F -G --color=auto --quoting-style=literal'
alias ll='ls -l --color=auto --quoting-style=literal'
alias la='ls -lA --color=auto --quoting-style=literal'
alias l1='ls -1 --color=auto --quoting-style=literal'
alias sl='ls'

# Prompt for confirmation
alias cp='cp -iv'
alias rm='rm -i'
alias mv='mv -iv'

# Other useful aliases
alias grep='grep --color=auto -in'

# Add edit alias
alias edit=$EDITOR

# Add computer and node to path
export PATH="~/.composer/vendor/bin:$PATH"
export PATH="./vendor/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# Add a composer alias which looks for composer in . if it isn't installed globally
if [[ ! $(type -P composer) ]]; then
     alias composer='php composer.phar'
fi

CLI_RED=$(tput -Txterm-256color setaf 1)
CLI_GREEN=$(tput -Txterm-256color setaf 2)
CLI_YELLOW=$(tput -Txterm-256color setaf 3)
CLI_BLUE=$(tput -Txterm-256color setaf 4)
CLI_MAGENTA=$(tput -Txterm-256color setaf 5)
CLI_RESET=$(tput -Txterm-256color sgr0)

# A function to allow cd ../../../.. to be cd ..... instead
cd() {
    if [[ "$1" =~ ^\.\.+$ ]]; then
        local a dir;
        a=${#1};

        while [ $a -ne 1 ]; do
            dir=${dir}"../";
            ((a--));
        done

        builtin cd $dir;
    else
        builtin cd "$@";
    fi
}

export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:history:clear:reset:_su"

# Use /etc/is_vagrant_vm to test if vagrant and if so use yellow not red for the user/host
HOST_COLOR=$CLI_RED
if [ -f /etc/is_vagrant_vm ]; then
    HOST_COLOR=$CLI_YELLOW
fi

# Fix Behat colours
export BEHAT_PARAMS='{"formatters": {"pretty": {"output_styles": {"comment": ["blue"]}}}}'

# FIXME: This is just horrible and is only used at work
if [ -f /etc/is_vagrant_vm ]; then
    # FIXME: Do this automatically and use the correct work email
    function _gituser() {
        git config --global user.name "Stephen Ball"
        git config --global user.email "stephen@rebelinblue.com"
    }

    function _su() {
        service=`/bin/ls /home | /bin/grep -v ubuntu | /bin/grep -v vagrant`

        sudo su - $service;
        sudo service $service restart;

        if [ -f /home/$service/.venv ]; then
            source /home/$service/.venv
        fi
    }

    #function _su() {
    #    user=`/bin/ls /home | /bin/grep -v ubuntu | /bin/grep -v vagrant`
    #    chmod -R 0777 $SSHHOME;
    #    sudo touch /home/$user/.bash_profile;

    #    sudo sh -c "echo \" cp -f $SSHHOME/.sshrc.d/.gitconfig ~/.gitconfig
    #                cp -f $SSHHOME/.sshrc.d/.gitignore ~/.gitignore_global
    #                cp -f $SSHHOME/.sshrc.d/.gitignore ~/.gitignore_global
    #                git config --global --unset diff.orderfile
    #                git config --global --unset merge.tool
    #                git config --global --remove-section pager
    #                git config --global --remove-section mergetool.chdiff
    #                git config --global --remove-section difftool.chdiff
    #                source $SSHHOME/.sshrc
    #                source /home/$user/.bashrc

    #                cd ~

    #                if [ -d /home/$user/tmp ]; then
    #                    export TMP=/home/$user/tmp
    #                    export TMPDIR=/home/$user/tmp
    #                    export TEMP=/home/$user/tmp
    #                fi

    #                if [ -f /home/$user/.venv ]; then
    #                    source /home/$user/.venv
    #                fi

    #                clear\" > /home/$user/.bash_profile";

    #    #sudo chown $user /home/$user/.bash_profile;
    #    sudo chown $user /home/$user/.gitconfig /home/$user/.gitignore_global;
    #    sudo chmod 664 /home/$user/.gitconfig /home/$user/.gitignore_global;
    #    sudo su - $user;
    #}
fi


# Use a folder in home for bash git prompt unless it is installed in /opt or we are running in vagrant
GIT_PROMPT=$HOME/.bash-git-prompt
if [ -d /opt/bash-git-prompt ] || [ -f /etc/is_vagrant_vm ]; then
    GIT_PROMPT=/opt/bash-git-prompt
fi

if [ -f ${GIT_PROMPT}/gitprompt.sh ]; then
    GIT_PROMPT_ONLY_IN_REPO=0
    GIT_PROMPT_PREFIX=" ${CLI_RESET}on "
    GIT_PROMPT_SUFFIX="${CLI_RESET}"
    GIT_PROMPT_LEADING_SPACE=0
    GIT_PROMPT_SEPARATOR=' '
    GIT_PROMPT_BRANCH="${CLI_BLUE}"

    GIT_PROMPT_START="\n${HOST_COLOR}\u ${CLI_RESET}at ${HOST_COLOR}\h ${CLI_RESET}in ${CLI_MAGENTA}\w${CLI_RESET}"
    GIT_PROMPT_END="${CLI_RESET}\n\$ "

    source /opt/bash-git-prompt/gitprompt.sh
else
    function _parse_git_dirty() {
        [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
    }

    function _parse_git_branch() {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(_parse_git_dirty)/"
    }

    function _install_git_prompt() {
        #_gitconfig
        ssh-keyscan -t rsa,dsa -H github.com >> ~/.ssh/known_hosts
        echo -e "${CLI_YELLOW}➜ Downloading bash-git-prompt${CLI_RESET}";
        sudo git clone https://github.com/magicmonty/bash-git-prompt.git $GIT_PROMPT --depth=1
        reset
        source $SSHHOME/sshrc.bashrc

        echo -e "${CLI_GREEN}✔ bash-git-prompt setup!${CLI_RESET}";
    }

    echo -e "${CLI_RED}✖ bash-git-prompt is not installed, run _install_git_prompt to install it followed by _gituser ${CLI_RESET}";

    export PS1="\n${HOST_COLOR}\u ${CLI_RESET}at ${HOST_COLOR}\h ${CLI_RESET}in ${CLI_MAGENTA}\w${CLI_RESET}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")${CLI_BLUE}\$(_parse_git_branch)${CLI_RESET}\n$ ${CLI_RESET}"
    export PS2="> "
fi
