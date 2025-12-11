{ config, lib, pkgs, ... }:

let
  scaled-chrome = pkgs.writeScriptBin "scaled-chrome" ''
    exec ${pkgs.google-chrome}/bin/google-chrome-stable --force-device-scale-factor=1.5
  '';
  waynal = pkgs.writeScriptBin "waynal" ''
    exec ${pkgs.signal-desktop}/bin/signal-desktop --use-tray-icon --no-sandbox %U --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-features=WaylandWindowDecorations
  '';

in

{

  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  programs.hyprland.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["gilligan"];
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];

  programs.nm-applet.enable = true;

  services.udisks2.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    cliphist
    grim
    grimblast
    keymapp
    kitty
    libnotify
    libsForQt5.qt5ct
    libsForQt5.qtwayland
    mako
    networkmanagerapplet
    nwg-look
    rofi
    swaynotificationcenter
    swww
    waybar
    wezterm
    wlogout
    wl-clipboard
    google-chrome
    scaled-chrome
    slack
    spotify
    udiskie
    waynal
    zoom-us
    hyprpanel
    hyprshot
    hyprshade
    pamixer
  ];

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts
      fira
      fira-code
      fira-code-symbols
      fira-mono
      powerline-fonts
      font-awesome
    ];
  };
}
