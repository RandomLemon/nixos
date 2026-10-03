{ pkgs, ... }:
{
  # Home Manager has no `programs.thunar` option (that only exists as a NixOS
  # module), so Thunar is installed here as a package. Plugins MUST go through
  # `thunarPlugins`: the override returns a wrapper that sets THUNARX_DIRS to
  # the bundled plugins and rewrites the D-Bus service files to point at the
  # wrapped binary. Listing a plugin in `home.packages` alone has no effect.
  home.packages = [
    (pkgs.thunar.override {
      thunarPlugins = [
        pkgs.thunar-archive-plugin # archive extraction/creation (backend: file-roller)
        pkgs.thunar-volman # removable media handling (needs gvfs + udisks2)
        pkgs.thunar-media-tags-plugin # audio/video tag editing
      ];
    })
    pkgs.file-roller # archive manager used by thunar-archive-plugin
    pkgs.xfconf # activates xfconfd over D-Bus so settings persist
  ];
}
