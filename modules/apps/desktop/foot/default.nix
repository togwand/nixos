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
            font = "monospace:size=18.5:weight=Regular";
            font-size-adjustment = 0.5;
            box-drawings-uses-font-glyphs = false;
            dpi-aware = false;
            pad = "0x0";
            resize-by-cells = false;
            resize-keep-grid = false;
            bold-text-in-bright = false;
          };
          scrollback = {
            lines = 5000;
            multiplier = 1;
          };
          mouse = {
            hide-when-typing = true;
          };
          cursor = {
            style = "beam";
            unfocused-style = "none";
            blink = false;
            beam-thickness = "2px";
          };
          colors = {
            alpha = 1.0;
            foreground = "cccac2";
            background = "1f2430";
            regular0 = "242936"; # black
            regular1 = "f28779"; # red
            regular2 = "d5ff80"; # green
            regular3 = "ffd173"; # yellow
            regular4 = "73d0ff"; # blue
            regular5 = "dfbfff"; # magenta
            regular6 = "5ccfe6"; # cyan
            regular7 = "cccac2"; # white
            bright0 = "fcfcfc"; # bright black
            bright1 = "f07171"; # bright red
            bright2 = "86b300"; # bright gree
            bright3 = "f2ae49"; # bright yellow
            bright4 = "399ee6"; # bright blue
            bright5 = "a37acc"; # bright magenta
            bright6 = "55b4d4"; # bright cyan
            bright7 = "5c6166"; # bright white
          };
          csd = {
            preferred = "server";
          };
        };
      };
    };
  };
}
