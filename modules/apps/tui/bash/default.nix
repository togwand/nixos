{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.bash.enable {
    programs.zsh.enable = true;
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.bash = {
        enable = true;
        # bashrcExtra = '''';
        enableCompletion = true;
        enableVteIntegration = true;
        historyControl = [
          "ignoredups"
          "erasedups"
        ];
        historyFileSize = 5000;
        historySize = 5000;
        historyIgnore = [ "cl" ];
        shellAliases = {
          "cl" = "clear";
          "re" = "systemctl reboot";
          "off" = "systemctl poweroff";
        };
        shellOptions = [
          "autocd"
          # "dotglob"
          # "extglob"
          # "globstar"
          "histappend"
          # "nocaseglob"
          # "nocasematch"
        ];
      };
    };
  };
}
