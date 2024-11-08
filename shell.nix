{ pkgs ? import ./nix }:
pkgs.mkShell {
  buildInputs = with pkgs; [ git nixpkgs-fmt npins gnumake colmena ];
  NIX_PATH = "nixpkgs=${pkgs.path}";
}
