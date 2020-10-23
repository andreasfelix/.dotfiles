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
      # QT_XCB_GL_INTEGRATION = "none"; # fix: "Could not initialize GLX"
    };
    sessionVariablesExtra = "export PATH=$HOME/go/bin:$PATH\n";
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
      clang
      python38
      python38Packages.pip
      nodejs
      go
      rustc
      cargo
      # cli utils
      bat
      exa
      fd
      hyperfine
      pazi
      ripgrep
      tree
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

