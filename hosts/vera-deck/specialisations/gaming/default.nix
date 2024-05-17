{ self, lib, ... }:
{

  imports = with self.nixosModules; [      
    mixin-system76-scheduler
    mixin-graphical
    mixin-graphical-kde
    mixin-graphical-steam
    mixin-graphical-wayland-autologin-workaround
    mixin-graphical-wayland-environment-variables
    mixin-pipewire
    mixin-pipewire-virtual-sink
    mixin-pipewire-low-latency
    mixin-hardware-xbox-one-controller
  ];

  gradient.profiles.gaming.enable = true;

  # Disable 3D printer stuff
  services.klipper.enable = lib.mkForce false;
  services.mainsail.enable = lib.mkForce false;
  services.moonraker.enable = lib.mkForce false;
  systemd.services.ustreamer.enable = lib.mkForce false;

  # Use Jovian's steam deck UI autostart.
  services.displayManager.sddm.enable = lib.mkForce false;
  jovian.steam.autoStart = true;
  jovian.steam.user = "vera";
  jovian.decky-loader.user = "vera";
  jovian.steam.desktopSession = "plasma";

}