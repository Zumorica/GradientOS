{ pkgs, ... }:

{
  imports = [ ./python.nix ];

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    gradientos-upgrade-switch
    gradientos-upgrade-boot
    gradientos-upgrade-test
    dotnet-sdk_7
    appimage-run
    imagemagick
    ssh-to-age
    usbutils
    ffmpeg
    yt-dlp
    p7zip
    unrar
    sops
    gmic
    age
    nil
    rar
    dig
  ];
}
