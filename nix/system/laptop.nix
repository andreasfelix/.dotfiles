{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix.extraOptions = "experimental-features = nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    tmpOnTmpfs = true;
    supportedFilesystems = [ "ntfs" ];
  };

  systemd.extraConfig = ''
    DefaultTimeoutStartSec=10s
    DefaultTimeoutStopSec=10s
  '';

  networking = {
    firewall.enable = false;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    # useDHCP = false;
    # # interfaces.enp3s0f4u1u4.useDHCP = true;
    # interfaces.enp3s0f3u1u4u2.useDHCP = true;
    # interfaces.wlp1s0.useDHCP = true;
  };

  programs.adb.enable = true;

  users = {
    mutableUsers = false;
    users.felix = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" "adbusers" ];
      password = "2863";
    };
  };

  # hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;
  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  hardware.opengl.enable = true;
  hardware.pulseaudio.enable = false;
  sound.enable = false;
  security.rtkit.enable = true;

  environment = {
    variables.EDITOR = "nvim";
    systemPackages = with pkgs; [
    ];
  };

  # from https://nixos.wiki/wiki/Firefox
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        # todo leads to collision -> error: collision between
        # xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      # desktopManager.pantheon.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.scrollMethod = "button";
        mouse.scrollButton = 9;
      };

      layout = "us-felix";
      extraLayouts.us-felix = {
        symbolsFile = ../../xkb/symbols/us-felix;
        description = "Felix' Keyboard Layout";
        languages = [ "eng" ];
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    flatpak.enable = true;
  };

  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    waydroid.enable = true;
    lxd.enable = true;
    virtualbox.host.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
