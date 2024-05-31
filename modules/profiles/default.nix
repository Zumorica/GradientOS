{ config, lib, pkgs, ... }:
let
  cfg = config.gradient;
in
{

  imports = [
    ./gaming.nix
  ];

  options = {
    gradient.profiles.default.enable = lib.mkOption {
      type = lib.types.bool;
      default = cfg.core.enable;
      description = ''
        Whether to enable the default GradientOS profile.
        Includes some pre-installed utilities and programs.
      '';
    };
  };

  config = lib.mkIf cfg.profiles.default.enable {
    programs.git.enable = true;

    environment.systemPackages = with pkgs; [
      (with dotnetCorePackages; combinePackages [
        sdk_6_0
        sdk_7_0
        sdk_8_0
      ])
      gradientos-upgrade-switch
      gradientos-upgrade-boot
      gradientos-upgrade-test
      gradientos-colmena
      appimage-run
      imagemagick
      ffmpeg-full
      lm_sensors
      ssh-to-age
      distrobox
      usbutils
      pciutils
      colmena
      waypipe
      sysstat
      yt-dlp
      p7zip
      sops
      gmic
      lsof
      htop
      file
      cloc
      nil
      age
      dig
    ] ++ (if pkgs.system == "x86_64-linux" then [
      unrar
      rar
    ] else if pkgs.system == "aarch64-linux" then [

    ] else []);
  };

}