{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.home-manager.tui.bash.enable {
    home-manager.users.${user}.programs.bash = {
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
