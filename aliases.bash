# useful shell aliases
alias rebash='exec sudo -u $USER bash'
alias reshell='exec sudo --login --user $USER'
alias view_changed_packages='sudo debsums -c | xargs -rd '\n' -- dpkg -S | cut -d : -f 1 | sort -u'

# file management
c() { builtin cd "$@" && clear && ll ; }
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd-='cd -'
mkcd() { mkdir -p "$1" && cd "$1" ; }
alias open='xdg-open'
alias trash='gio trash'
if command -v exa &> /dev/null; then
  alias ll='exa --git -alFhg'
  alias lt='exa --git -alFhgT'
else
  alias ll='ls -alFh'
fi

# elementary
alias gdebug="export G_MESSAGES_DEBUG=all"
files() { nohup io.elementary.files -t $([ $# -gt 0 ] && echo "$@" || echo "." ) &>/dev/null & }
alias ebuild="rm -rf build ; meson build --prefix=/usr && ninja -C build"
# alias reinstall_granite="sudo apt install --reinstall gir1.2-granite-1.0 granite-demo libgranite-common libgranite-dev libgranite5"
# alias reinstall_gala="sudo apt install --reinstall gala libgala0 libgala-dev"

# python
alias py="python"
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"
alias pylab="ipython --pylab"
pydis() { echo "$@" | python -m dis; }
alias pytime="python -m timeit"

# docker
alias docker-remove-all-container='docker rm $(docker ps -aq)'
alias docker-remove-all-images='docker rmi $(docker images -a -q)'
alias docker-remove-untagged-images='docker rmi $(docker images -q --filter "dangling=true")'

# misc
alias activate-canon="gphoto2 --stdout --capture-movie | ffmpeg -i - -vf format=yuv420p -f v4l2 /dev/video0"
alias activate-v4l2loopback="sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2"
ch() { curl cheat.sh/$1; }
alias dfs='df -hx"squashfs"' # dont show snaps
alias record-gif='ffmpeg -video_size 1920x1080 -f x11grab -i :0.0+0,420 -y video.gif -vf "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0'
svg2png() { for file in *.svg; do inkscape -d=768 $file -e ${file%svg}png; done ; }
watch-cpu() { watch -n 0.5 $'mpstat 1 1 | awk \'/^Average/ {print 100-$NF,"%"}\''; }

# edit config files
alias avi='vim $HOME/.bash_aliases'
alias bvi='vim $HOME/.bashrc'
alias cvi='vim $HOME/.bash_config'
alias gvi='vim $HOME/.gitconfig'
alias hvi='vim $HOME/.config/nixpkgs/home.nix'
alias pvi='vim $HOME/.bash_private'
alias svi='vim $HOME/.ssh/config'
alias vvi='vim $HOME/.config/nvim/init.vim'
