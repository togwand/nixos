{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.plugins.treesitter = {
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
  };
}
