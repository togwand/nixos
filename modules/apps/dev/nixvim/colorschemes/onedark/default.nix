{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.colorschemes.onedark =
        lib.mkIf config.home-manager.users.${user}.programs.nixvim.colorschemes.onedark.enable
          {
            settings = {
              style = "cool";
              transparent = true;
              term_colors = true;
              ending_tildes = false;
              code_style = {
                comments = "italic";
                keywords = "none";
                functions = "none";
                strings = "none";
                variables = "none";
              };
              lualine = {
                transparent = true;
              };
            };
          };
    };
  };
}
