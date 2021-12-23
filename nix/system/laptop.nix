{ config, lib, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp3s0f4u1u4.useDHCP = true;
  # networking.interfaces.wlp1s0.useDHCP = true;

  users = {
    mutableUsers = false;
    users.felix = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      password = "2863";
    };
  };

  # Remove sound.enable or turn it off if you had it set previously, it seems to cause conflicts with pipewire
  hardware.pulseaudio.enable = false;
  sound.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    pantheon.appcenter
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.scrollMethod = "button";
        mouse.scrollButton = 9;
        # touchpad.accelProfile = "flat";
      };

      extraLayouts.us-felix = {
        description = "Personal Keyboard Layout";
        languages = [ "eng" ];
        symbolsFile = ../../xkb/symbols/us-felix;
      };
      layout = "us-felix";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    flatpak.enable = true;
  };



  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
