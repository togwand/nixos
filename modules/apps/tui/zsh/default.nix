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
        # envExtra = '''';
        # initExtraFirst = ''
        #   fpath=($ZDOTDIR)
        #   autoload -Uz promptinit; promptinit
        #   prompt default
        # '';
        # cdpath = [ ];
        defaultKeymap = "viins";
        # localVariables = { };
        initExtraBeforeCompInit = ''
          zmodload zsh/complist
        '';
        enableCompletion = true;
        completionInit = ''
          autoload -U compinit
          zstyle ':completion:*' menu select
          compinit
          _comp_options+=(globdots)
        '';
        autosuggestion = {
          enable = true;
          strategy = [
            "history"
            "completion"
          ];
        };
        history = {
          size = 5000;
          save = 5000;
          ignorePatterns = [
            "cl"
          ];
          path = "$ZDOTDIR/.zsh_history";
          append = false;
          ignoreDups = false;
          ignoreAllDups = true;
          ignoreSpace = false;
          expireDuplicatesFirst = true;
          share = false;
          extended = false;
        };
        autocd = true;
        enableVteIntegration = true;
        initExtra = # bash
          ''
            # Links cursor shape to current keymap
            function zle-keymap-select {
              if [[ ''${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]
              then
                echo -ne '\e[1 q'
              elif [[ ''${KEYMAP} == main ]] || [[ ''${KEYMAP} == viins ]] || [[ ''${KEYMAP} = "" ]] || [[ $1 = 'beam' ]]
              then
                echo -ne '\e[5 q'
              fi
            }

            # Prepares keymap for vi mode
            zle -N zle-keymap-select
            echo -ne '\e[5 q'
            preexec() { echo -ne '\e[5 q' ;}

            # Extra vim keys
            bindkey -M menuselect 'h' vi-backward-char
            bindkey -M menuselect 'k' vi-up-line-or-history
            bindkey -M menuselect 'l' vi-forward-char
            bindkey -M menuselect 'j' vi-down-line-or-history

            # Extra history options
            setopt INC_APPEND_HISTORY
            setopt HIST_FIND_NO_DUPS
            setopt HIST_SAVE_NO_DUPS
            setopt HIST_NO_STORE
            setopt HIST_REDUCE_BLANKS

            # Completion options
            setopt GLOB_COMPLETE
            setopt MENU_COMPLETE

            # Glob options
            unsetopt CASE_GLOB
            unsetopt EXTENDED_GLOB

            # I/O options
            unsetopt CLOBBER

            # Prompt options
            setopt TRANSIENT_RPROMPT

            # Custom prompt
            export PROMPT='%B%F{green}%n@%M%f%b:%B%F{blue}%~/%f %F{cyan}>%f%b '
          '';
        # shellGlobalAliases = { };
        shellAliases = {
          ".." = "cd ..";
          "cl" = "clear";
          "re" = "systemctl reboot";
          "off" = "systemctl poweroff";
        };
        # dirHashes = { };
        syntaxHighlighting = {
          enable = true;
          highlighters = [
            "main"
            "brackets"
          ];
          styles =
            let
              grey = "#546178";
              silver = "#7D899F";
              orange = "#D99A5E";
            in
            {
              # Brackets
              bracket-error = "fg=red";
              cursor-matchingbracket = "fg=magenta,bold";
              bracket-level-1 = "fg=blue";
              bracket-level-2 = "fg=cyan";
              bracket-level-3 = "fg=green";
              bracket-level-4 = "fg=yellow";
              # Main
              default = "fg=default";
              unknown-token = "fg=red";
              command = "fg=${orange}";
              alias = "fg=${orange},underline";
              global-alias = "fg=${orange},underline";
              suffix-alias = "fg=${orange},underline";
              hashed-command = "fg=${orange},underline,bold";
              builtin = "fg=magenta";
              arg0 = "fg=cyan";
              path = "fg=yellow";
              autodirectory = "fg=yellow,underline";
              commandseparator = "fg=${silver}";
              redirection = "fg=${silver}";
              function = "fg=blue";
              reserved-word = "fg=magenta";
              precommand = "fg=magenta";
              comment = "fg=${grey}";
              path_pathseparator = "fg=${orange}";
              path_prefix = "fg=green";
              path_prefix_pathseparator = "fg=${orange}";
              globbing = "fg=cyan";
              history-expansion = "fg=magenta,underline";
              command-substitution = "fg=magenta,bold";
              command-substitution-unquoted = "fg=magenta,bold";
              command-substitution-quoted = "fg=magenta,bold";
              command-substitution-delimiter = "fg=magenta,bold";
              command-substitution-delimiter-unquoted = "fg=magenta,bold";
              command-substitution-delimiter-quoted = "fg=magenta,bold";
              process-substitution = "fg=magenta,bold";
              process-substitution-delimiter = "fg=magenta,bold";
              arithmetic-expansion = "fg=green,underline";
              single-hyphen-option = "fg=blue";
              double-hyphen-option = "fg=blue";
              back-quoted-argument = "fg=green";
              back-quoted-argument-unclosed = "fg=green";
              back-quoted-argument-delimiter = "fg=green";
              single-quoted-argument = "fg=green";
              single-quoted-argument-unclosed = "fg=green";
              double-quoted-argument = "fg=green";
              double-quoted-argument-unclosed = "fg=green";
              dollar-quoted-argument = "fg=green";
              dollar-quoted-argument-unclosed = "fg=green";
              rc-quote = "fg=green";
              dollar-double-quoted-argument = "fg=yellow";
              back-double-quoted-argument = "fg=blue";
              back-dollar-quoted-argument = "fg=cyan";
              assign = "fg=magenta";
              named-fd = "fg=cyan";
              numeric-fd = "fg=orange";
            };
        };
        historySubstringSearch = {
          enable = true;
          searchUpKey = [ "K" ];
          searchDownKey = [ "J" ];
        };
        # plugins = [ ];
        # loginExtra = '''';
        # logoutExtra = '''';
        # profileExtra = '''';
      };
    };
  };
}
