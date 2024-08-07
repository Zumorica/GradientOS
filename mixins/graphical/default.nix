{ ... }:

{

  imports = [
    ./programs.nix
    ./fonts.nix
  ];

  # Enable the X11 windowing system.
  #services.xserver.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable XWayland for X11 compat when using wayland.
  programs.xwayland.enable = true;

  # Enable portals.
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;
  xdg.autostart.enable = true;
  
  # Enable flatpak
  services.flatpak.enable = true;
  services.packagekit.enable = true;

  hardware.graphics.enable = true;

  environment.sessionVariables = {
    # Use desktop environment's native file dialog in certain programs.
    # TODO: Breaks many things, disabled temporarily.
    # GTK_USE_PORTAL = "1";
  };

}