{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      # desktop
      vscode
      google-chrome
      firefox
      easyeffects
      insomnia
      qemu
      wmctrl
      xdotool
      (writeScriptBin "focus-application" (builtins.readFile ./focus-application/focus-application.sh))
      # git
      git
      git-lfs
      # databases
      # nix
      nix-index
      rnix-lsp
      nixpkgs-fmt
      # docker
      docker
      docker-compose
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
