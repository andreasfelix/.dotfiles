# Custom Keyboard Layout

see https://nixos.org/manual/nixos/stable/#custom-xkb-layouts

test with:

```
nix-shell -p xorg.xkbcomp
setxkbmap -I/home/felix/.dotfiles/xkb us-felix -print | xkbcomp -I/home/felix/.dotfiles/xkb - $DISPLAY
```

> there must be NO space between `-I` and the path

Run to use system defaults:

```
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```

## Key Maps

* <kbd>Caps Lock</kbd> -> <kbd>Escape</kbd>
* <kbd>Left Alt</kbd> -> <kbd>Level 3 Shift</kbd>
* <kbd>ISO &gt;&lt;</kbd> -> <kbd>Shift</kbd>

## Level 3 Layout

* <kbd>h</kbd> <kbd>j</kbd> <kbd>k</kbd> <kbd>l</kbd> -> <kbd>←</kbd> <kbd>↓</kbd> <kbd>↑</kbd> <kbd>→</kbd>
* <kbd>w</kbd> <kbd>a</kbd> <kbd>s</kbd> <kbd>d</kbd> -> <kbd>↑</kbd> <kbd>←</kbd> <kbd>↓</kbd> <kbd>→</kbd>
* <kbd>q</kbd> <kbd>e</kbd> -> <kbd>Home</kbd> <kbd>End</kbd>
* <kbd>r</kbd> -> <kbd>Delete</kbd>
* <kbd>f</kbd> -> <kbd>Backspace</kbd>
* <kbd>v</kbd> -> <kbd>Enter</kbd>
