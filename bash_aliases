# edit run commands
alias avim='vim $HOME/.bash_aliases'
alias bvim='vim $HOME/.bashrc'
alias cvim='vim $HOME/.bash_custom'
alias fvim='vim $HOME/.config/fish/config.fish'
alias gvim='vim $HOME/.gitconfig'
alias ivim='vim $HOME/.inputrc'
alias ivvim='vim $HOME/.ideavimrc'
alias pvim='vim $HOME/.bash_private'
alias vvim='vim $HOME/.vimrc'
alias vscvim='vim $HOME/.config/Code/User/settings.json'

# file management
alias ll='clear && ls -alFh'
alias bcd='builtin cd'
cd() { builtin cd "$@" && clear && ls -a ; }
alias c='cd'
alias cd..='cd ..'
alias ..='cd ..'
alias cd-='cd -'
cdg() { cd $HOME/Git ; [ -n "$1" ] && cd $1 ; }
mkcd() { mkdir $1 && cd $1 ; }
alias trash='gio trash'
alias tra='gio trash'
alias open='xdg-open'

# useful shortcuts
alias rebash='exec sudo -u $USER bash'
alias type='builtin type -a'
alias childs='pstree -pauls $$'
alias view_changed_packages="sudo debsums -c | xargs -rd '\n' -- dpkg -S | cut -d : -f 1 | sort -u"

# git
alias g='git'
source /usr/share/bash-completion/completions/git
__git_complete g __git_main
tg() { touch $1 && git add $1 && git commit -m "$1"; }

# docker
alias d='docker'
source /usr/share/bash-completion/completions/docker
complete -F _docker d
alias drm='docker rm $(docker ps -aq)'

# python
alias py="python"
alias ipy="ipython"
alias pytime="python -m timeit"
pydis() { echo "$@" | python -m dis; }
alias npy='python -ic "from numpy import *;import numpy as np"'
alias pm="py manage.py"

# elementary
files() { nohup io.elementary.files -t $([ $# -gt 0 ] && echo "$@" || echo "." ) &>/dev/null & }
lfiles() { nohup pantheon-files -t $([ $# -gt 0 ] && echo "$@" || echo "." ) &>/dev/null & }
alias reinstall_granite="sudo apt install --reinstall gir1.2-granite-1.0 granite-demo libgranite-common libgranite-dev libgranite5"
alias reinstall_gala="sudo apt install --reinstall gala libgala0 libgala-dev"
alias bmeson="rm -rf build ; meson build --prefix=/usr && ninja -C build"
alias idvim="vim $HOME/Git/eOS/ideas/ideas.md"
export G_MESSAGES_DEBUG=all

# flask
frun() {
  export FLASK_APP=$1
  export FLASK_ENV=development
  flask run --host=0.0.0.0
}

# browser-sync
alias bsserve="browser-sync start --server --no-notify --files ."
alias bsproxy="browser-sync start --proxy 127.0.0.1:8000 --files . --no-notify"
alias bsproxy300="browser-sync start --proxy 127.0.0.1:8000 --files . --no-notify --reload-delay=300"

# misc
alias dfs='df -hx"squashfs"' # dont show snaps
ch() { curl cheat.sh/$1; }
alias screenkey='unset XMODIFIERS ; unset GTK_IM_MODULES; unset QT_IM_MODULES; /usr/bin/screenkey'
# alias code='/var/lib/flatpak/exports/bin/com.visualstudio.code'
