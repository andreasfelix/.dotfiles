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

  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;

      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        touchpad.accelProfile = "flat";
        mouse.scrollMethod = "button";
        mouse.scrollButton = 9;
      };

    };
    # flatpak.enable = true;
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
