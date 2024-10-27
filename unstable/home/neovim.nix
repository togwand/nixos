{...}: {
  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
      ${builtins.readFile ./neovim/init.lua}
    '';
  };
}
