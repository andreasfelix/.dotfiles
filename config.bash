# add this to .bashrc
# if [ -f ~/.bash_config ]; then
#     . ~/.bash_config
# fi

stty -ixon      # disable terminal scroll lock (Ctrl+S/Ctrl+q)
shopt -s autocd # auto change directories

# prompt: user at host in /path/to/cwd on branch
source $HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh
export PS1='\e[36m\u \e[0mat \h in \e[34m$PWD $(__git_ps1 "\e[0mon \e[33m%s")\n '
export PS2=">"
