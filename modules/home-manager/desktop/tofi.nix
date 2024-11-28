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
        hide-cursor = true;
        text-cursor = true;
        history = true;
        fuzzy-match = false;
        require-match = true;
        auto-accept-single = true;
        hide-input = false;
        drun-launch = true;
        terminal = "foot";
        multi-instance = false;
        font = "sans";
        font-size = "24";
        background-color = "#00000099";
        outline-width = 0;
        border-width = 0;
        text-color = "#ffffffff";
        num-results = 0;
        result-spacing = 8;
        width = "0%";
        height = "0%";
        padding-left = "39%";
        padding-top = "28%";
      };
    };
  };
}
