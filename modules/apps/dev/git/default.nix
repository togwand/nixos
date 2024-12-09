{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.git.enable {
    home-manager.users.${user} = {
      home.packages = with pkgs; [ git-credential-oauth ];
      programs.git = {
        enable = true;
        lfs.enable = true;
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
