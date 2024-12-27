{
  config,
  lib,
  user,
  ...
}:
{
  imports = [
    ./colorschemes
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
        "inode/x-empty" = [ "nvim.desktop" ];
      };
    };
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.zsh = lib.mkIf config.apps.tui.zsh.enable {
        initExtra = ''
          # Nixvim Manpager
          export MANPAGER='nvim +Man!'
        '';
      };
      programs.nixvim =
        let
          theme = "onedark";
        in
        {
          enable = true;
          enableMan = false;
          vimAlias = true;
          viAlias = true;
          # diagnostics = { };
          colorscheme = theme;
          colorschemes.${theme}.enable = true;
          globals = {
            mapleader = " ";
          };
          clipboard = {
            register = "unnamedplus";
            providers.wl-copy.enable = true;
          };
          keymaps = [
            {
              action = "q";
              key = "m";
            }
            {
              action = "<cmd>q<CR>";
              key = "q";
            }
            {
              action = "<cmd>w<CR>";
              key = "w";
            }
          ];
          # globalOpts = { };
          # localOpts = { };
          opts = {
            autochdir = false;
            autoindent = true;
            autoread = false;
            background = "dark";
            breakindent = true;
            cedit = "^E";
            cindent = false;
            cmdheight = 1;
            cmdwinheight = 12;
            confirm = true;
            copyindent = true;
            cursorcolumn = false;
            cursorline = true;
            cursorlineopt = "number";
            errorbells = true;
            expandtab = false;
            foldclose = "all";
            helpheight = 12;
            hlsearch = true;
            ignorecase = true;
            incsearch = true;
            mouse = "a";
            number = true;
            numberwidth = 4;
            relativenumber = true;
            shiftwidth = 4;
            showmatch = false;
            showmode = false;
            smartcase = false;
            smartindent = true;
            smarttab = false;
            # tabstop = 4;
            termguicolors = true;
            updatetime = 1000;
            wrap = false;
          };
        };
    };
  };
}
