{ config, pkgs, lib, ... }:

let # use nixGL to patch programs that use OpenGL (e.g. blender, obs, google-chrome??)
  nixGLIntel = (
    pkgs.callPackage "${
      builtins.fetchTarball {
        url = https://github.com/guibou/nixGL/archive/3ab1aae698dc45d11cc2699dd4e36de9cdc5aa4c.tar.gz;
        sha256 = "192k02fd2s3mfpkdwjghiggcn0ighwvmw0fqrzf0vax52v6l9nch";
      }
    }/nixGL.nix" { }
  ).nixGLIntel;
in {
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  # does overwrite .bashrc and .profile, which disables autocompletion and colored ls
  # targets.genericLinux.enable = true;

 home = {
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
      XDG_DATA_DIRS = "\${HOME}/.nix-profile/share:\${XDG_DATA_DIRS}";
      PATH = "$HOME/.cargo/bin:$HOME/go/bin:$PATH";
      CHTSH_QUERY_OPTIONS = "style=manni";
      # LD_LIBRARY_PATH="\${LD_LIBRARY_PATH}:${pkgs.stdenv.cc.cc.lib}/lib"; # cannot import pandas or scipy
    };
    packages = with pkgs; [
      # desktop
      nixGLIntel
      # firefox
      # google-chrome # webgl does not work properly (e.g. google-maps is not 3d)
      vscode # vscodium # does not support live share
      # nextcloud-client
      # media
      gimp inkscape blender ffmpeg-full vlc
      # git
      git git-lfs
      # databases
      redis
      # nix
      nix-index rnix-lsp nixpkgs-fmt
      # docker
      docker docker-compose
      # c
      valgrind
      # gcc # clang # shadows system ld
      # python
      # # creates virtual env. does not allow to install other packages see:
      # # https://nixos.org/manual/nixpkgs/stable/#python
      # (python38.withPackages(ps: with ps; [ pip numpy matplotlib scipy pandas httpx pytest pylint mypy black rope isort ]))
      # poetry
      pypy3 
      # javascript
      nodejs yarn nodePackages.pnpm 
      nodePackages.live-server
      # go
      go
      # rust
      rustup rust-analyzer # rustc cargo rustfmt clippy
      # vala
      vala-language-server # vala-lint
      # wasm
      wasmer wabt
      # zig
      zig
      # shell prompt
      starship
      # cli programs
      htop radare2 nmap 
      yj
      # modern unix commands
      bat curl dogdns duf du-dust exa fd fzf hyperfine hexyl mcfly neofetch pastel procs ripgrep tealdeer zoxide
      # fonts
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  programs = {
    # sames issues as targets.genericLinux.enable: overwrites default bashrc
    # bash = {
    #   enable = true;
    #   shellAliases = {
    #   };
    #   initExtra = ''
    #     . ~/.bash_aliases
    #     . ~/.bash_config
    #   '';
    # };
    bat = {
      enable = true;
      config.theme = "GitHub";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = builtins.readFile ./init.vim;
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [ (python3.withPackages (ps: with ps; [ black isort pylint ])) nodePackages.pyright ];
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter
        telescope-nvim
        vim-nix
        vim-surround
        vim-commentary
        # coc-nvim
        # coc-pyright
        # coc-rust-analyzer
      ];
    };
    obs-studio = {
      enable = true;
    };
  };

  # services.nextcloud-client.enable = true;

  # alternative to home.activation.dotfiles, but makes dotfiles readonly
  # -> other programs cannot edit (e.g. vscode cannot edit settings.json)
  # see: https://github.com/nix-community/home-manager/issues/257
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
