{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.bash.enable {
    home-manager.users.${user}.programs.bash = lib.mkIf config.generic.home-manager.enable {
      enable = true;
      enableCompletion = true;
      historyControl = [ "ignoredups" ];
      shellAliases = { };
      shellOptions = [
        "histappend"
        "checkwinsize"
        "extglob"
        "globstar"
        "dotglob"
      ];
    };
  };
}
