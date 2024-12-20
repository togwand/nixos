{
  config,
  lib,
  user,
  ...
}:
{
  imports = [
    ./plugins
  ];
  config = lib.mkIf config.apps.dev.nixvim.enable {
    environment.variables = lib.mkIf config.generic.home-manager.enable {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };
    xdg.mime = lib.mkIf config.generic.home-manager.enable {
      defaultApplications = {
        "application/toml" = [ "nvim.desktop" ];
        "application/json" = [ "nvim.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
      };
    };
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        globals = {
          mapleader = " ";
        };
        clipboard = {
          register = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        opts = {
          number = true;
          relativenumber = true;
          ignorecase = true;
          tabstop = 4;
          shiftwidth = 4;
          expandtab = false;
          termguicolors = true;
          updatetime = 300;
          mouse = "a";
        };
        colorschemes = {
          nightfox = {
            enable = true;
            flavor = "nordfox";
          };
          # nord.enable = true;
          # onedark.enable = true;
        };
      };
    };
  };
}
