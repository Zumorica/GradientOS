self:
rec {

  gradientosSystem =
    { name
    , nixpkgs ? self.inputs.nixpkgs
    , ... 
    }@args:
    nixpkgs.lib.nixosSystem (gradientosSystemInternal args);

  gradientosSystemGenerator =
    { name
    , format
    , ...
    }@args:
    self.inputs.nixos-generators.nixosGenerate ((gradientosSystemInternal (args // { deployment = null; })) // { inherit format; });

  gradientosSystemColmena =
    { name
    , ...
    }@args:
    let
      gradientosConfig = gradientosSystemInternal args;
    in {
      meta = {
        nodeNixpkgs.${name} = gradientosConfig.pkgs;
        nodeSpecialArgs.${name} = gradientosConfig.specialArgs;
      };
      ${name} = gradientosConfig.modules;
    };

  gradientosSystemInternal =
    { name
    , nixpkgs ? self.inputs.nixpkgs
    , system ? "x86_64-linux"
    , modules ? [ ]
    , overlays ? [ ]
    , users ? { }
    , specialArgs ? { }
    , deployment ? {}
    , makeSystem ? true
    , importCore ? true
    , importHost ? true
    , ...
    }:
    {

      inherit system;

      specialArgs = { inherit self; } // specialArgs;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../pkgs self)
        ] ++ overlays;
      };

      modules = [
        (mkHostNameModule name)
      ] ++ modules ++ (mkUserModules users)
        ++ (if importCore then [../core] else [])
        ++ (if importHost then [../hosts/${name}] else [])
        ++ (if deployment != null then [{ inherit deployment; }] else []);

    } // (if deployment != null then {
      # See https://github.com/zhaofengli/colmena/issues/60#issuecomment-1047199551
      extraModules = [ self.inputs.colmena.nixosModules.deploymentOptions ];
    } else {});

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
