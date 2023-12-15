{ pkgs, lib, ... }:
{
  hardware = {
    pulseaudio.enable = true;
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.extraConfig = ''
      load-module module-switch-on-connect
    '';
  };

  sound.extraConfig = ''
    pcm.!default {
      type hw
      card 1
    }
    ctl.!default {
      type hw
      card 1
    }
  '';

}
