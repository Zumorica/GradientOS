## GradientOS
Flake for different NixOS system configurations.

### Features
- Encrypted secrets using [sops-nix](https://github.com/Mic92/sops-nix)
- Optional Steam Deck support using [Jovian NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS)
- Supports deployments using [Colmena](https://github.com/zhaofengli/colmena)
- Spaghetti!

### Overview
- **[core](core)**: configurations that are shared across all machines
- **[hosts](hosts)**: configurations specific to certain machines
- **[lib](lib)**: utility functions
- **[misc](misc)**: for files without a clear category
- **[mixins](mixins)**: configuration presets for certain programs and services
- **[mixins/graphical](mixins/graphical)**: configuration presets for certain graphical programs and services
- **[mixins/hardware](mixins/hardware)**: configuration presets specific to certain hardware
- **[mixins/home](mixins/home)**: configuration presets for certain programs and services, using [home-manager](https://github.com/nix-community/home-manager)
- **[mixins/pipewire](mixins/pipewire)**: configuration presets for Pipewire
- **[modules](modules)**: custom NixOS modules
- **[overlays](overlays)**: nixpkgs overlays
- **[pkgs](pkgs)**: custom packages
- **[users](users)**: configurations specific to certain users, using [home-manager](https://github.com/nix-community/home-manager)
- **[users/common](users/common)**: configurations shared across all users, using [home-manager](https://github.com/nix-community/home-manager)

### Modules
- **[default](modules/default.nix)**: imports every other module in this list
- **[tmpfiles-check](modules/tmpfiles-check.nix)**: support for system-reproducibility-breaking, declarative mutable files using tmpfiles.d

### Machines

- **[miracle-crusher](hosts/miracle-crusher)**: Custom Gaming Desktop.
- **[vera-deck](hosts/vera-deck)**: Steam Deck LCD.
- **[neith-deck](hosts/neith-deck)**: Steam Deck LCD.
- **[asiyah](hosts/asiyah)**: ThinkCentre M900 Tiny Home Server.
- **[briah](hosts/briah)**: Raspberry Pi 4 Home Server.
<!-- - **atziluth**: Server. *WIP* -->