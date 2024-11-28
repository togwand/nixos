{ lib, ... }:
{
  imports = [
    ./home-manager
    ./overlays
  ];
  options = {
    modules = {
      home-manager = {
        desktop = {
          hyprland = {
            enable = lib.mkEnableOption "";
            hyprpaper.enable = lib.mkEnableOption "";
          };
          firefox.enable = lib.mkEnableOption "";
          gtk.enable = lib.mkEnableOption "";
          swaync.enable = lib.mkEnableOption "";
          tofi.enable = lib.mkEnableOption "";
          waybar.enable = lib.mkEnableOption "";
        };
        dev = {
          nixvim = {
            enable = lib.mkEnableOption "";
            comment.enable = lib.mkEnableOption "";
            lsp.enable = lib.mkEnableOption "";
            lualine.enable = lib.mkEnableOption "";
            treesitter.enable = lib.mkEnableOption "";
          };
          git.enable = lib.mkEnableOption "";
        };
        gaming = {
          mangohud.enable = lib.mkEnableOption "";
        };
        terminal = {
          bash.enable = lib.mkEnableOption "";
          bat.enable = lib.mkEnableOption "";
          foot.enable = lib.mkEnableOption "";
          ranger.enable = lib.mkEnableOption "";
          zsh.enable = lib.mkEnableOption "";
        };
      };
      overlays = {
        bash-scripts = {
          nixos-installer.enable = lib.mkEnableOption "";
          shell-manager.enable = lib.mkEnableOption "";
        };
      };
    };
  };
}
