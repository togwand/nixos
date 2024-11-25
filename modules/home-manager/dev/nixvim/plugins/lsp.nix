{
  config,
  lib,
  user,
  ...
}:
{
  options = { };
  config = {
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
