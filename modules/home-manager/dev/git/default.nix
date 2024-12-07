{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.home-manager.dev.git.enable {
    home-manager.users.${user}.programs = {
      git-credential-oauth.enable = true;
      git = {
        enable = true;
        lfs.enable = true;
        userEmail = "togwand@gmail.com";
        userName = "togwand";
        extraConfig = {
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
