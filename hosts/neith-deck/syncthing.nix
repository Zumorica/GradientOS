{ config, ... }:
let
  secrets = config.sops.secrets;
  ips = import ../../misc/wireguard-addresses.nix;
  devices = import ../../misc/syncthing-device-ids.nix;
  folders = import ../../misc/syncthing-folder-ids.nix;
in {
  services.syncthing = {
    enable = true;
    user = "neith";
    dataDir = "/home/neith";
    configDir = "/home/neith/.config/syncthing";
    cert = secrets.syncthing-cert.path;
    key = secrets.syncthing-key.path;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    settings.devices = with devices; with ips; {
      briah = {
        addresses = [
          "tcp://${lilynet.briah}:22000"
          "tcp://vpn.gradient.moe:22000"
          "dynamic"
        ];
        id = briah;
        introducer = true;
      };

      miracle-crusher = {
        addresses = [
          "tcp://${lilynet.miracle-crusher}:22000"
          "dynamic"
        ];
        id = miracle-crusher;
        introducer = true;
      };
    };

    settings.folders = with folders; {
      "/home/neith/Documents/TheMidnightHall" = {
        id = midnight-hall;
        label = "The Midnight Hall";
        devices = [ "briah" "miracle-crusher" ];
      };
    };
  };
}