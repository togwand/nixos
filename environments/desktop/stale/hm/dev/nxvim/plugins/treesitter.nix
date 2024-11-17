{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      nix
    ];
    settings = {
      highlight = {
        enable = true;
      };
    };
  };
}
