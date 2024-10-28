{pkgs, ...}: {
  programs.neovim = let
    read = file: "${builtins.readFile file}";
    lua = str: "lua << EOF\n${str}\nEOF\n";
    lua-read = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      ${read ./neovim/options.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }
      {
        plugin = lualine-nvim;
        config = lua-read ./neovim/plugins/lualine.lua;
      }
    ];
  };
}
