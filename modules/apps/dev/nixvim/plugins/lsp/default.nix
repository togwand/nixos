{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user}.programs.nixvim.plugins.lsp =
      lib.mkIf config.generic.home-manager.enable
        {
          enable = true;
          inlayHints = true;
          servers = {
            nixd.enable = true;
            bashls.enable = true;
          };
        };
  };
}
