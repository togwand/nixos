{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.zsh.enable {
    users.defaultUserShell = pkgs.zsh;
    environment.pathsToLink = [ "/share/zsh" ];
    programs.zsh.enable = true;
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.zsh = {
        enable = true;
        dotDir = ".zsh";
        defaultKeymap = "viins";
        enableCompletion = true;
        # envExtra = '''';
        # loginExtra = '''';
        # logoutExtra = '''';
        # profileExtra = '''';
        # localVariables = {};
        # sessionVariables = {};
        # initExtraFirst = '''';
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
        plugins = [
          # {
          #   name = "zsh-completions";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "b4b4r07";
          #     repo = "enhancd";
          #     rev = "v2.2.1";
          #     sha256 = "0iqa9j09fwm6nj5rpip87x3hnvbbz9w9ajgm6wkrd5fls8fn8i5g";
          #   };
          # }
        ];
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
          # Custom prompts
          export PROMPT='%n:'
          export RPROMPT='%0~ %t'
          export MANPAGER='nvim +Man!'
        '';
        shellAliases = {
          ".." = "cd ..";
          "cl" = "clear";
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
          styles = {
            default = "fg=white,bold";
            command = "fg=yellow,bold";
            alias = "fg=yellow,bold";
            unknown-token = "fg=red,bold";
            arg0 = "fg=green,bold";
            path = "fg=cyan,bold";
            commandseparator = "fg=blue,bold";
            # comment = "none";
            # redirection = "none";
            # reserved-word = "none";
            # suffix-alias = "none";
            # global-alias = "none";
            # builtin = "none";
            # function = "none";
            # precommand = "none";
            # hashed-command = "fg=magenta,bold";
            # autodirectory = "fg=magenta,bold";
            # path_pathseparator = "fg=magenta,bold";
            # path_prefix = "fg=magenta,bold";
            # path_prefix_pathseparator = "fg=magenta,bold";
            # globbing = "fg=magenta,bold";
            # history-expansion = "fg=magenta,bold";
            # command-substitution = "fg=magenta,bold";
            # command-substitution-unquoted = "fg=magenta,bold";
            # command-substitution-quoted = "fg=magenta,bold";
            # command-substitution-delimiter = "fg=magenta,bold";
            # command-substitution-delimiter-unquoted = "fg=magenta,bold";
            # command-substitution-delimiter-quoted = "fg=magenta,bold";
            # process-substitution = "fg=magenta,bold";
            # process-substitution-delimiter = "fg=magenta,bold";
            # arithmetic-expansion = "fg=magenta,bold";
            # single-hyphen-option = "fg=magenta,bold";
            # double-hyphen-option = "fg=magenta,bold";
            # back-quoted-argument = "fg=magenta,bold";
            # back-quoted-argument-unclosed = "fg=magenta,bold";
            # back-quoted-argument-delimiter = "fg=magenta,bold";
            # single-quoted-argument = "fg=magenta,bold";
            # single-quoted-argument-unclosed = "fg=magenta,bold";
            # double-quoted-argument = "fg=magenta,bold";
            # double-quoted-argument-unclosed = "fg=magenta,bold";
            # dollar-quoted-argument = "fg=magenta,bold";
            # dollar-quoted-argument-unclosed = "fg=magenta,bold";
            # rc-quote = "fg=magenta,bold";
            # dollar-double-quoted-argument = "fg=magenta,bold";
            # back-double-quoted-argument = "fg=magenta,bold";
            # back-dollar-quoted-argument = "fg=magenta,bold";
            # assign = "fg=magenta,bold";
            # named-fd = "fg=magenta,bold";
            # numeric-fd = "fg=magenta,bold";
          };
        };
      };
    };
  };
}
