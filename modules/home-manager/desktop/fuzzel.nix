{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.fuzzel.enable {
    home-manager.users.${user}.programs.fuzzel = {
      enable = true;
      settings = {
        border.width = 0;
        main = {
          font = "sans-serif:size=16";
          use-bold = false;
          dpi-aware = false;
          icons-enabled = true;
          hide-before-typing = false;
          match-mode = "exact";
          sort-result = false;
          match-counter = false;
          filter-desktop = true;
          show-actions = false;
          list-executables-in-path = false;
          anchor = "center";
          lines = 11;
          width = 10;
          tabs = 4;
          horizontal-pad = 24;
          vertical-pad = 16;
          inner-pad = 10;
          image-size-ratio = 0;
          layer = "overlay";
          exit-on-keyboard-focus-loss = true;
        };
        colors = {
          background = "202020B4";
          text = "B4B4B4FF";
          prompt = "00000000";
          placeholder = "00000000";
          input = "FFFFFFFF";
          match = "FFFFFFFF";
          selection = "00000000";
          selection-text = "FFFFFFFF";
          selection-match = "FFFFFFFF";
          counter = "FFFFFFFF";
          border = "FFFFFFFF";
        };
      };
    };
  };
}
