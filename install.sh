# dotfiles=$(dirname $(readlink -f $0)) # does not work with home-manager
dotfiles=$HOME/Projects/andreasfelix/dotfiles

mkdir -p $HOME/.local/bin $HOME/.config/nixpkgs $HOME/.config/nvim

ln -sfv $dotfiles/aliases.bash $HOME/.bash_aliases
ln -sfv $dotfiles/config.bash $HOME/.bash_config
ln -sfv $dotfiles/gitconfig $HOME/.gitconfig
ln -sfv $dotfiles/ideavimrc $HOME/.ideavimrc
ln -sfv $dotfiles/inputrc $HOME/.inputrc
ln -sfv $dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -sfv $dotfiles/init.vim $HOME/.vimrc
ln -sfv $dotfiles/vscode-settings.json $HOME/.config/Code/User/settings.json
ln -sfv $dotfiles/focus-application/focus-application.sh $HOME/.local/bin/focus-application

# if [ -e $HOME/.bashrc ] && ! grep -q '.bash_config' $HOME/.bashrc ; then
# echo "\
# # added by Felix's dotfiles installer
# if [ -f $HOME/.bash_config ]; then
#     . $HOME/.bash_config
# fi
# " >> $HOME/.bashrc
# fi
