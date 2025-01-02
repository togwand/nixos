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
        keymaps = {
          lspBuf = {
            "<leader>c" = "rename";
            "<leader>a" = "code_action";
            "<leader>d" = "definition";
            "<leader>w" = "hover";
            "<leader>r" = "references";
            "<leader>t" = "type_definition";
            "<leader>i" = "implementation";
          };
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
        };
      };
    };
  };
}
