{
  user,
  ...
}:
{
  config = {
    home-manager.users.${user}.programs.nixvim.plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = false;
          component_separators = {
            left = " ";
            right = " ";
          };
        };
        sections = {
          lualine_a = [
            "mode"
          ];
          lualine_b = [
            {
              __unkeyed-1 = "filename";
              file_status = true;
              new_file_status = false;
              path = 4;
              symbols = {
                modified = "[!]";
                readonly = "[X]";
                unnamed = "[?]";
              };
            }
          ];
          lualine_c = [
            "diagnostics"
          ];
          lualine_x = [
            ""
          ];
          lualine_y = [
            "branch"
            "diff"
          ];
          lualine_z = [
            "location"
          ];
        };
      };
    };
  };
}
