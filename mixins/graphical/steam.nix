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

  # See https://github.com/NixOS/nixpkgs/issues/230575
  environment.etc = {
    "ssl/certs/f387163d.0".source = "${pkgs.cacert.unbundled}/etc/ssl/certs/Starfield_Class_2_CA.crt";
    "ssl/certs/f081611a.0".source = "${pkgs.cacert.unbundled}/etc/ssl/certs/Go_Daddy_Class_2_CA:0.crt";
  };

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