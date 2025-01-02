{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.plugins.telescope = {
        enable = true;
        settings.defaults = {
          initial_mode = "normal";
          sorting_strategy = "ascending";
          mappings = {
            n = {
              "q" = "close";
            };
          };
        };
        extensions.fzf-native = {
          enable = true;
          settings = {
            case_mode = "ignore_case";
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
          };
        };
        keymaps = {
          "<leader>f" = {
            action = "find_files";
          };
          "<leader>g" = {
            action = "git_files";
          };
          "<leader>h" = {
            action = "oldfiles";
          };
        };
      };
    };
  };
}
