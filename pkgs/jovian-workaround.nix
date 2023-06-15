(final: super: {
  # Workaround for missing kernel modules on build.
  makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
})