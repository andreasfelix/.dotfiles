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
export PS1='\e[1;31m\u \e[0mat \e[1;34m\h \e[0min \e[1;36m$PWD $(__git_ps1 "\e[0mon \e[1;33m%s")\e[0m\n '
export PS2='>'

# enable zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# enable direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi
