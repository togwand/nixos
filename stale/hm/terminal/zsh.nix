{...}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      strategy = [
        "history"
        "completion"
      ];
    };
    defaultKeymap = "vicmd";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ".." = "cd ..";
      tflk = "sudo nixos-rebuild test --impure --flake .";
      bflk = "sudo nixos-rebuild boot --impure --flake .";
      sflk = "sudo nixos-rebuild switch --impure --flake .";
      ra = "ranger";
    };
  };
}
