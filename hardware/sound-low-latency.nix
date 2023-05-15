{ self, ... }:

{

  imports = [
    self.inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  services.pipewire = {
    lowLatency = {
      enable = true;
    };
  };  

}