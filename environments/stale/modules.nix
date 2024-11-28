{
  modules = {
    home-manager = {
      desktop = {
        hyprland = {
          enable = true;
          hyprpaper.enable = true;
        };
        firefox.enable = true;
        gtk.enable = true;
        swaync.enable = true;
        tofi.enable = true;
        waybar.enable = true;
      };
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
      gaming = {
        mangohud.enable = true;
      };
      terminal = {
        bash.enable = true;
        bat.enable = true;
        foot.enable = true;
        ranger.enable = true;
        zsh.enable = true;
      };
    };
    overlays = {
      bash-scripts = {
        shell-manager.enable = true;
      };
    };
  };
}
