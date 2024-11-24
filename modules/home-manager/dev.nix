{
  user,
  ...
}:
{
  home-manager.users.${user}.imports = {
        imports = [
          ./dev/git.nix
          ./desktop/hyprland.nix
          ./desktop/swaync.nix
          ./desktop/fuzzel.nix
          ./desktop/gtk.nix
        ];
  };
}
