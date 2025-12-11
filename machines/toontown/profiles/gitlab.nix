{ config, lib, pkgs, ...}:

{

  systemd.services.gitlab.serviceConfig.LimitNOFILE = 65536;

  services.gitlab-runner = {
    enable = true;
    concurrent = 1;
    checkInterval = 5;
    services.default = {
      runUntagged = true;
      authenticationTokenConfigFile = pkgs.writeText "config" ''
        CI_SERVER_URL=http://gitlab.local
        CI_SERVER_TOKEN=glrt-N3XaOCcVXY5p1G67lpGDYm86MQpwOjEKdDozCnU6MQ8.01.170e3bp3p
      '';
      executor = "docker";
      dockerImage = "node:22-alpine";
      dockerPrivileged = true;
      dockerExtraHosts = [ "gitlab.local:host-gateway" ];
      dockerVolumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/cache"
      ];
    };
  };


    networking.extraHosts = ''
    127.0.0.1 gitlab.local
    '';

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    virtualHosts = {
      "gitlab.local" = {
        listen = [
          { addr = "0.0.0.0"; port = 80; }
          { addr = "0.0.0.0"; port = 8080; }
        ];
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
  };

  services.gitlab = {
    https = false;
    enable = true;
    host = "gitlab.local";
    initialRootPasswordFile = pkgs.writeText "rootPassword" "ThisShouldNotBeWeak!";
    smtp.enable = false;
    secrets = {
      secretFile = pkgs.writeText "secret" "Aig5zaic";
      otpFile = pkgs.writeText "otpsecret" "Riew9mue";
      dbFile = pkgs.writeText "dbsecret" "we2quaeZ";
      jwsFile = pkgs.runCommand "oidcKeyBase" {} "${pkgs.openssl}/bin/openssl genrsa 2048 > $out";
      activeRecordSaltFile = pkgs.writeText "saltFile" "AjEjfVl0aEjf#jf#vX0@JF#LA#VG)3a!";
      activeRecordPrimaryKeyFile = pkgs.writeText "primaryKeyFile" ";ErjvE;'osdfIU#jc;SKr3hAOHERlvce";
      activeRecordDeterministicKeyFile = pkgs.writeText "detKeyFile" "lk;sdfweghrawerioujtkjahxdfferEf";
    };

  };

}
