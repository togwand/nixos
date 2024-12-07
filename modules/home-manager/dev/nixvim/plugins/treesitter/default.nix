{
  pkgs,
  user,
  ...
}:
{
  config = {
    home-manager.users.${user}.programs.nixvim.plugins.treesitter = {
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
  };
}
