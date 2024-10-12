{ config, lib, ... }:
let
  ports = import ../misc/service-ports.nix;
in
{

  services.esphome = {
    enable = true;
    address = "0.0.0.0";
    port = ports.esphome;
  };

  users.users.esphome = {
    isSystemUser = true;
    home = "/var/lib/esphome";
    createHome = true;
    homeMode = "750";
    group = config.users.groups.esphome.name;
  };

  users.groups.esphome = {};

  systemd.services.esphome = {
    serviceConfig = {
      # Needed to fix compilation
      DynamicUser = lib.mkForce false;
      User = lib.mkForce config.users.users.esphome.name;
      Group = lib.mkForce config.users.groups.esphome.name;
      PrivateTmp = lib.mkForce true;
      RemoveIPC = lib.mkForce true;
      RestrictSUIDSGID = lib.mkForce true;
    };
  };

  systemd.tmpfiles.settings."10-esphome" = {
    "/var/lib/esphome/atom-lite-vera-bedroom.yaml".C = {
      argument = toString ./atom-lite-vera-bedroom.yaml;
      repoPath = "/etc/nixos/hosts/briah/esphome/atom-lite-vera-bedroom.yaml.cfg";
      doCheck = true;
      user = config.systemd.services.esphome.serviceConfig.User;
      group = config.systemd.services.esphome.serviceConfig.Group;
      mode = "0777";
    };
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.esphome ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.esphome ];

}