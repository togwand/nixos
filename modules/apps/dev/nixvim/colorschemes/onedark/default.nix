{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.dev.nixvim.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      programs.nixvim.colorschemes.onedark.settings =
        lib.mkIf config.home-manager.users.${user}.programs.nixvim.colorschemes.onedark.enable
          {
            style = "cool";
            transparent = false;
            lualine.transparent = true;
            ending_tildes = false;
            term_colors = false;
            highlights = {
              "@string" = {
                fg = "$green";
                fmt = "none";
              };
              "@string.escape" = {
                fg = "$blue";
                fmt = "none";
              };
              "@string.regexp" = {
                fg = "$yellow";
                fmt = "none";
              };
              "@boolean" = {
                fg = "$red";
                fmt = "none";
              };
              "@number" = {
                fg = "$orange";
                fmt = "none";
              };
              "@number.float" = {
                fg = "$orange";
                fmt = "none";
              };
              "@function" = {
                fg = "$blue";
                fmt = "none";
              };
              "@function.call" = {
                fg = "$orange";
                fmt = "none";
              };
              "@function.builtin" = {
                fg = "$purple";
                fmt = "none";
              };
              "@variable" = {
                fg = "$yellow";
                fmt = "none";
              };
              "@variable.member" = {
                fg = "$cyan";
                fmt = "none";
              };
              "@variable.parameter" = {
                fg = "$fg";
                fmt = "none";
              };
              "@variable.builtin" = {
                fg = "$yellow";
                fmt = "none";
              };
              "@constant" = {
                fg = "$cyan";
                fmt = "none";
              };
              "@constant.builtin" = {
                fg = "$cyan";
                fmt = "none";
              };
              "@keyword" = {
                fg = "$red";
                fmt = "none";
              };
              "@keyword.conditional" = {
                fg = "$red";
                fmt = "none";
              };
              "@keyword.repeat" = {
                fg = "$red";
                fmt = "none";
              };
              "@keyword.import" = {
                fg = "$red";
                fmt = "none";
              };
              "@keyword.directive" = {
                fg = "$light_grey";
                fmt = "bold";
              };
              "@operator" = {
                fg = "$light_grey";
                fmt = "none";
              };
              "@punctuation.special" = {
                fg = "$red";
                fmt = "none";
              };
              "@comment" = {
                fg = "$grey";
                fmt = "italic";
              };
              "@property.toml" = {
                fg = "$cyan";
                fmt = "none";
              };
              "@markup.heading.1.markdown" = {
                fg = "$blue";
                fmt = "bold";
              };
              "@markup.heading.2.markdown" = {
                fg = "$green";
                fmt = "bold";
              };
              "@markup.heading.3.markdown" = {
                fg = "$yellow";
                fmt = "bold";
              };
              "@markup.heading.4.markdown" = {
                fg = "$red";
                fmt = "bold";
              };
              "@markup.heading.5.markdown" = {
                fg = "$orange";
                fmt = "bold";
              };
              "@markup.heading.6.markdown" = {
                fg = "$purple";
                fmt = "bold";
              };
              "@markup.list" = {
                fg = "$cyan";
                fmt = "none";
              };
              "SpecialChar" = {
                fg = "$grey";
                fmt = "none";
              };
              "Special" = {
                fg = "$light_grey";
                fmt = "none";
              };
            };
          };
    };
  };
}
