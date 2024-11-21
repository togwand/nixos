{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".zsh";
    defaultKeymap = "viins";
    enableCompletion = true;
    initExtraBeforeCompInit = ''
      zmodload zsh/complist
    '';
    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      compinit
    '';
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    history = {
      path = "$ZDOTDIR/.zsh_history";
      share = true;
      save = 1000;
      size = 1000;
      ignorePatterns = [
        "cd *"
        "cl"
        "ra"
      ];
    };
    historySubstringSearch = {
      enable = true;
    };
    initExtra = ''
      export PROMPT='%n:'
      export RPROMPT='%0~ %t'
      export MANPAGER='nvim +Man!'
    '';
    shellAliases = {
      ".." = "cd ..";
      "cl" = "clear";
      "ra" = "ranger";
      "re" = "systemctl reboot";
      "off" = "systemctl poweroff";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
      ];
    };
  };
}
