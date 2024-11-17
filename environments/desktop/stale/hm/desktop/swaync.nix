{...}: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "center";
      positionY = "top";
      layer = "overlay";
      timeout = "3";
      timeout-low = "1";
      timeout-critical = "7";
    };
  };
}
