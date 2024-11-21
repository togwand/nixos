{ ... }:
{
  programs.nixvim = {
    imports = [
      ./plugins/lualine.nix
      ./plugins/comment.nix
      ./plugins/lsp.nix
      ./plugins/treesitter.nix
    ];
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals = {
      mapleader = " ";
    };
    clipboard = {
      register = "unnamedplus";
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
    };
    colorschemes = {
      everforest.enable = true;
    };
  };
}
