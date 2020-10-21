{
  allowUnfree = true;
  # # disabled while testing home-manager
  # packageOverrides = pkgs: with pkgs; {
  #   all = buildEnv {
  #     name = "all";
  #     paths = [
  #       # desktop
  #       firefox
  #       google-chrome
  #       vscode
  #       nextcloud-client
  #       # developing
  #       git
  #       clang
  #       python38
  #       python38Packages.pip
  #       go
  #       nodejs
  #       rustc
  #       cargo
  #       # cmd utils
  #       bat
  #       exa
  #       fd
  #       hyperfine
  #       pazi
  #       ripgrep
  #       tree
  #     ];
  #   };
  # };
}
