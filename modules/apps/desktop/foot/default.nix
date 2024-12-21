{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.desktop.foot.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.foot = {
        enable = true;
        server.enable = false;
        settings = {
          main = {
            font = "monospace:size=16.5:weight=Regular";
            font-size-adjustment = 0.5;
            box-drawings-uses-font-glyphs = false;
            dpi-aware = false;
            pad = "0x0";
            resize-by-cells = false;
            resize-keep-grid = false;
            selection-target = "clipboard";
            bold-text-in-bright = false;
          };
          bell = {
            urgent = true;
            notify = true;
            visual = false;
          };
          desktop-notifications = {
            inhibit-when-focused = true;
          };
          scrollback = {
            lines = 4000;
            multiplier = 2.0;
            indicator-position = "relative";
            indicator-format = "line";
          };
          cursor = {
            style = "beam";
            unfocused-style = "none";
            blink = false;
            beam-thickness = "2px";
          };
          mouse = {
            hide-when-typing = false;
          };
          colors =
            let
              fg = "A5B0C5";
              bg = "242B38";
              mild-red = "EF5F6B";
              mild-green = "97CA72";
              mild-yellow = "EBC275";
              mild-blue = "5AB0F6";
              mild-fuchsia = "CA72E4";
              mild-cyan = "4DBDCB";
              pastel-red = mild-red;
              pastel-green = mild-green;
              pastel-yellow = mild-yellow;
              pastel-blue = mild-blue;
              pastel-pink = mild-fuchsia;
              pastel-cyan = mild-cyan;
              white = "ffffff";
              silver = "cfcfcf";
              gray = "808080";
              black = "000000";
            in
            {
              alpha = 1.0;
              foreground = fg;
              background = bg;
              regular0 = black;
              bright0 = gray;
              regular7 = silver;
              bright7 = white;
              regular1 = mild-red;
              regular2 = mild-green;
              regular3 = mild-yellow;
              regular4 = mild-blue;
              regular5 = mild-fuchsia;
              regular6 = mild-cyan;
              bright1 = pastel-red;
              bright2 = pastel-green;
              bright3 = pastel-yellow;
              bright4 = pastel-blue;
              bright5 = pastel-pink;
              bright6 = pastel-cyan;
              scrollback-indicator = fg + " " + bg;
              search-box-no-match = mild-red + " " + bg;
              search-box-match = fg + " " + bg;
              flash = gray;
              flash-alpha = "0.05";
            };
          csd = {
            preferred = "none";
          };
          key-bindings = {
            scrollback-up-page = "none";
            scrollback-down-page = "none";
            scrollback-up-half-page = "Control+Shift+k";
            scrollback-down-half-page = "Control+Shift+j";
            scrollback-up-line = "Control+k";
            scrollback-down-line = "Control+j";
            clipboard-copy = "Control+Shift+c";
            clipboard-paste = "Control+Shift+v";
            primary-paste = "none";
            font-decrease = "Control+1";
            font-increase = "Control+2";
            font-reset = "Control+3";
            search-start = "Control+f";
            spawn-terminal = "Control+n";
            show-urls-launch = "none";
            prompt-prev = "none";
            prompt-next = "none";
            unicode-input = "none";
          };
          search-bindings = {
            cancel = "Escape";
            commit = "Control+m";
            find-next = "Control+n";
            find-prev = "Control+Shift+n";
            cursor-left = "none";
            cursor-left-word = "none";
            cursor-right = "none";
            cursor-right-word = "none";
            cursor-home = "none";
            cursor-end = "none";
            delete-prev = "Control+h";
            delete-prev-word = "none";
            delete-next = "none";
            delete-next-word = "none";
            extend-char = "none";
            extend-to-word-boundary = "none";
            extend-to-next-whitespace = "none";
            extend-line-down = "none";
            extend-backward-char = "none";
            extend-backward-to-word-boundary = "none";
            extend-line-up = "none";
            clipboard-paste = "Control+Shift+v";
            primary-paste = "none";
            scrollback-up-page = "none";
            scrollback-down-page = "none";
            scrollback-up-half-page = "Control+Shift+k";
            scrollback-down-half-page = "Control+Shift+j";
            scrollback-up-line = "Control+k";
            scrollback-down-line = "Control+j";
          };
          mouse-bindings = {
            scrollback-up-mouse = "BTN_WHEEL_BACK";
            scrollback-down-mouse = "BTN_WHEEL_FORWARD";
            select-begin = "none";
            select-begin-block = "BTN_RIGHT";
            select-word = "BTN_LEFT";
            select-word-whitespace = "none";
            select-quote = "none";
            select-row = "none";
            select-extend = "none";
            select-extend-character-wise = "none";
            primary-paste = "none";
            font-increase = "none";
            font-decrease = "none";
          };
        };
      };
    };
  };
}
