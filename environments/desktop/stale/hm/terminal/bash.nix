{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = ["ignoredups"];
    shellAliases = {};
    shellOptions = [
      "checkjobs"
      "checkwinsize"
      "dotglob"
      "extglob"
      "globstar"
      "histappend"
    ];
  };
}
