{ lib, pkgs, ... }:

{

  services.pcscd.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = lib.mkDefault "curses";
  };

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry
    pinentry-curses
  ];
}