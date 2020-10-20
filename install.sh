dotfiles=$(dirname $(readlink -f $0))

mkdir -p $HOME/.local/bin $HOME/.config/nixpkgs $HOME/.config/nvim

ln -sfv $dotfiles/aliases.bash $HOME/.bash_aliases
ln -sfv $dotfiles/custom.bash $HOME/.bash_custom
ln -sfv $dotfiles/gitconfig $HOME/.gitconfig
ln -sfv $dotfiles/ideavimrc $HOME/.ideavimrc
ln -sfv $dotfiles/inputrc $HOME/.inputrc
ln -sfv $dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -sfv $dotfiles/init.vim $HOME/.vimrc
ln -sfv $dotfiles/vscode-settings.json $HOME/.config/Code/User/settings.json
ln -sfv $dotfiles/config.nix $HOME/.config/nixpkgs/config.nix
ln -sfv $dotfiles/focus-application/focus-application.sh $HOME/.local/bin/focus-application

if [ -e $HOME/.bashrc ] && ! grep -q '.bash_custom' $HOME/.bashrc ; then
echo "\
# added by Felix's dotfiles installer
if [ -f $HOME/.bash_custom ]; then
    . $HOME/.bash_custom
fi
" >> $HOME/.bashrc
fi

