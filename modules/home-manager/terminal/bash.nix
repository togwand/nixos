{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.modules.home-manager.terminal.bash.enable {
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
