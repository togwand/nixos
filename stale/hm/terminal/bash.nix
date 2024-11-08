{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = false;
    historyControl = ["erasedups"];
    shellAliases = {
      ".." = "cd ..";
      tflk = "sudo nixos-rebuild test --impure --flake .";
      bflk = "sudo nixos-rebuild boot --impure --flake .";
      sflk = "sudo nixos-rebuild switch --impure --flake .";
      ra = "ranger";
    };
    shellOptions = [
      "assoc_expand_once"
      "autocd"
      "cdspell"
      "checkjobs"
      "checkwinsize"
      "cmdhist"
      "complete_fullquote"
      "dotglob"
      "expand_aliases"
      "extglob"
      "globstar"
      "histappend"
      "histverify"
      "interactive_comments"
      "lithist"
      "nocaseglob"
      "nocasematch"
      "nullglob"
      "promptvars"
      "shift_verbose"
      "sourcepath"
      "varredir_close"
      "xpg_echo"
    ];
  };
}
