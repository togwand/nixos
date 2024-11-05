{...}: {
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        font = "monospace:size=10:weight=Bold";
        font-size-adjustment = 1;
        box-drawings-uses-font-glyphs = false;
        dpi-aware = false;
        pad = "0x0";
        resize-delay-ms = 500;
        resize-by-cells = false;
        resize-keep-grid = false;
        bold-text-in-bright = false;
      };
      scrollback = {
        lines = 10000;
        multiplier = 1;
      };
      cursor = {
        style = "beam";
        unfocused-style = "none";
        blink = true;
        blink-rate = "500";
        beam-thickness = "2px";
      };
      mouse = {
        hide-when-typing = true;
      };
      colors = {
        alpha = 1.0;
        background = "2d353b";
        foreground = "d3c6aa";
        regular0 = "475258"; # Black
        bright0 = "475258"; # Black
        regular1 = "e67e80"; # Red
        bright1 = "e67e80"; # Red
        regular2 = "a7c080"; # Green
        bright2 = "a7c080"; # Green
        regular3 = "dbbc7f"; # Yellow
        bright3 = "dbbc7f"; # Yellow
        regular4 = "7fbbb3"; # Blue
        bright4 = "7fbbb3"; # Blue
        regular5 = "d699b6"; # Magenta
        bright5 = "d699b6"; # Magenta
        regular6 = "83c092"; # Cyan
        bright6 = "83c092"; # Cyan
        regular7 = "d3c6aa"; # White
        bright7 = "d3c6aa"; # White
      };
      csd = {
        preferred = "none";
      };
    };
  };
}
