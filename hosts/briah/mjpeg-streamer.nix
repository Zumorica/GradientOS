{ ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.mjpg-streamer = {
      enable = true;
      # https://github.com/jacksonliam/mjpg-streamer/blob/master/mjpg-streamer-experimental/plugins/input_uvc/README.md
      inputPlugin = "input_uvc.so --device /dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920-video-index0 --resolution 1920x1080 --fps 30 -timeout 120 -pl 50hz";
      outputPlugin = "output_http.so --www @www@ --nocommands --port ${toString ports.mjpg-streamer}";
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.mjpg-streamer ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.mjpg-streamer ];

  networking.firewall.interfaces.lilynet.allowedTCPPorts = [ ports.mjpg-streamer ];
  networking.firewall.interfaces.lilynet.allowedUDPPorts = [ ports.mjpg-streamer ];

}