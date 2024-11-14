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
      "os.patch-hwcfg" = ''sudo rm /etc/nixos/configuration.nix && sudo sed -i $'/fsType = "ntfs3"/a \\      options = ["uid=1000"];' /etc/nixos/hardware-configuration.nix'';
      "os.reload-hwcfg" = "sudo nixos-generate-config && os.patch-hwcfg";
      "flk.prepare" = "nix flake update && nix fmt";
      "os.prepare-build" = "os.reload-hwcfg && flk.prepare";
      "build-minimal-iso" = "nix build github:togwand/nixos-install#nixosConfigurations.minimal.config.system.build.isoImage && echo NixOS ISO created";
      "burn-iso" = ''lsblk --noheadings --nodeps && read "dev?Enter the removable device path without /dev (e.g. sdc): " && read -s "confirmed?Are you sure you want to burn the iso into /dev/$dev? Confirm (RETURN) or abort (CTRL+C)..." && echo && sudo wipefs /dev/$dev && sudo cp result/iso/nixos-*.iso /dev/$dev && sudo sync /dev/$dev && sudo rm -r result && echo NixOS ISO burned into /dev/$dev''; # THIS REALLY NEEDS TO BECOME A SCRIPT ONCE I SORT THE NIXOSINSTALL REPO
    };
    shellAliases = {
      ".." = "cd ..";
      "cl" = "clear";
      "ra" = "ranger";
      "hl" = "Hyprland";
      "re" = "systemctl reboot";
      "off" = "systemctl poweroff";
      "g.diff" = "flk.prepare && git diff | bat";
      "g.push-after-commit" = "git add -A && flk.prepare && git add -A && git commit && git push";
      "os.cfg-build-test" = "os.prepare-build && sudo nixos-rebuild test --impure --flake .";
      "os.cfg-new-build-no-reboot" = "os.prepare-build && sudo nixos-rebuild switch --impure --flake .";
      "os.cfg-new-build-reboot" = "os.prepare-build && sudo nixos-rebuild boot --impure --flake . && systemctl reboot";
      "os.storage-optimise-partial" = "nix-collect-garbage && sudo nix-collect-garbage && nix store optimise";
      "os.storage-optimise-full" = "nix-collect-garbage -d && sudo nix-collect-garbage -d && nix store optimise";
      "tools.burn-new-minimal-iso" = "build-minimal-iso && burn-iso";
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
