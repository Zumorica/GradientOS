{ pkgs, ... }:

{

  hardware.steam-hardware.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Workaround https://github.com/NixOS/nixpkgs/issues/45492
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  security.pam.loginLimits = [{
    domain = "*";
    type = "hard";
    item = "nofile";
    value = "1048576";
  }];

  # Helps some windows games running under Proton.
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  environment.sessionVariables = { WINEDEBUG = "-all"; };

  environment.systemPackages = with pkgs; [
    steam-rom-manager
    steamtinkerlaunch
    proton-caller
    protontricks
    protonup-qt
    steam-run
    lutris
  ];

}