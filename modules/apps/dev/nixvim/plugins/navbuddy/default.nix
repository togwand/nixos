{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim = {
        plugins.navbuddy = {
          enable = true;
          lsp.autoAttach = true;
        };
        keymaps = [
          {
            action = "<cmd>Navbuddy<CR>";
            key = "<leader>n";
          }
        ];
      };
    };
  };
}
