{ config, ... }:
let
  secrets = config.sops.secrets;
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
    devices = {
      SPACE-CATGIRL = {
        addresses = [
          "tcp://192.168.1.24:22000"
          "tcp://192.168.24.1:22000"
          "tcp://game.zumorica.es:22000"
        ];
        id = "YGAS3YA-IXVU3R5-KQR6A2Z-Z5GQCSX-XXLRS4D-4WPJQHA-CKODYMV-KZSYUQO";
        introducer = true;
      };

      MiracleCrusher = {
        addresses = [
          "tcp://192.168.24.2:22000"
        ];
        id = "SXWKC5N-MKDTRAN-ZBA4SJQ-EACWWAJ-W75C5AE-EQ354MY-CNJRQMQ-OZ67TQY";
        introducer = true;
      };

      WorkLaptop = {
        addresses = ["dynamic"];
        id = "ZAWI35R-BHTHAVO-TPB4F6E-R65K2RD-5GN7RGC-ZRCDNUT-7LYPFE2-HUYRSAF";
      };

      Pixel = {
        addresses = ["dynamic"];
        id = "RQ67OI4-SPEED6T-SPS2ZEB-NRZHJJH-555V55A-OJTZO7I-CP4NTAD-USFV5A7";
      };

      NeithDeck = {
        addresses = ["dynamic"];
        id = "SYZPJXZ-DXZGXDN-5HVLTP4-7MH45FI-YJSUP2A-ACLXJ24-MPGCSZT-IFFDRQ7";
      };
    };

    folders = {
      "/home/vera/Documents/Sync/" = {
        id = "default";
        label = "Default Sync Folder";
        devices = [ "SPACE-CATGIRL" "MiracleCrusher" "WorkLaptop" ];
      };

      "/home/vera/.xlcore/ffxivConfig" = {
        id = "ujgmj-wkmsh";
        label = "FFXIV Config";
        devices = [ "SPACE-CATGIRL" "MiracleCrusher" ];
      };

      "/home/vera/Music" = {
        id = "y0fft-chww4";
        label = "Music";
        devices = [ "SPACE-CATGIRL" "Pixel" "MiracleCrusher" ];
      };

      "/run/media/deck/mmcblk0p1/retrodeck" = {
        id = "9rctd-ets59";
        label = "Retrodeck";
        devices = [ "SPACE-CATGIRL" "MiracleCrusher" ];
      };
    };
  };
}