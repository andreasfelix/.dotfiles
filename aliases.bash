# useful shell aliases
alias rebash='exec sudo -u $USER bash'
alias reshell='exec sudo --login --user $USER'
alias view-changed-packages='sudo debsums -c | xargs -rd '\n' -- dpkg -S | cut -d : -f 1 | sort -u'
alias path='echo $PATH | tr : \\n'

# file management
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd-='cd -'
alias open='xdg-open'
alias trash='gio trash'
if command -v exa &> /dev/null; then
  alias ll='exa --git -alFhg'
  alias lt='exa --git -alFhgT --git-ignore'
else
  alias ll='ls -alFh'
fi

# nix
,() { nix run nixpkgs#"$1" -- "${@:2}"; }
shell() { nix shell $(printf "nixpkgs#%s " "$@"); }
pywith() { nix shell --impure --expr "(builtins.getFlake \"nixpkgs\").legacyPackages.x86_64-linux.python39.withPackages (p: with p; [ ipython black $* ])"; }

# elementary
files() { nohup io.elementary.files -t $([ $# -gt 0 ] && echo "$@" || echo "." ) &>/dev/null & }
alias gdebug="export G_MESSAGES_DEBUG=all"
alias ebuild="rm -rf build ; meson build --prefix=/usr && ninja -C build"

# python
alias py="python"
alias ipython="ipython --TerminalInteractiveShell.editing_mode=vi"
alias pylab="ipython --pylab"
alias pytime="python -m timeit"
pydis() { echo "$@" | python -m dis; }

# docker
alias docker-remove-all-container='docker rm $(docker ps -aq)'
alias docker-remove-all-images='docker rmi $(docker images -a -q)'
alias docker-remove-untagged-images='docker rmi $(docker images -q --filter "dangling=true")'

# misc
alias activate-canon="gphoto2 --stdout --capture-movie | ffmpeg -i - -vf format=yuv420p -f v4l2 /dev/video0"
alias activate-v4l2loopback="sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2"
alias dfs='df -hx"squashfs"' # dont show snaps
alias record-gif='ffmpeg -video_size 1920x1080 -f x11grab -i :0.0+0,420 -y video.gif -vf "fps=10,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0'
alias start-qemu='qemu-system-x86_64 -enable-kvm -cpu host -smp 4 -m 6G -vga virtio -display sdl,gl=on -hda'
svg2png() { for file in *.svg; do inkscape -d=768 $file -e ${file%svg}png; done ; }
watch-cpu() { watch -n 0.5 $'mpstat 1 1 | awk \'/^Average/ {print 100-$NF,"%"}\''; }

# edit config files
alias dotfiles='code $HOME/.dotfiles'
alias avi='vim $HOME/.bash_aliases'
alias bvi='vim $HOME/.bashrc'
alias cvi='vim $HOME/.bash_config'
alias gvi='vim $HOME/.gitconfig'
alias hvi='vim $HOME/.config/nixpkgs/home.nix'
alias pvi='vim $HOME/.bash_private'
alias svi='vim $HOME/.ssh/config'
alias vvi='vim $HOME/.config/nvim/init.vim'

flakify() {
  if [ ! -e flake.nix ]; then
    nix flake new -t github:nix-community/nix-direnv .
  elif [ ! -e .envrc ]; then
    echo "use flake" > .envrc
    direnv allow
  fi
  ${EDITOR:-vim} flake.nix
}
