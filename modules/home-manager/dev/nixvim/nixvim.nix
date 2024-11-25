{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.dev.nixvim.enable {
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
        everforest.enable = true;
      };
    };
  };
}
