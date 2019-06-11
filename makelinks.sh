dotfiles=$(dirname $(readlink -f $0))

ln -sfv $dotfiles/bash_aliases $HOME/.bash_aliases
ln -sfv $dotfiles/bash_custom $HOME/.bash_custom
ln -sfv $dotfiles/gitconfig $HOME/.gitconfig
ln -sfv $dotfiles/vimrc $HOME/.vimrc
ln -sfv $dotfiles/intellij/.ideavimrc $HOME/.ideavimrc
ln -sfv $dotfiles/vscode/settings.json $HOME/.var/app/com.visualstudio.code.oss/config/Code\ -\ OSS/User
ln -sfv $dotfiles/vscode/settings.json $HOME/.config/Code/User/settings.json
ln -sfv $dotfiles/inputrc $HOME/.inputrc
ln -sfv $dotfiles/pyrc $HOME/.pyrc
