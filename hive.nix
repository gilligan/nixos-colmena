{
  meta = {
    nixpkgs = import ./nix/default.nix;
  };

  toontown = { pkgs, config, lib, ... }: {
    deployment = {
      allowLocalDeployment = true;
      tags = [ "desktop" ];
    };
    imports = [
      ./machines/toontown/configuration.nix
    ];
  };

  mele = { pkgs, config, lib, ... }: {
    deployment = {
      targetHost = "mele.fritz.box";
      tags = [ "paperless" ];
    };
    imports = [
      ./machines/mele/configuration.nix
    ];
  };
}
