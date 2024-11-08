{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "mele"; # Define your hostname.
  networking.wireless.enable = false; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 8080;
    consumptionDirIsPublic = true;
    extraConfig = {
      PAPERLESS_URL = "http://mele.fritz.box";
      PAPERLESS_INLINE_DOC = "true";
      PAPERLESS_FORGIVING_OCR = "true";
      PAPERLESS_COR_LANGUAGE = "eng+deu";
      #PAPERLESS_OCR_THREADS = 5;
      #PAPERLESS_TASK_WORKERS = 3;
      #PAPERLESS_THREADS_PER_WORKER = 2;
    };
  };

  services.vsftpd = {
    enable = true;
    userlistEnable = true;
    userlist = [ "gilligan" ];
    localUsers = true;
    localRoot = "${config.services.paperless.consumptionDir}";
    writeEnable = true;
    extraConfig = ''
      local_umask=033
    '';
  };

  networking.hosts = {
    "192.168.178.104" = [ "mele.local" ];
    "192.168.178.20" = [ "toontown.local" ];
  };
  services.dnsmasq = {
    enable = true;
    settings.servers = [
      "8.8.8.8"
      "4.4.4.4"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gilligan = {
    isNormalUser = true;
    description = "gilligan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    wget
    gitAndTools.gitFull
    jq
    killall
    npins
    fzf
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
