{ config, pkgs, ... }:
let
  ports = import ./misc/service-ports.nix;
  addresses = import ../../misc/wireguard-addresses.nix;
  ustreamer-address = "http://${addresses.gradientnet.briah}:${toString ports.ustreamer}";
  cfgPath = "/var/lib/moonraker";
in {

  services.moonraker = {
    enable = true;
    stateDir = cfgPath;
    allowSystemControl = true;
    address = "0.0.0.0";
    port = ports.moonraker;
    settings = {

      octoprint_compat = { };

      history = { };

      authorization = {
        cors_domains = [
          "*://${config.networking.hostName}:*"
        ];
        trusted_clients = [
          "127.0.0.1"
          "${addresses.gradientnet.gradientnet}/24"
        ];
      };

      file_manager = {
        check_klipper_config_path = "False";
      };

      # Enable ustreamer camera support.
      "webcam c920" = {
        enabled = "True";
        service = "uv4l-mjpeg";
        stream_url = "${ustreamer-address}/stream";
        snapshot_url = "${ustreamer-address}/snapshot";
        aspect_ratio = "16:9";
        target_fps = 30;
      };

      # Enable Telegram notification support.
      "notifier telegram" = {
        url = "tgram://{secrets.telegram.token}/{secrets.telegram.chat}";
        events = "*";
        body = "Your printer status has changed to {event_name}";
        attach = "${ustreamer-address}/snapshot";
      };

      timelapse = {
        output_path = "${cfgPath}/timelapse/";
        ffmpeg_binary_path = "${pkgs.ffmpeg}/bin/ffmpeg";
      };
    };
  };

  systemd.tmpfiles.settings."10-klipper"."${cfgPath}/config/timelapse.cfg"."L+" = {
    argument = pkgs.moonraker-timelapse.macroFile;
    user = config.services.moonraker.user;
    group = config.services.moonraker.group;
    mode = "0777";
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.moonraker ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.moonraker ];

}