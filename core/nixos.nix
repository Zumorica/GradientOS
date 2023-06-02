{ ... }:

{

  imports = [
    ./nix.nix
    ./zsh.nix
    ./openssh.nix
    ./network.nix
    ./programs.nix
  ];

  xdg.autostart.enable = true;
  
  services.flatpak.enable = true;
  services.packagekit.enable = true;
  
  services.fstrim.enable = true;
  services.fwupd.enable = true;

  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;

  hardware.enableRedistributableFirmware = true;

  boot.supportedFilesystems = [ "ntfs" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}