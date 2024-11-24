{
  user,
  ...
}:
{
  home-manager.users.${user}.imports = {
        imports = [
          ./desktop/firefox.nix
          ./desktop/hyprland.nix
          ./desktop/swaync.nix
          ./desktop/fuzzel.nix
          ./desktop/gtk.nix
        ];
  };
}
