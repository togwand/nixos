{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      border.width = 0;
      main = {
        icon-theme = "hicolor";
        icons-enabled = true;
        filter-desktop = true;
        show-actions = false;
        list-executables-in-path = false;
        anchor = "center";
        lines = 15;
        width = 30;
        tabs = 8;
        horizontal-pad = 48;
        vertical-pad = 24;
        inner-pad = 16;
        image-size-ratio = 0.5;
        layer = "overlay";
        exit-on-keyboard-focus-loss = true;
      };
      colors = {
        background = "202020B4";
        text = "B4B4B4FF";
        match = "FFFFFFFF";
        selection = "00000000";
        selection-text = "FFFFFFFF";
        selection-match = "FFFFFFFF";
        border = "FFFFFFFF";
      };
    };
  };
}
