{
  modules = {
    home-manager = {
      dev = {
        nixvim = {
          enable = true;
          comment.enable = true;
          lsp.enable = true;
          lualine.enable = true;
          treesitter.enable = true;
        };
        git.enable = true;
      };
      terminal = {
        bash.enable = true;
        bat.enable = true;
        ranger.enable = true;
        zsh.enable = true;
      };
    };
    overlays = {
      bash-scripts = {
        nixos-installer.enable = true;
      };
    };
  };
}
