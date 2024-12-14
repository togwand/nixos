{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.plugins.lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          nixd.enable = true;
          bashls.enable = true;
        };
      };
    };
  };
}
