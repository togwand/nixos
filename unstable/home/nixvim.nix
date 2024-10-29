{...}: {
  programs.nixvim = {
    imports = [
      ./nixvim/lualine.nix
      ./nixvim/comment.nix
      ./nixvim/lsp.nix
    ];
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals = {
      mapleader = " ";
    };
    opts = {
      number = true;
      ignorecase = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = false;
      termguicolors = true;
      updatetime = 300;
      clipboard = "unnamedplus";
      mouse = "a";
    };
    colorschemes = {
      everforest.enable = true;
    };
  };
}
