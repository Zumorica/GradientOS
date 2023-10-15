{ pkgs, ... }:
let
  ports = import ./misc/service-ports.nix;
in {

  services.cage = {
    enable = true;
    user = "vera";
    program = "${pkgs.unstable.chromium}/bin/chromium --noerrdialogs --disable-infobars --incognito --kiosk http://127.0.0.1:${toString ports.octoprint}";
    extraArguments = [ "-d" ];
  };

  hardware.raspberry-pi."4".fkms-3d = {
    enable = true;
    cma = 256;
  };

  systemd.services."cage-tty1".after = [ "octoprint.service" ];

  systemd.services."serial-getty@ttyS0".enable = false;
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@".enable = false;

}