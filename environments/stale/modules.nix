{
  modules = {
    home-manager = {
      desktop = {
        firefox.enable = true;
        fuzzel.enable = true;
        gtk.enable = true;
        hyprland.enable = true;
        swaync.enable = true;
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
        nixos-installer.enable = false;
        shell-manager.enable = true;
      };
    };
  };
}
