{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.dev.nixvim.lsp.enable {
    home-manager.users.${user}.programs.nixvim.plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        nixd.enable = true;
        bashls.enable = true;
      };
    };
  };
}
