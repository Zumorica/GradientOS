{ config, lib, ... }:
let
  cfg = config.gradient;
in
{

  # TODO: Turn these into proper modules
  imports = [
    ./zsh.nix
    ./openssh.nix
    ./network.nix
    ./programs.nix
    ./nix-channels.nix
  ];

  options = {
    gradient.core.nixos.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.core.enable;
      description = ''
        Whether to enable NixOS-specific core GradientOS configurations.
        Enables some extra services by default, and also enables systemd-based initrd.
      '';
    };
  };

  config = lib.mkIf cfg.core.nixos.enable {
    services.fstrim.enable = true;
    services.fwupd.enable = true;

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;

    security.rtkit.enable = true;
    security.polkit.enable = true;

    programs.dconf.enable = true;
    programs.nix-ld.enable = true;

    hardware.enableRedistributableFirmware = true;

    # systemd-based initrd
    boot.initrd.systemd.enable = true;

    boot.supportedFilesystems = [ "ntfs" ];

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.11"; # Did you read the comment?
  };

}