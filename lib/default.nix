self:
rec {

  gradientosSystem =
    { name
    , nixpkgs ? self.inputs.nixpkgs
    , ... 
    }@args:
    nixpkgs.lib.nixosSystem (removeAttrs (gradientosSystemInternal args) ["format"]);

  gradientosSystemGenerator =
    { name
    , nixpkgs ? self.inputs.nixpkgs
    , ...
    }@args:
    self.inputs.nixos-generators.nixosGenerate (gradientosSystemInternal args);

  gradientosSystemInternal =
    { name
    , nixpkgs ? self.inputs.nixpkgs
    , system ? "x86_64-linux"
    , modules ? [ ]
    , overlays ? [ ]
    , users ? { }
    , specialArgs ? { }
    , format ? "install-iso"
    , ...
    }:
    {
      inherit system format;

      specialArgs = { inherit self; } // specialArgs;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../pkgs self)
        ] ++ overlays;
      };

      modules = [
        ../core
        ../hosts/${name}
        (mkHostNameModule name)
      ] ++ modules ++ (mkUserModules users);
    };

  mkHostNameModule = name:
    ({ ... }: { networking.hostName = self.inputs.nixpkgs.lib.mkForce name; });

  mkUserModules = users: # { test = { modules = [ ./example.nix ] } }
    with self.inputs.nixpkgs.lib;
    (lists.flatten (attrsets.mapAttrsToList
      (name: value: [
        ../users/${name}
        self.inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${name} = {
            imports = [
              ../users/common/home.nix
              ../users/${name}/home.nix
            ] ++ value.modules;
          };
        }
      ])
      users));

}
