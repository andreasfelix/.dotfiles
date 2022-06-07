{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  # workaround from nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  fonts.fontconfig.enable = true;

  home = {
    activation.dotfiles = lib.hm.dag.entryAfter [ "writeBoundary" ] (builtins.readFile ./install.sh);
    sessionVariables = {
      EDITOR = "nvim";
    };
    packages = with pkgs; [
      # desktop
      alacritty
      kitty
      beekeeper-studio
      easyeffects
      emote
      firefox
      gnome.dconf-editor
      google-chrome
      gimp
      helvum
      insomnia
      neovide
      onlyoffice-bin
      owncloud-client
      teams
      qemu
      xclip # necessary to copy from (neo)vim
      # wl-copy and wl-paste # for wayland
      # vscode
      # vscode-fhs
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
      # containers
      dive
      cntr
      # kubernetes
      minikube
      kubectl
      # c
      clang
      valgrind
      # elm
      elmPackages.elm
      elmPackages.elm-test
      elmPackages.elm-format
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
      rust-analyzer
      # wasm
      wasmer
      wabt
      # zig
      zig
      zls
      # shell prompt
      starship
      # cli programs
      file
      lsof
      dstat
      curl
      htop
      neofetch
      nmap
      pandoc
      # modern unix commands
      bat
      dogdns
      duf
      du-dust
      exa
      fd
      fzf
      hyperfine
      hexyl
      jless
      jq
      pastel
      procs
      ripgrep
      sd
      tealdeer
      xcolor
      xh
      yj
      zoxide
      # fonts
      inter
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
    neovim =
      let
        github-nvim-theme = pkgs.vimUtils.buildVimPlugin {
          name = "github-nvim-theme";
          src = pkgs.fetchFromGitHub {
            owner = "projekt0n";
            repo = "github-nvim-theme";
            rev = "v0.0.5";
            sha256 = "sha256-tZBS+eP7n98WVvM2EZdPSttGAjUniXP+rEoQn4aL3eU=";
          };
          nativeBuildInputs = with pkgs; [ luajitPackages.luacheck ];
        };
      in
      {
        enable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        extraConfig = builtins.readFile ./init.vim;
        withNodeJs = true;
        withPython3 = true;
        extraPackages = with pkgs; [ (python3.withPackages (ps: with ps; [ black isort pylint ])) nodePackages.pyright ];
        plugins = with pkgs.vimPlugins; [
          github-nvim-theme
          nvim-lspconfig
          nvim-treesitter
          nvim-treesitter-textobjects
          telescope-nvim
          vim-nix
          vim-surround
          vim-commentary
        ];
      };
    vscode = {
      enable = true;
      # vscode-fhs leads to two problems
      #  * can't open shell -> symbol error
      #  * does not recognize python venv
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        github.github-vscode-theme
        vscodevim.vim
        ms-vsliveshare.vsliveshare
        # ms-vscode.cpptools
        ms-python.python
        tamasfe.even-better-toml
        matklad.rust-analyzer
        antfu.slidev
      ];
    };
  };
}
