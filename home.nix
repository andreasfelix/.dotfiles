{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # does overwrite .bashrc and .profile, which disables autocompletion and colored ls
  # targets.genericLinux.enable = true; 

  home = {
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
      XDG_DATA_DIRS="\${HOME}/.nix-profile/share:\${XDG_DATA_DIRS}";
      PATH="$HOME/go/bin:$PATH";
      # LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:${pkgs.stdenv.cc.cc.lib}/lib"; # cannot import pandas or scipy
      # QT_XCB_GL_INTEGRATION = "none"; # fix: "Could not initialize GLX"
    };
    packages = with pkgs; [
      # desktop
      firefox
      google-chrome
      vscode
      nextcloud-client
      # media
      ffmpeg
      blender
      gimp
      inkscape
      # developing
      git
      docker
      docker-compose
      # clang # shadows system ld
      # # creates virtual env. does not allow to install other packages see:
      # # https://nixos.org/manual/nixpkgs/stable/#python
      (python38.withPackages(ps: with ps; [ pip numpy matplotlib scipy pandas requests pytest pylint black isort ]))
      poetry
      nodejs
      go
      rustc
      cargo
      # cli utils
      bat
      curl
      exa
      fd
      fzf
      hyperfine
      zoxide
      ripgrep
      tree
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
