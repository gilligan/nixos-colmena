{ config, lib, pkgs, ... }:
{
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  boot = {
    loader.systemd-boot.enable = true;
    loader.grub.gfxmodeEfi = "1920x1080";
    loader.grub.gfxpayloadEfi = "keep";
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix = {
    #package = pkgs.nixVersions.latest;
    settings = {
      sandbox = true;
    };
    gc = {
      automatic = true;
    };
    extraOptions = ''
      auto-optimise-store = true
      keep-outputs = true
      keep-derivations = true
    '';
  };

  services = {
    avahi.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
