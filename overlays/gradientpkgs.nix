/*
*   Overlay with packages that can be consumed without using a GradientOS configuration.
*/
self: super:
{
  jack-matchmaker = super.callPackage ../pkgs/jack-matchmaker.nix { };

  starsector-gamescope-wrap = super.callPackage ../pkgs/starsector-gamescope-wrap.nix { }; 

  tinypilot = super.callPackage ../pkgs/tinypilot.nix { };

  xwaylandvideobridge = super.libsForQt5.callPackage ../pkgs/xwaylandvideobridge.nix { };

}