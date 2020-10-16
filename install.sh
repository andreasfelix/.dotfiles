dotfiles=$(dirname $(readlink -f $0))

mkdir -p $HOME/.local/bin $HOME/.config/nixpkgs

ln -sfv $dotfiles/bash_aliases $HOME/.bash_aliases
ln -sfv $dotfiles/bash_custom $HOME/.bash_custom
ln -sfv $dotfiles/config.nix $HOME/.config/nixpkgs/config.nix
ln -sfv $dotfiles/gitconfig $HOME/.gitconfig
ln -sfv $dotfiles/ideavimrc $HOME/.ideavimrc
ln -sfv $dotfiles/inputrc $HOME/.inputrc
ln -sfv $dotfiles/vimrc $HOME/.vimrc
ln -sfv $dotfiles/vscode-settings.json $HOME/.config/Code/User/settings.json
ln -sfv $dotfiles/vscode-settings.json $HOME/.config/VSCodium/User/settings.json
# ln -sfv $dotfiles/vscode-settings.json $HOME/.var/app/com.visualstudio.code/config/Code/User
# ln -sfv $dotfiles/vscode-settings.json $HOME/.var/app/com.visualstudio.code.oss/config/Code\ -\ OSS/User
ln -sfv $dotfiles/focus-application/focus-application.sh $HOME/.local/bin/focus-application

if [ -e $HOME/.bashrc ] && ! grep -q '.bash_custom' $HOME/.bashrc ; then
echo "\
# added by Felix's dotfiles installer
if [ -f $HOME/.bash_custom ]; then
    . $HOME/.bash_custom
fi
" >> $HOME/.bashrc
fi

