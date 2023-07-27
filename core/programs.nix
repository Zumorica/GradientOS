{ pkgs, config, ... }:

{
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    gradientos-upgrade-switch
    gradientos-upgrade-boot
    gradientos-upgrade-test
    gradientos-colmena
    dotnet-sdk_7
    appimage-run
    imagemagick
    ssh-to-age
    usbutils
    pciutils
    colmena
    ffmpeg
    yt-dlp
    p7zip
    sops
    gmic
    lsof
    htop
    file
    nil
    age
    dig
  ] ++ (if pkgs.system == "x86_64-linux" then [
    unrar
    rar
  ] else if pkgs.system == "aarch64-linux" then [

  ] else []);
}
