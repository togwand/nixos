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
    initExtraBeforeCompInit = builtins.readFile ./zsh/initExtraBeforeCompInit.zsh;
    completionInit = builtins.readFile ./zsh/completionInit.zsh;
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
        "ls"
        "lsblk"
        "cd *"
        "ls *"
        "rm *"
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
        "os-change-now"
        "os-change-at-boot"
        "os-erase-generations"
        "os-optimise-store"
        "os-test"
      ];
    };
    historySubstringSearch = {
      enable = false;
    };
    initExtra = builtins.readFile ./zsh/initExtra.zsh;
    shellAliases = {
      ".." = "cd ..";
      "cl" = "clear";
      "ra" = "ranger";
      "hl" = "Hyprland";
      "re" = "systemctl reboot";
      "off" = "systemctl poweroff";
      "d-flake-format" = "nix fmt";
      "d-flake-update" = "nix flake update";
      "d-git-commit" = "git add -A && git commit && git push";
      "d-git-diff" = "git diff|bat";
      "os-change-now" = "sudo nixos-rebuild switch";
      "os-change-at-boot" = "sudo nixos-rebuild boot";
      "os-erase-generations" = "nix-collect-garbage && sudo nix-collect-garbage -d";
      "os-optimise-store" = "nix store optimise";
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
