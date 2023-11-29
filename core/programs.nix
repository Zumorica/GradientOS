{ pkgs, config, ... }:

{
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
}
