# custom bash config
#
# add this to .bashrc
# if [ -f ~/.bash_config ]; then
#     . ~/.bash_config
# fi

# bash options
stty -ixon      # disable terminal scroll lock (Ctrl+S/Ctrl+q)
shopt -s autocd # auto change directories

# prompt: <user> at <host> in /path/to/cwd on <branch>
PS1='\033[1;31m\u \e[0mat \e[1;34m\h \e[0min \e[1;36m$PWD\e[0m$(__git_ps1 " on \e[1;33m%s\e[0m")\n '
PS2='>'

# enable zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# enable direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi
