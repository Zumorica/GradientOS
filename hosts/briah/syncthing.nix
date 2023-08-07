{ config, ... }:
let
  secrets = config.sops.secrets;
  ports = import ./misc/service-ports.nix;
  ips = import ../../misc/wireguard-addresses.nix;
  devices = import ../../misc/syncthing-device-ids.nix;
  folders = import ../../misc/syncthing-folder-ids.nix;
in {
  services.syncthing = {
    enable = true;
    user = "vera";
    dataDir = "/home/vera";
    configDir = "/home/vera/.config/syncthing";
    cert = secrets.syncthing-cert.path;
    key = secrets.syncthing-key.path;
    overrideFolders = false;
    overrideDevices = false;
    openDefaultPorts = true;
    guiAddress = "127.0.0.1:${toString ports.syncthing}";
    extraOptions = {
      listenAddresses = [
        "tcp://0.0.0.0:${toString ports.syncthing-transfers}"
        "quic://0.0.0.0:${toString ports.syncthing-transfers}"
        "dynamic+https://relays.syncthing.net/endpoint"
      ];
      gui = {
        insecureSkipHostcheck = true;
      };
    };
    settings.devices = with devices; with ips; {
      miracle-crusher = {
        addresses = [ "tcp://${gradientnet.miracle-crusher}:22000" "dynamic" ];
        id = miracle-crusher;
      };
      vera-deck = {
        addresses = [ "tcp://${gradientnet.vera-deck}:22000" "dynamic" ];
        id = vera-deck;
      };
      neith-deck = {
        addresses = [ "tcp://${lilynet.neith-deck}:22000" "dynamic" ];
        id = neith-deck;
      };
      vera-phone = {
        addresses = [ "tcp://${gradientnet.vera-phone}:22000" "dynamic" ];
        id = vera-phone;
      };
      work-laptop = {
        addresses = [ "dynamic" ];
        id = work-laptop;
      };
    };

    settings.folders = with folders; {
      "/data/retrodeck" = {
        id = retrodeck;
        label = "Retrodeck";
        devices = [ "miracle-crusher" "vera-deck" "vera-phone" ];
      };

      "/data/Sync" = {
        id = default;
        label = "Default Sync Folder";
        devices = [ "miracle-crusher" "vera-deck" "vera-phone" "work-laptop" ];
      };

      "/data/Encrypted" = {
        id = important-documents;
        label = "Encrypted";
        devices = [ "miracle-crusher" ];
      };

      "/data/FFXIV Config" = {
        id = ffxiv-config;
        label = "FFXIV Config";
        devices = [ "miracle-crusher" "vera-deck" ];
      };

      "/data/Music" = {
        id = music;
        label = "Music";
        devices = [ "miracle-crusher" "vera-deck" "vera-phone" ];
      };

      "/data/The Midnight Hall" = {
        id = midnight-hall;
        label = "The Midnight Hall";
        devices = [ "miracle-crusher" "neith-deck" ];
      };
    };
  };
}