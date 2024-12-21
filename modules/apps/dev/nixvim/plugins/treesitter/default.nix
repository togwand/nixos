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
        folding = false;
        nixGrammars = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
          bash
          json
          toml
          markdown
        ];
        settings = {
          auto-install = false;
          highlight.enable = true;
          indent.enable = false;
        };
      };
    };
  };
}
