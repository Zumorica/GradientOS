(final: super: {
  # Workaround for missing kernel modules on build.
  makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });

  # Workaround for speakers not working with alsa-ucm-conf version 1.2.9
  alsa-ucm-conf = super.alsa-ucm-conf.overrideAttrs (old: rec {
    version = "1.2.8";
    src = super.fetchurl {
      url = "mirror://alsa/lib/${old.pname}-${version}.tar.bz2";
      hash = "sha256-/uSnN4MP0l+WnYPaRqKyMb6whu/ZZvzAfSJeeCMmCug=";
    };
  });
})