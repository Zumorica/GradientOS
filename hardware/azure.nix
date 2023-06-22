{ modulesPath, lib, ... }:
{

  imports = [
    "${modulesPath}/virtualisation/azure-common.nix"
  ];

  networking.networkmanager.enable = lib.mkForce false;
  systemd.network.enable = true;
  
}