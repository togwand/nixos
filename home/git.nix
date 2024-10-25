{ pkgs, ... }:
{
  programs.git-credential-oauth.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "togwand@gmail.com";
    userName = "togwand";
    extraConfig = {
      remote."uakari-config-repo" = {
        url = "https://github.com/togwand/uakari-config.git";
      };
      init = {
        defaultBranch = "base";
      };
    };
  };
}
