{ ... }:
{

  # Wayland support for most applications.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    # SDL_VIDEODRIVER = "wayland"; # Breaks more things than not...
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

}