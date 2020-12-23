let
  pkgs = import <nixpkgs> {};
in
pkgs.stdenv.mkDerivation {
  name = "focus-application";
  src = ./.;
  buildInputs = with pkgs; [
    xdotool
    wmctrl
  ];
  installPhase = ''
    mkdir -p $out/bin
    cp $src/focus-application.sh $out/bin/focus-application
    substituteInPlace $out/bin/focus-application \
    --replace xdotool ${pkgs.xdotool}/bin/xdotool \
    --replace wmctrl ${pkgs.wmctrl}/bin/wmctrl
  '';
}
