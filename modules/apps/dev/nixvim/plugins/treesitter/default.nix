{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user}.programs.nixvim.plugins.treesitter =
      lib.mkIf config.generic.home-manager.enable
        {
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
