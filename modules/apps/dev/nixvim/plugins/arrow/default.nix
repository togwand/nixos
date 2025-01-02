{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.plugins.arrow = {
        enable = true;
        settings = {
          always_show_path = true;
          global_bookmarks = false;
          hide_handbook = true;
          leader_key = "|";
          save_key = "git_root";
          separate_by_branch = true;
          show_icons = true;
        };
      };
    };
  };
}
