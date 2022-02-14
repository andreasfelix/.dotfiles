# custom bash config
#
# add this to .bashrc
# if [ -f ~/.bash_config ]; then
#     . ~/.bash_config
# fi

# bash options
stty -ixon      # disable terminal scroll lock (Ctrl+S/Ctrl+q)
shopt -s autocd # auto change directories

# enable starship
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    # prompt: <user> at <host> in /path/to/cwd on <branch>
    PS1='\033[1;31m\u\033[0m at \033[1;34m\h\033[0m in \033[1;36m$PWD\033[0m$(__git_ps1 " on \033[1;33m%s\033[0m")\n '
    PS2='>'
fi

# enable zoxide
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# enable direnv
if command -v direnv &>/dev/null; then
    eval "$(direnv hook bash)"
fi

# enable fzf
if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
  export FZF_DEFAULT_COMMAND='fd'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
