{ modulesPath, lib, ... }:
{

  imports = [
    "${modulesPath}/virtualisation/azure-common.nix"
    ../modules/networkd.nix
  ];

  # Forcibly disable NetworkManager.
  networking.networkmanager.enable = lib.mkForce false;

}