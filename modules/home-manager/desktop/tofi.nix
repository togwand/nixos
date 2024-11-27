{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.tofi.enable {
    home-manager.users.${user}.programs.tofi = {
      enable = true;
      settings = {
        background-color = "#000000";
        border-width = 0;
        font = "monospace";
        height = "100%";
        num-results = 5;
        outline-width = 0;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        width = "100%";
      };
    };
  };
}
