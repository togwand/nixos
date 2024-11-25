{
  modules = {
    home-manager = {
      desktop = {
        firefox.enable = false;
        fuzzel.enable = false;
        gtk.enable = false;
        hyprland.enable = false;
        swaync.enable = false;
      };
      dev = {
        git.enable = true;
        nixvim = {
          enable = true;
          comment.enable = true;
          lsp.enable = true;
          lualine.enable = true;
          treesitter.enable = true;
        };
      };
      gaming = {
        mangohud.enable = false;
      };
      terminal = {
        bash.enable = true;
        bat.enable = true;
        foot.enable = false;
        ranger.enable = true;
        zsh.enable = true;
      };
    };
    overlays = {
      bash-scripts = {
        nixos-installer.enable = true;
        shell-manager.enable = false;
      };
    };
  };
}
