let
  pins = import ../npins/default.nix;
  config = {
    allowUnfree = true;
  };
  overlays = [ ];
in
import pins.nixpkgs { inherit overlays config; }
