{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.git.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        bind = lib.mkIf config.apps.desktop.firefox.enable [
          "$window-easy, c, exec, uwsm app -- firefox -new-tab https://github.com/login/device?skip_account_picker=true"
        ];
      };
      home.packages = with pkgs; [ git-credential-oauth ];
      programs.git = {
        enable = true;
        lfs.enable = true;
        diff-so-fancy = {
          enable = true;
          pagerOpts = [
            "--tabs=4"
            "-RX"
          ];
          markEmptyLines = true;
          rulerWidth = null;
          stripLeadingSymbols = true;
          useUnicodeRuler = false;
        };
        userEmail = "togwand@gmail.com";
        userName = "togwand";
        extraConfig = {
          credential.helper = "oauth -device";
          init = {
            defaultBranch = "base";
          };
          push = {
            autoSetupRemote = true;
          };
        };
      };
    };
  };
}
