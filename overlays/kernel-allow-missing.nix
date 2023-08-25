/*
*   Overlay which overrides makeModulesClosure to allow building the kernel with missing modules.
*/
final: super:
{
  makeModulesClosure = x: super.makeModulesClosure (x // { allowMissing = true; });
}