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
          termguicolors = false;
          updatetime = 300;
          mouse = "a";
        };
        colorschemes = {
          # everforest = {
          #   enable = false;
          #   settings = {
          #     transparent_background = 1;
          #   };
          # };
          ayu = {
            enable = true;
            settings.mirage = true;
          };
          # base16 = {
          #   enable = true;
          #   colorscheme = "catppuccin";
          # };
        };
      };
    };
  };
}
