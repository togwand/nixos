{
  hardware.display = {
    edid = {
      enable = true;
      modelines = {
        "XG2402@120" = "274.560  1920 1928 1960 2000  1080 1130 1138 1144  +hsync -vsync";
        "XG2402@100" = "226.600  1920 1928 1960 2000  1080 1119 1127 1133  +hsync -vsync";
        "XG2402@80" = " 179.520  1920 1928 1960 2000  1080 1108 1116 1122  +hsync -vsync";
      };
    };
    outputs = {
      "DP-1" = {
        edid = "XG2402@80.bin";
      };
    };
  };
}
