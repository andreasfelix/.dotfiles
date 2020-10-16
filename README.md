# .dotfiles

Use to `bash install.sh` create symlinks.

## Additional Configuration (Linux)

### Add desktop files provided by Nix

add this to `~/.profile`:

```sh
# show desktop files provided by nix
if [ -d "$HOME/.nix-profile" ] ; then 
    export XDG_DATA_DIRS="$HOME/.nix-profile/share:${XDG_DATA_DIRS}"
fi
```

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
