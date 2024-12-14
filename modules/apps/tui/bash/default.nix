{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.bash.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.bash = {
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
  };
}
