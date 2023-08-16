 { config, pkgs, ... }:

 {

  imports = [
    ./secrets
    ./nix.nix
    ./hardware-configuration.nix
    ./filesystems.nix
    ./wireguard.nix
    ./syncthing.nix
    ./kernel.nix
  ];

  networking.hostName = "miracle-crusher";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vera";
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Hack to get Wayland autologin to work.
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment.sessionVariables = {
    # Wayland support for most applications.
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  environment.systemPackages = with pkgs; [
    space-station-14-launcher
    nix-gaming.osu-stable
    gradient-generator
    xwaylandvideobridge
    prismlauncher
    xivlauncher
    starsector
  ];
}
