 { config, pkgs, ... }:

 {

  imports = [
    ./secrets
    ./hardware-configuration.nix
    ./gradient-generator.nix
    ./filesystems.nix
    ./wireguard.nix
    ./syncthing.nix
    ./kernel.nix
    ./locale.nix
  ];

  networking.hostName = "miracle-crusher";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vera";

  services.jackett = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    nix-gaming.osu-stable
  ];
}
