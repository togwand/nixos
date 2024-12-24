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
          ignorePatterns = [ "cl" ];
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
              cursor-matchingbracket = "fg=default,bold";
              bracket-level-1 = "fg=yellow";
              bracket-level-2 = "fg=green";
              bracket-level-3 = "fg=cyan";
              bracket-level-4 = "fg=blue";
              # Main
              default = "fg=default";
              unknown-token = "fg=red";
              command = "fg=${orange}";
              alias = "fg=${orange}";
              global-alias = "fg=${orange}";
              suffix-alias = "fg=${orange}";
              hashed-command = "fg=${orange},underline";
              builtin = "fg=magenta";
              arg0 = "fg=${orange}";
              single-hyphen-option = "fg=green";
              double-hyphen-option = "fg=cyan";
              reserved-word = "fg=red,underline";
              assign = "fg=yellow,bold";
              globbing = "fg=cyan";
              function = "fg=blue";
              redirection = "fg=${silver}";
              path = "fg=yellow";
              path_pathseparator = "fg=yellow";
              path_prefix = "fg=yellow";
              path_prefix_pathseparator = "fg=yellow";
              autodirectory = "fg=yellow,underline";
              dollar-double-quoted-argument = "fg=yellow";
              single-quoted-argument = "fg=green";
              single-quoted-argument-unclosed = "fg=green";
              double-quoted-argument = "fg=green";
              double-quoted-argument-unclosed = "fg=green";
              dollar-quoted-argument = "fg=green";
              dollar-quoted-argument-unclosed = "fg=green";
              back-quoted-argument = "fg=green";
              back-quoted-argument-unclosed = "fg=green";
              back-quoted-argument-delimiter = "fg=${silver}";
              back-double-quoted-argument = "fg=blue";
              back-dollar-quoted-argument = "fg=blue";
              commandseparator = "fg=${silver}";
              precommand = "fg=magenta,underline";
              named-fd = "fg=green";
              numeric-fd = "fg=${orange}";
              command-substitution = "fg=${orange}";
              command-substitution-unquoted = "fg=${orange}";
              command-substitution-quoted = "fg=yellow";
              command-substitution-delimiter = "fg=red";
              command-substitution-delimiter-unquoted = "fg=red";
              command-substitution-delimiter-quoted = "fg=red";
              process-substitution = "fg=green";
              process-substitution-delimiter = "fg=red";
              arithmetic-expansion = "fg=${orange},underline";
              history-expansion = "fg=${silver},underline";
              rc-quote = "fg=blue";
              comment = "fg=${grey}";
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
