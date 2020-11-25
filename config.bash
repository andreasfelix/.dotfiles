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
PS1='\033[1;31m\u \033[0mat \033[1;34m\h \033[0min \033[1;36m$PWD\033[0m$(__git_ps1 " on \033[1;33m%s\033[0m")\n '
PS2='>'

# enable zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# enable direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi
