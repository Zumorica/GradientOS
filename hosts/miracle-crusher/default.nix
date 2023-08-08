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

  environment.systemPackages = with pkgs; [
    nix-gaming.osu-stable
    gradient-generator
  ];
}
