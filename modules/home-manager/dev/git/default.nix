{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.home-manager.dev.git.enable {
    home-manager.users.${user}.programs = {
      git = {
        enable = true;
        lfs.enable = true;
        userEmail = "togwand@gmail.com";
        userName = "togwand";
        extraConfig = {
          credential.helper = "oauth";
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
