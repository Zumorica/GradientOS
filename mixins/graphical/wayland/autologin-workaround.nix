{ ... }:
{

  # Hack to get Wayland autologin to work.
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

}