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
		fuzzy-match = true;
		require-match = true;
		auto-accept-single = true;
		hide-input = false;
		drun-launch = true;
        font = "sans";
        font-size = "24";
        background-color = "#000000";
		outline-width = 0;
        border-width = 0;
		prompt-text = "";
        height = "100%";
        num-results = 5;
        padding-left = "35%";
        padding-top = "35%";
        result-spacing = 25;
        width = "100%";
      };
    };
  };
}
