{pkgs, ...}: {
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
      save = 20000;
      size = 20000;
      ignorePatterns = [
        ".."
        "cd *"
        "ls"
        "ls *"
        "rm *"
        "lsblk"
        "nix-prefetch-url *"
        "cl"
        "ra"
        "hl"
        "re"
        "off"
        "d-flake-format"
        "d-flake-update"
        "d-git-commit"
        "d-git-diff"
        "d-git-push"
        "os-change-now"
        "os-change-at-boot"
        "os-erase-generations"
        "os-test"
      ];
    };
    historySubstringSearch = {
      enable = false;
    };
    initExtra = ''
      unsetopt HIST_FCNTL_LOCK
      unsetopt HIST_IGNORE_DUPS
      unsetopt HIST_IGNORE_SPACE
      unsetopt SHARE_HISTORY
      # Active options
      setopt autolist
      setopt listambiguous
      setopt listpacked
      setopt listrowsfirst
      setopt globdots
      setopt histexpiredupsfirst
      setopt histfcntllock
      setopt histfindnodups
      setopt histignorespace
      setopt histreduceblanks
      setopt incappendhistory
      # Custom Prompts
      export PROMPT='%n:'
      export RPROMPT='%1~ %t'
    '';
    shellAliases = {
      ".." = "cd ..";
      "cl" = "clear";
      "ra" = "ranger";
      "hl" = "Hyprland";
      "re" = "systemctl reboot";
      "off" = "systemctl poweroff";
      "d-flake-format" = "nix fmt";
      "d-flake-update" = "nix flake update";
      "d-git-commit" = "git commit -a";
      "d-git-diff" = "git diff|bat";
      "d-git-push" = "git push";
      "os-change-now" = "sudo nixos-rebuild switch";
      "os-change-at-boot" = "sudo nixos-rebuild boot";
      "os-erase-generations" = "nix-collect-garbage && sudo nix-collect-garbage -d";
      "os-test" = "sudo nixos-rebuild test";
    };
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "pattern"
      ];
      patterns = {
      };
      styles = {
      };
    };
  };
}
