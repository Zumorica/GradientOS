{ config, ... }:
let
  secrets = config.sops.secrets;
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
    settings.devices = with devices; with ips; {
      briah = {
        addresses = [
          "tcp://192.168.1.24:22000"
          "tcp://${gradientnet.briah}:22000"
          "tcp://vpn.gradient.moe:22000"
          "dynamic"
        ];
        id = briah;
        introducer = true;
      };

      vera-deck = {
        addresses = [ "tcp://${gradientnet.vera-deck}:22000" "dynamic" ];
        id = vera-deck;
      };

      vera-deck-oled = {
        addresses = [
          "tcp://${gradientnet.vera-deck-oled}:22000"
          "dynamic"
        ];
        id = vera-deck-oled;
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
      "/home/vera/Documents/Sync/" = {
        id = default;
        label = "Default Sync Folder";
        devices = [ "briah" "vera-deck" "work-laptop" "vera-deck-oled" ];
      };

      "/home/vera/.ImportantDocuments_encfs/" = {
        id = important-documents;
        label = "Encrypted";
        devices = [ "briah" ];
      };

      "/home/vera/.xlcore/ffxivConfig" = {
        id = ffxiv-config;
        label = "FFXIV Config";
        devices = [ "briah" "vera-deck" "vera-deck-oled" ];
      };

      "/home/vera/Music" = {
        id = music;
        label = "Music";
        devices = [ "briah" "vera-phone" "vera-deck" "vera-deck-oled" ];
      };

      "/home/vera/Documents/TheMidnightHall" = {
        id = midnight-hall;
        label = "The Midnight Hall";
        devices = [ "briah" "neith-deck" ];
      };

      "/data/retrodeck" = {
        id = retrodeck;
        label = "Retrodeck";
        devices = [ "briah" "vera-deck" "vera-deck-oled" ];
      };
    };
  };
}