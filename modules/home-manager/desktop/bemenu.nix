{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.desktop.bemenu.enable {
    home-manager.users.${user}.programs.bemenu = {
      enable = true;
      settings = {
        line-height = 28;
        prompt = "open";
        ignorecase = true;
        fb = "#1e1e2e";
        ff = "#cdd6f4";
        nb = "#1e1e2e";
        nf = "#cdd6f4";
        tb = "#1e1e2e";
        hb = "#1e1e2e";
        tf = "#f38ba8";
        hf = "#f9e2af";
        af = "#cdd6f4";
        ab = "#1e1e2e";
        width-factor = 0.3;
      };
    };
  };
}
