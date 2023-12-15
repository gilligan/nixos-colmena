{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    ./profiles/generic.nix
    ./profiles/plasma5-with-i3.nix
    ./profiles/terminal.nix
    ./profiles/pulseaudio.nix
    ./profiles/nix-direnv.nix
    ./profiles/jellyfin.nix
  ];


  nix = {
    settings = {
      trusted-users = [ "root" "gilligan" ];
      cores = 16;
    };
  };

  nixpkgs = {
    overlays = [
      (import ./overlays/i3.nix)
    ];
  };

  networking = {
    hostName = "toontown";
    networkmanager.enable = true;
    firewall = {
      enable = false;
    };
  };

  hardware = {
    opengl.enable = true;
  };

  programs.steam.enable = true;


  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  users.extraUsers.gilligan = {
    isNormalUser = true;
    group = "users";
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" ];
    createHome = true;
    home = "/home/gilligan";
    shell = "/run/current-system/sw/bin/zsh";
  };
  system.stateVersion = "20.03";
}
