# see https://github.com/mjlbach/nix-dotfiles/blob/master/home-manager/modules/gl_wrappers.nix
{ config, pkgs, ... }:
let
  # use nixGL to patch programs that use OpenGL (e.g. blender, obs, google-chrome??)
  nixGL = (
    pkgs.callPackage "${
    builtins.fetchTarball {
      url = https://github.com/guibou/nixGL/archive/c4aa5aa15af5d75e2f614a70063a2d341e8e3461.tar.gz;
      sha256 = "09p7pvdlf4sh35d855lgjk6ciapagrhly9fy8bdiswbylnb3pw5d";
    }
    }/nixGL.nix" {}
  );
in
nixGL.nixGLIntel
