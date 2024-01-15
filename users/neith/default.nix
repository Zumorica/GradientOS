{ pkgs, ... }:

{

  users.users.neith = {
    isNormalUser = true;
    description = "Neith";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "scanner" "lp" ];
    hashedPassword = "$6$7mwTIbQIbSE9s6h5$J1Z5xG3V5kY65pgSQKulKg5UpVUnKuHnZoXmZ98IMCRNXhLHWgEAbizz8g4d1IJvDMp/pLBl4EKK.0fzcyb6N0";
  };

  # Temporary workaround to enable user lingering.
  systemd.tmpfiles.rules = [
    "f /var/lib/systemd/linger/neith"
  ];

}