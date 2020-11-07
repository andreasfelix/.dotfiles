# .dotfiles

Use `bash install.sh` to create symlinks. Or, when using [nix](https://nixos.org/) and [home-manager](https://github.com/nix-community/home-manager):

```sh
ln -sfv home.nix $HOME/.config/nixpkgs/home.nix
home-manager switch
```

## Additional Configuration (Linux)

### Add button scroll via libinput on X11

add this to the pointer device in `/usr/share/X11/xorg.conf.d/40-libinput.conf`:

```
Option          "ScrollMethod" "button"
Option          "ScrollButton" "9"
```

### Remove screen tearing intel GPU

Create `/etc/X11/xorg.conf.d/20-intel.conf`

```
Section "Device"
    Identifier "Intel Graphics"
    Driver "intel"
    Option "TearFree" "true"
EndSection
```
