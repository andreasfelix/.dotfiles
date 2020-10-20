# useful shell aliases
alias rebash='exec sudo -u $USER bash'
alias reshell='exec sudo --login --user $USER'
alias view_changed_packages='sudo debsums -c | xargs -rd '\n' -- dpkg -S | cut -d : -f 1 | sort -u'

# file management
alias l='clear && ls -alFh'
c() { builtin cd "$@" && clear && ll ; }
# alias bcd='builtin cd'
# alias c='cd'
alias cd..='cd ..'
alias ..='cd ..'
alias ...="cd ../.."
alias ....="cd ../../.."
alias cd-='cd -'
mkcd() { mkdir -p "$1" && cd "$1" ; }
alias open='xdg-open'
alias trash='gio trash'

# elementary
export G_MESSAGES_DEBUG=all
files() { nohup io.elementary.files -t $([ $# -gt 0 ] && echo "$@" || echo "." ) &>/dev/null & }
alias ebuild="rm -rf build ; meson build --prefix=/usr && ninja -C build"
# alias reinstall_granite="sudo apt install --reinstall gir1.2-granite-1.0 granite-demo libgranite-common libgranite-dev libgranite5"
# alias reinstall_gala="sudo apt install --reinstall gala libgala0 libgala-dev"

# docker
alias docker-remove-all-container='docker rm $(docker ps -aq)'
alias docker-remove-all-images='docker rmi $(docker images -a -q)'
alias docker-remove-untagged-images='docker rmi $(docker images -q --filter "dangling=true")'

# python
pydis() { echo "$@" | python -m dis; }
alias pytime="python -m timeit"
alias py="python"
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"
alias pylab="ipython --pylab"

# flask
frun() { FLASK_APP=$1 FLASK_ENV=development flask run --host=0.0.0.0 }

# misc
alias dfs='df -hx"squashfs"' # dont show snaps
ch() { curl cheat.sh/$1; }
alias screenkey='unset XMODIFIERS ; unset GTK_IM_MODULES; unset QT_IM_MODULES; /usr/bin/screenkey'
watch-cpu() { watch -n 0.5 $'mpstat 1 1 | awk \'/^Average/ {print 100-$NF,"%"}\''; }
alias activate-canon="gphoto2 --stdout --capture-movie | ffmpeg -i - -vf format=yuv420p -f v4l2 /dev/video0"
svg2png() { for file in *.svg; do inkscape -d=768 $file -e ${file%svg}png; done ; }
alias record-gif='ffmpeg -video_size 1920x1080 -f x11grab -i :0.0+0,420 -y video.gif -vf "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0'

# edit config files
alias avim='vim $HOME/.bash_aliases'
alias bvim='vim $HOME/.bashrc'
alias cvim='vim $HOME/.bash_custom'
alias gvim='vim $HOME/.gitconfig'
alias hvim='vim $HOME/.config/nixpkgs/home.nix'
alias pvim='vim $HOME/.bash_private'
alias svim='vim $HOME/.ssh/config'
alias vvim='vim $HOME/.config/nvim/init.vim'
