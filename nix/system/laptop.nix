{ config, lib, pkgs }: {
  imports = [ ./hardware-configuration.nix ];

  nix.extraOptions = "experimental-features = nix-command flakes";

  users = {
    mutableUsers = false;
    users.felix = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    };
  };

  services = {
    xserver = {
      enable = true;
      desktopManager.pantheon.enable = true;
    };
    flatpak.enable = true;
  };

  virtualisation.docker.enable = true;
}
