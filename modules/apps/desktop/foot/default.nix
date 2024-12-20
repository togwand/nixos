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
              fg = "D8DEE9";
              bg = "2E3440";
              red = "FF8080";
              green = "A3BE8C";
              yellow = "EBCB8B";
              blue = "81A1C1";
              fuchsia = "B48EAD";
              turquoise = "88C0D0";
              light-red = red;
              light-green = green;
              cream = yellow;
              sky-blue = blue;
              pink = fuchsia;
              cyan = turquoise;
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
              regular1 = red;
              regular2 = green;
              regular3 = yellow;
              regular4 = blue;
              regular5 = fuchsia;
              regular6 = turquoise;
              bright1 = light-red;
              bright2 = light-green;
              bright3 = cream;
              bright4 = sky-blue;
              bright5 = pink;
              bright6 = cyan;
              scrollback-indicator = fg + " " + bg;
              search-box-no-match = light-red + " " + bg;
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
