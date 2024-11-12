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
        "cd"
        "cd *"
      ];
    };
    historySubstringSearch = {
      enable = false;
    };
    initExtra = ''
      # Default options to false
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
      # Custom prompts
      export PROMPT='%n:'
      export RPROMPT='%0~ %t'
    '';
    shellGlobalAliases = {
      "set-os-symlink" = "(ls flake.nix >> /dev/null 2>&1 && sudo ln -sf $PWD/flake.nix /etc/nixos/flake.nix) || echo There is no flake.nix in this directory";
      "patch-hwcfg" = ''sudo rm /etc/nixos/configuration.nix && sudo sed -i $'/fsType = "ntfs3"/a \\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix'';
      "reload-hwcfg" = "sudo nixos-generate-config && patch-hwcfg";
      "d-flake-format" = "nix fmt";
      "d-flake-update" = "nix flake update";
      "d-generate-iso-result" = "nix run nixpkgs#nixos-generators -- --format iso --flake github:togwand/nixos-install#minimal result && echo The ISO has been created";
      "d-burn-result-iso" = ''read "dev?Enter the removable device path without /dev (e.g. sdc):" && sudo wipefs /dev/$dev && sudo cp result/iso/nixos-*.iso /dev/$dev && sudo sync /dev/$dev && sudo rm -r result && echo The NixOS ISO has been burned into the device'';
      "d-create-and-burn-iso" = "d-generate-iso-result && d-burn-result-iso";
    };
    shellAliases = {
      ".." = "cd ..";
      "cl" = "clear";
      "ra" = "ranger";
      "hl" = "Hyprland";
      "re" = "systemctl reboot";
      "off" = "systemctl poweroff";
      "d-git-commit" = "d-flake-update && git add -A && d-flake-format && git add -A && git commit && git push";
      "d-git-diff" = "d-flake-format && git diff|bat";
      "os-change-now" = "reload-hwcfg && sudo nixos-rebuild switch --impure";
      "os-change-at-boot" = "reload-hwcfg && sudo nixos-rebuild boot --impure && systemctl reboot";
      "os-erase-generations" = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      "os-optimise-store" = "nix store optimise";
      "os-test" = "reload-hwcfg && sudo nixos-rebuild test --impure";
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
