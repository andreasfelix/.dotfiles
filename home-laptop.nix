{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    # keyboard = null; # use xkb layout of system
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      # desktop
      vscode
      google-chrome
      firefox
      owncloud-client
      gnome.dconf-editor
      easyeffects
      insomnia
      teams
      beekeeper-studio
      qemu
      (writeShellApplication {
        name = "launch-or-focus";
        text = (builtins.readFile ./launch-or-focus/launch-or-focus.sh);
        runtimeInputs = [ wmctrl xdotool ];
      })
      # ci
      fly
      # git
      git
      git-lfs
      gh
      # databases
      # nix
      nix-index
      rnix-lsp
      nixpkgs-fmt
      # docker
      docker
      dive
      # c
      clang
      valgrind
      # python
      (python39.withPackages (ps: with ps; [ pip ipython numpy matplotlib scipy pandas httpx pytest pylint mypy black rope isort ]))
      poetry
      # javascript
      nodejs
      yarn
      nodePackages.pnpm
      nodePackages.live-server
      # go
      go
      # rust
      rustup
      # wasm
      wasmer
      wabt
      # zig
      zig
      # shell prompt
      starship
      # cli programs
      htop
      neofetch
      nmap
      # modern unix commands
      bat
      curl
      dogdns
      duf
      du-dust
      exa
      fd
      fzf
      hyperfine
      hexyl
      jq
      pastel
      procs
      ripgrep
      tealdeer
      xcolor
      xh
      yj
      zoxide
      # fonts
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };

  programs = {
    bat = {
      enable = true;
      config.theme = "GitHub";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
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
        nvim-treesitter-textobjects
        telescope-nvim
        vim-nix
        vim-surround
        vim-commentary
      ];
    };
  };
}
