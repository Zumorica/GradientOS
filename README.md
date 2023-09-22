## GradientOS
Flake for different NixOS system configurations.

### Features
- Encrypted secrets using [sops-nix](https://github.com/Mic92/sops-nix)
- Optional Steam Deck support using [Jovian NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
- Supports deployments using [Colmena](https://github.com/zhaofengli/colmena)
- Spaghetti!

### Overview
- **core**: configurations that are shared across all machines
- **hosts**: configurations specific to certain machines
- **lib**: utility functions
- **misc**: for files without a clear category
- **mixins**: configuration presets for certain programs and services
- **mixins/graphical**: configuration presets for certain graphical programs and services
- **mixins/hardware**: configuration presets specific to certain hardware
- **mixins/home**: configuration presets for certain programs and services, using [home-manager](https://github.com/nix-community/home-manager)
- **modules**: custom NixOS modules
- **overlays**: nixpkgs overlays
- **pkgs**: custom packages
- **users**: configurations specific to certain users, using [home-manager](https://github.com/nix-community/home-manager)
- **users/common**: configurations shared across all users, using [home-manager](https://github.com/nix-community/home-manager)

### Machines

- **miracle-crusher**: Custom Gaming Desktop.
- **vera-deck**: Steam Deck.
- **neith-deck**: Steam Deck.
- **asiyah**: ThinkCentre M900 Tiny Home Server.
- **briah**: Raspberry Pi 4 Home Server.
<!-- - **atziluth**: Server. *WIP* -->