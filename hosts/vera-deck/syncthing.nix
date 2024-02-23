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

      miracle-crusher = {
        addresses = [
          "tcp://${gradientnet.miracle-crusher}:22000"
          "dynamic"
        ];
        id = miracle-crusher;
        introducer = true;
      };

      vera-deck-oled = {
        addresses = [
          "tcp://${gradientnet.vera-deck-oled}:22000"
          "dynamic"
        ];
        id = vera-deck-oled;
      };

      work-laptop = {
        addresses = [ "dynamic" ];
        id = work-laptop;
      };

      vera-phone = {
        addresses = [ "tcp://${gradientnet.vera-phone}:22000" "dynamic" ];
        id = vera-phone;
      };
    };

    settings.folders = with folders; {
      "/home/vera/Documents/Sync/" = {
        id = default;
        label = "Default Sync Folder";
        devices = [ "briah" "miracle-crusher" "work-laptop" "vera-deck-oled" ];
      };

      "/home/vera/.xlcore/ffxivConfig" = {
        id = ffxiv-config;
        label = "FFXIV Config";
        devices = [ "briah" "miracle-crusher" "vera-deck-oled" ];
      };

      "/home/vera/Music" = {
        id = music;
        label = "Music";
        devices = [ "briah" "miracle-crusher" "vera-phone" "vera-deck-oled" ];
      };

      /*"/run/media/deck/mmcblk0p1/retrodeck" = {
        id = retrodeck;
        label = "Retrodeck";
        devices = [ "briah" "miracle-crusher" "vera-deck-oled" ];
      };*/
    };
  };
}