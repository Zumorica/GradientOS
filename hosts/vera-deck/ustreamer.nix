{ pkgs, ... }:
let
  ports = import ./misc/service-ports.nix;
in {
  systemd.services.ustreamer = {
    description = "ustreamer webcam streamer";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "ustreamer";
      Group = "video";
      Restart = "on-failure";
      RestartSec = 1;
    };
    script = ''exec ${pkgs.ustreamer}/bin/ustreamer \
      --device /dev/v4l/by-id/usb-046d_HD_Pro_Webcam_C920-video-index0 \
      --host 0.0.0.0 \
      --port ${builtins.toString ports.ustreamer} \
      --format MJPEG \
      --resolution 1280x720 \
      --desired-fps 60 \
      --drop-same-frames 30 \
      --last-as-blank 60 \
      --device-timeout 60 \
      --workers 4 \
      --image-default \
      --slowdown'';
  };


  services.mainsail.nginx.locations = {
    "/stream".extraConfig = ''
      postpone_output 0;
      proxy_buffering off;
      proxy_ignore_headers X-Accel-Buffering;
      proxy_pass http://127.0.0.1:${toString ports.ustreamer}/stream;
    '';
    "/snapshot".extraConfig = ''
      postpone_output 0;
      proxy_buffering off;
      proxy_ignore_headers X-Accel-Buffering;
      proxy_pass http://127.0.0.1:${toString ports.ustreamer}/snapshot;
    '';
  };

  users.users.ustreamer = {
    description = "User for webcam streaming";
    isSystemUser = true;
    group = "video";
  };

  networking.firewall.interfaces.gradientnet.allowedTCPPorts = [ ports.ustreamer ];
  networking.firewall.interfaces.gradientnet.allowedUDPPorts = [ ports.ustreamer ];

  networking.firewall.interfaces.lilynet.allowedTCPPorts = [ ports.ustreamer ];
  networking.firewall.interfaces.lilynet.allowedUDPPorts = [ ports.ustreamer ];

}