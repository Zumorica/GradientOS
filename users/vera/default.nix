{ config, pkgs, ... }:

{

  users.users.vera = {
    isNormalUser = true;
    description = "Vera";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "scanner" "lp" "libvirtd" ];
    hashedPassword = "$6$mTrvQELm1M1xnRO3$C8.NuZcgEKqW.QHFjABHk4Wkufa4FT0VpAzzgbuF1nwpx719/91uOpnq5JgY1C9LOi55d49VSp7H.KJ/iy74r.";
  };

}