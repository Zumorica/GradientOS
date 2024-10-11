{ self, config, pkgs, lib, ... }:
let
  cfg = config.gradient.profiles.catppuccin;
in
{

  imports = [
    self.inputs.catppuccin.nixosModules.catppuccin
  ];

  options = {
    gradient.profiles.catppuccin.enable = lib.mkEnableOption "catppuccin theming across the system";
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.enable) {
      catppuccin.enable = true;
      catppuccin.flavor = lib.mkDefault "mocha";
      
      boot.plymouth.catppuccin.enable = true;
      boot.loader.grub.catppuccin.enable = true;

      services.displayManager.sddm.catppuccin.enable = true;

      environment.systemPackages = with pkgs; [
        (catppuccin-kde.override {
          flavour = [ "mocha" ];
          accents = [ "mauve" ];
        })
        (catppuccin-gtk.override {
          variant = "mocha";
          accents = [ "mauve" ];
        })
      ];
    })
  ];

}