{ pkgs, config, ... }:

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
    sops
    gmic
    age
    nil
    dig
  ] ++ (if pkgs.system == "x86_64-linux" then [
    unrar
    rar
  ] else if pkgs.system == "aarch64-linux" then [

  ] else []);
}
