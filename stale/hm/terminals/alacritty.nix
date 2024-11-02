{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        live_config_reload = false;
      };
      window = {
        padding = {
          x = 0;
          y = 0;
        };
        decorations = "None";
        opacity = 0.7;
      };
      scrolling = {
        history = 100000;
        multiplier = 3;
      };
      font = {
        normal = {
          family = "ProggySquareTT";
          style = "Regular";
        };
        bold = {
          family = "ProggySquareTT";
          style = "Bold";
        };
        size = 12;
        offset = {
          x = 0;
          y = 0;
        };
      };
      colors = {
        primary = {
          background = "#2d353b";
          foreground = "#d3c6aa";
        };
        normal = {
          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
        bright = {
          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Never";
        };
        unfocused_hollow = false;
        thickness = 0.15;
      };
      mouse = {
        hide_when_typing = false;
      };
    };
  };
}
