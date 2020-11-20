{ config, pkgs, lib, ... }:

# TODO: use nixGL to patch programs that use OpenGL (e.g. blender and obs)
# let 
#   nixGLIntel = (
#     pkgs.callPackage "${builtins.fetchTarball {
#       url = https://github.com/guibou/nixGL/archive/7d6bc1b21316bab6cf4a6520c2639a11c25a220e.tar.gz;
#       sha256 = "02y38zmdplk7a9ihsxvnrzhhv7324mmf5g8hmxqizaid5k5ydpr3";
#     }}/nixGL.nix" {}
#   ).nixGLIntel;
# in 
# TODO: use something like this:
#     ''
#     #!/bin/sh
#     ${nixGLIntel}/bin/nixGLIntel ${pkgs.obs-studio} "$@"
#     '';

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  # does overwrite .bashrc and .profile, which disables autocompletion and colored ls
  # targets.genericLinux.enable = true; 

 home = {
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
      XDG_DATA_DIRS="\${HOME}/.nix-profile/share:\${XDG_DATA_DIRS}";
      PATH="$HOME/go/bin:$PATH";
      # LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:${pkgs.stdenv.cc.cc.lib}/lib"; # cannot import pandas or scipy
    };
    packages = with pkgs; [
      # desktop
      firefox
      google-chrome
      vscode
      nextcloud-client
      # media
      gimp
      inkscape
      blender
      ffmpeg
      vlc
      # developing
      git
      docker
      docker-compose
      # clang # shadows system ld
      # # creates virtual env. does not allow to install other packages see:
      # # https://nixos.org/manual/nixpkgs/stable/#python
      # (python38.withPackages(ps: with ps; [ pip numpy matplotlib scipy pandas httpx pytest pylint mypy black rope isort ]))
      pypy3
      poetry
      nodejs
      go
      rustc
      cargo
      vala-language-server
      # cli utils
      bat
      curl
      exa
      fd
      fzf
      hyperfine
      neofetch
      ripgrep
      # starship # better prompt
      tree
      tldr
      zoxide
      # fonts
      jetbrains-mono
    ];
  };

  programs = {
   # sames issues as targets.genericLinux.enable: overwrites default bashrc
   # bash = {
   #   enable = true;
   #   initExtra = ''
   #     . ~/.bash_aliases
   #     . ~/.bash_config
   #   '';
   #  };
    bat = {
      enable = true;
      config = {
        theme = "GitHub";
      };
    };
    direnv = {
      enable = true;
      enableNixDirenvIntegration = true;
    };
    firefox = {
      enable = true;
      profiles = {
        myprofile = {
          settings = {
            "general.smoothScroll" = false;
          };
        };
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      extraConfig = builtins.readFile ./init.vim;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-surround
        vim-commentary
      ];
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs; [ obs-v4l2sink ];
  };

  services.nextcloud-client.enable = true;

  # alternative to home.activation.dotfiles, but makes dotfiles readonly
  # -> other programs cannot edit (e.g. vscode cannot edit settings.json)
  # home.file = {
  #   ".bash_aliases".source = ./aliases.bash;
  #   ".bash_config".source = ./config.bash;
  #   ".config/nvim/init.vim".source = ./init.vim;
  #   ".config/Code/User/settings.json".source = ./vscode-settings.json;
  #   ".gitconfig".source = ./gitconfig;
  #   ".inputrc".source = ./inputrc;
  #   ".vimrc".source = ./init.vim;
  #   ".ideavimrc".source = ./ideavimrc;
  #   ".local/bin/focus-application".source = ./focus-application/focus-application.sh;
  # };
}
