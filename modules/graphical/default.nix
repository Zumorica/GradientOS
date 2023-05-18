{ ... }:

{

  imports = [
    ./programs.nix
    ./fonts.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable XWayland for X11 compat when using wayland.
  programs.xwayland.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

}