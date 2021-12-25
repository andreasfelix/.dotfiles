# dotfiles=$(dirname $(readlink -f $0)) # does not work with home-manager
dotfiles=$HOME/.dotfiles

mkdir -p $HOME/.local/bin $HOME/.config/{alacritty,Code/User,nixpkgs,nu,nvim}

ln -sfv $dotfiles/aliases.bash $HOME/.bash_aliases
ln -sfv $dotfiles/alacritty.yaml $HOME/.config/alacritty/alacritty.yml
ln -sfv $dotfiles/config.bash $HOME/.bash_config
ln -sfv $dotfiles/config.nix $HOME/.config/nixpkgs/config.nix
ln -sfv $dotfiles/gitconfig $HOME/.gitconfig
ln -sfv $dotfiles/gitignore $HOME/.gitignore
ln -sfv $dotfiles/ideavimrc $HOME/.ideavimrc
ln -sfv $dotfiles/inputrc $HOME/.inputrc
# ln -sfv $dotfiles/init.vim $HOME/.config/nvim/init.vim # handled by home-manager
ln -sfv $dotfiles/init.vim $HOME/.vimrc
ln -sfv $dotfiles/nushell.toml $HOME/.config/nu/config.toml
ln -sfv $dotfiles/starship.toml $HOME/.config/starship.toml
ln -sfv $dotfiles/vscode-settings.json $HOME/.config/Code/User/settings.json
# ln -sfv $dotfiles/vscode-settings.json $HOME/.config/VSCodium/User/settings.json
ln -sfv $dotfiles/launch-or-focus/launch-or-focus.sh $HOME/.local/bin/launch-or-focus

if [ ! -f $HOME/.bashrc ] || ! grep -q '.bash_aliases' $HOME/.bashrc ; then
echo '
# added by felix'"'"'s dotfiles installer
if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi
' >> $HOME/.bashrc
fi

if [ ! -f $HOME/.bashrc ] || ! grep -q '.bash_config' $HOME/.bashrc ; then
echo '
# added by felix'"'"'s dotfiles installer
if [ -f $HOME/.bash_config ]; then
    . $HOME/.bash_config
fi
' >> $HOME/.bashrc
fi

if [ ! -f $HOME/.profile ] || ! grep -q 'hm-session-vars.sh' $HOME/.profile ; then
echo '
# added by felix'"'"'s dotfiles installer
export dotfiles=$dotfiles
if [ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
fi
' >> $HOME/.profile
fi
