{...}: {
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
    opts = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;
      termguicolors = false;
      updatetime = 300;
      clipboard = "unnamedplus";
    };
    colorschemes = {
      everforest.enable = true;
    };
  };
}
