{ config, lib, pkgs, ... }:
{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        capslock = "overload(control, esc)";
        leftshift = "overload(shift, S-9)";
        rightshift = "overload(shift, S-0)";
        leftalt = "layer(dia)";
        space = "tap(space, leftmeta)";
      };
    };
  };
}
