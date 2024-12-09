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
    environment.variables = {
      VISUAL = "nvim";
    };
    home-manager.users.${user}.programs.nixvim = {
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
        everforest = {
          enable = true;
          settings = {
            transparent_background = 1;
          };
        };
      };
    };
  };
}
