{ ... }:

{

  imports = [
    ./nix.nix
    ./nix-direnv.nix
  ];

  systemd.user.startServices = true;
  
}