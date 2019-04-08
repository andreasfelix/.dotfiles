# edit run commands
alias avim='vim $HOME/.bash_aliases'
alias bvim='vim $HOME/.bashrc'
alias cvim='vim $HOME/.bash_custom'
alias gvim='vim $HOME/.gitconfig'
alias vvim='vim $HOME/.vimrc'
alias ivvim='vim $HOME/.ideavimrc'
alias vscvim='vim $HOME/.config/Code/User/settings.json'

# useful shortcuts
alias cdo='builtin cd'
cd() { builtin cd "$@" && clear && ls -A; }
alias c='cd'
alias cd..='cd ..'
alias ..='c ..'
ca() { builtin cd $1 && ls -A ; }
cdg() { cd $HOME/Git ; [ -n "$1" ] && cd $1 ; }
mkdircd() { mkdir $1 && cd $1 ; }
alias type='type -a'
alias trash='gio trash'
alias tra='gio trash'
alias open='xdg-open'
alias dfs='df -x"squashfs"' # dont show snaps

# git
alias g='git'
alias ggraph='git log --all --decorate --oneline --graph'
tg() { touch $1; git add $1; git commit -m"$1"; }

# python
alias py="$HOME/anaconda3/bin/python"
alias ip="$HOME/anaconda3/bin/ipython"
alias pm="py manage.py"

# flask
runflask() {
    export FLASK_APP=$1
    export FLASK_ENV=development
    flask run
}



# vala
bmeson() {
    if (rm -rf build ; meson build --prefix=/usr); then
        if cd build && ninja ; then
            [ -n "$1" ] && ./$1
        fi
        cd ..
    fi
}

# browser-sync
alias bsserve="browser-sync start --server --files . --no-notify"
alias bsproxy="browser-sync start --proxy 127.0.0.1:8000 --files . --no-notify"
alias bsproxy300="browser-sync start --proxy 127.0.0.1:8000 --files . --no-notify --reload-delay=300"
