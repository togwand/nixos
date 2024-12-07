{
  pkgs,
  user,
  inputs,
  ...
}:
{
  home-manager = {
    desktop.enable = true;
    dev.enable = true;
    gaming.enable = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      programs.home-manager.enable = true;
      home = {
        packages = with pkgs; [
          inputs.cadoras.default
          git-credential-oauth
          wl-clipboard
          rclone
          pavucontrol
          hyprshot
          hyprpicker
          discord
          treefmt
          nixfmt-rfc-style
          beautysh
          mdsh
        ];
        file = { };
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = "25.05";
      };
    };
  };
}
