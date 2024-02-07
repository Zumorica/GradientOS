/*
    Largely based on https://monado.freedesktop.org/valve-index-setup.html
*/
{ pkgs, ... }:
let
  monado = pkgs.stable.monado;
in {

  environment.systemPackages = [
    monado
    pkgs.stable.libsurvive
    pkgs.stable.opencomposite
    
    pkgs.stable.xrgears

    (pkgs.writeShellScriptBin "amdgpu-vr" ''
      echo "Setting AMD card to VR mode..."
      echo "4" > /sys/class/drm/card0/device/pp_power_profile_mode
      echo "Done!"
    '')
  ];

  systemd.tmpfiles.rules = [
    "L+ /run/monado - - - - ${monado}"
  ];

  environment.sessionVariables = {
    XR_RUNTIME_JSON = "/run/monado/share/openxr/1/openxr_monado.json";
    PRESSURE_VESSEL_FILESYSTEMS_RW = "$XDG_RUNTIME_DIR/monado_comp_ipc";
  };

  security.wrappers.monado-service = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+eip";
    source = "${monado}/bin/monado-service";
  };

  systemd.user.sockets.monado = {
    description = "Monado XR service module connection socket";
    unitConfig.ConditionUser = "!root";
    conflicts = [ "monado-dev.socket" ];

    listenStreams = [ "%t/monado_comp_ipc" ];
    socketConfig.RemoveOnStop = true;

    wantedBy = [ "sockets.target" ];
  };

  systemd.user.services.monado = {
    description = "Monado XR runtime service module";
    requires = [ "monado.socket" ];
    unitConfig.ConditionUser = "!root";
    conflicts = [ "monado-dev.service" ];

    script = "${monado}/bin/monado-service";
    serviceConfig.Restart = "no";
    environment = {
      XRT_COMPOSITOR_LOG = "debug";
      XRT_PRINT_OPTIONS = "on";
      IPC_EXIT_ON_DISCONNECT = "OFF";
    };
  };

}