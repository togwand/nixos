{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignoredups"];
    shellAliases = {};
    shellOptions = [
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "dotglob"
    ];
  };
}
