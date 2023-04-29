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
    ffmpeg
    yt-dlp
    sops
    gmic
    age
    nil
  ];
}
