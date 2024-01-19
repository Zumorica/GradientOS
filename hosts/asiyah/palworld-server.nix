{ config, pkgs, lib, ... }:
let
  steam-app = "2394010";
  ports = import ./misc/service-ports.nix;
in {

  users.users.palworld = {
    isSystemUser = true;
    home = "/var/lib/palworld";
    createHome = true;
    homeMode = "750";
    group = config.users.groups.palworld.name;
  };

  users.groups.palworld = {};

  systemd.tmpfiles.rules = [ 
    "d ${config.users.users.palworld.home}/.steam 0755 ${config.users.users.palworld.name} ${config.users.groups.palworld.name} - -"
    "L+ ${config.users.users.palworld.home}/.steam/sdk64 - - - - /var/lib/steamcmd/apps/1007/linux64"
  ];

  systemd.services.palworld = {
    path = [ pkgs.xdg-user-dirs ];

    wantedBy = [ "multi-user.target" ];

    # Install the game before launching.
    wants = [ "steamcmd@${steam-app}.service" ];
    after = [ "steamcmd@${steam-app}.service" ];

    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${pkgs.steam-run}/bin/steam-run"
        "/var/lib/steamcmd/apps/${steam-app}/PalServer.sh"
        "-publicport=${toString ports.palworld}"
        "-useperfthreads"
        "-NoAsyncLoadingThread"
        "-UseMultithreadForDS"
        "EpicApp=PalServer"
      ];
      Nice = "-5";
      PrivateTmp = true;
      Restart = "always";
      User = config.users.users.palworld.name;
      WorkingDirectory = "~";
    };
    environment = {
      SteamAppId = "1623730";
    };
  };

  networking.firewall.allowedTCPPorts = with ports; [
    palworld
  ];

  networking.firewall.allowedUDPPorts = with ports; [
    palworld
  ];
}