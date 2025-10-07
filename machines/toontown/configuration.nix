{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware.nix

    ./profiles/generic.nix
    ./profiles/terminal.nix
    ../../profiles/hyprland.nix
    ../../profiles/keyd.nix
  ];

  nix = {
    nixPath = [ "nixpkgs=${pkgs.path}" ];
    settings = {
      trusted-users = [ "root" "gilligan" ];
      experimental-features = [ "nix-command" "flakes" ];
      cores = 16;
    };
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
  programs.direnv.enable = true;

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

  system.stateVersion = "25.05";
}
