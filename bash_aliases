# edit run commands
alias avim='vim $HOME/.bash_aliases'
alias bvim='vim $HOME/.bashrc'
alias cvim='vim $HOME/.bash_custom'
alias gvim='vim $HOME/.gitconfig'
alias ivim='vim $HOME/.inputrc'
alias ivvim='vim $HOME/.ideavimrc'
alias pvim='vim $HOME/.bash_private'
alias vvim='vim $HOME/.vimrc'
alias vscvim='vim $HOME/.config/Code/User/settings.json'

# useful shortcuts
alias cdb='builtin cd'
cd() { builtin cd "$@" && clear && ls ; }
ca() { builtin cd "$@" && clear && ls -A ; }
alias c='cd'
alias cd..='cd ..'
alias ..='cd ..'
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
tg() { touch $1; git add $1; git commit -m "$1"; }

# python
alias py="$HOME/anaconda3/bin/python"
alias ipy="$HOME/anaconda3/bin/ipython"
alias pm="py manage.py"

# flask
frun() {
    export FLASK_APP=$1
    export FLASK_ENV=development
    flask run --host=0.0.0.0
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
