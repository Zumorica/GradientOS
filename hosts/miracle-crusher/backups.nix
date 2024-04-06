{ ... }:
{

  services.restic.backups.hokma = {
    paths = [
      "/home/vera"
    ];

    exclude = [
      ".git"

      # tmpfs, no point in backing up
      "/home/vera/tmp"

      # Too heavy and unimportant to back up
      "/home/vera/Games"
      "/home/vera/Downloads"
      "/home/vera/.xlcore/ffxiv/game"

      # No point in backing these up
      "/home/vera/.local/share/Trash"
      "/home/vera/.local/share/containers"

      # Steam games
      "/home/vera/.steam/"
      "/home/vera/.local/share/Steam/steamapps/temp"
      "/home/vera/.local/share/Steam/steamapps/*.acf"
      "/home/vera/.local/share/Steam/steamapps/common"
      "/home/vera/.local/share/Steam/steamapps/workshop"
      "/home/vera/.local/share/Steam/steamapps/sourcemods"
      "/home/vera/.local/share/Steam/steamapps/downloading"
      "/home/vera/.local/share/Steam/steamapps/shadercache"
    ];
  };

}