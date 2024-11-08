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
      };
      dia = {
        o = "macro(compose o \")";
        a = "macro(compose a \")";
        u = "macro(compose u \")";
        s = "macro(compose s s)";
      };
    };
  };
}
