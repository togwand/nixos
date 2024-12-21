{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.tui.lf.enable {
    home-manager.users.${user} = lib.mkIf config.generic.home-manager.enable {
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        exec-once = [
          (lib.mkIf config.apps.desktop.foot.enable "[workspace 1 silent] uwsm app -- foot lf")
        ];
        bind = [
          (lib.mkIf config.apps.desktop.foot.enable "$window-easy, m, exec, uwsm app -- foot lf")
          (lib.mkIf config.apps.desktop.foot.enable "$window, m, exec, uwsm app -- foot sudo lf")
        ];
      };
      home.packages = with pkgs; [
        ctpv
        tree
        atool
        ffmpegthumbnailer
        highlight
        chafa
        poppler_utils
      ];
      home.file.".config/ctpv/config".text = # bash
        ''
          set nosymlinkinfo
          remove libreoffice
          remove torrent
          remove glow
          remove mdcat
          remove gpg
          remove bat
          remove cat
          remove ls
          remove delta
          remove colordiff
          remove elinks
          remove lynx
          remove w3m
          remove source_highlight

          preview tree inode/directory {{
           tree -l -aCL 3 --filelimit=30 --dirsfirst --noreport "$f"
          }}
        '';
      programs.lf = {
        enable = true;
        cmdKeybindings = {
          "\"<c-j>\"" = "cmd-history-next";
          "\"<c-k>\"" = "cmd-history-prev";
        };
        extraConfig = ''
          &ctpv -s $id
          &ctpvquit $id
        '';
        commands = {
          ctpv-info = "%echo \"$(ctpv -m $f)\"";
          open = # bash
            ''
              &{{
              case "$f" in
              *.nix) lf -remote "send $id \$$EDITOR \$f";;
              *.sh) lf -remote "send $id \$$EDITOR \$f";;
              *.md) lf -remote "send $id \$$EDITOR \$f";;
              *.toml) lf -remote "send $id \$$EDITOR \$f";;
              *.lock) lf -remote "send $id \$$EDITOR \$f";;
              *.txt) lf -remote "send $id \$$EDITOR \$f";;
              *.png) lf -remote "send $id \$$BROWSER \$f";;
              *.jpg) lf -remote "send $id \$$BROWSER \$f";;
              *.jpeg) lf -remote "send $id \$$BROWSER \$f";;
              *.mp4) lf -remote "send $id \$$BROWSER \$f";;
              *.mp3) lf -remote "send $id \$$BROWSER \$f";;
              *.pdf) lf -remote "send $id \$$BROWSER \$f";;
              *) lf -remote "send $id \$xdg-open \$f";;
              esac
              }}
            '';
        };
        settings = {
          anchorfind = false;
          autoquit = true;
          cleaner = "ctpvclear";
          dircache = false;
          dircounts = false;
          dirfirst = true;
          dironly = false;
          dirpreviews = true;
          drawbox = true;
          globfilter = false;
          globsearch = false;
          hidden = true;
          history = true;
          icons = false;
          ignorecase = true;
          ignoredia = true;
          incsearch = true;
          incfilter = true;
          info = [
            "size"
          ];
          mouse = false;
          number = false;
          preview = true;
          previewer = "ctpv";
          ratios = [
            3
            4
          ];
          reverse = false;
          roundbox = false;
          rulerfmt = "";
          selmode = "dir";
          showbinds = false;
          sixel = true;
          smartcase = true;
          smartdia = true;
          sortby = "ext";
          statfmt = "%t| %u| \\033[36m%p\\033[0m| -> %l";
          tabstop = 4;
          timefmt = "02-01-2006";
          truncatechar = "~";
          watch = false;
          wrapscan = true;
          wrapscroll = false;
        };
        keybindings = {
          "z" = "push $mkdir<space>";
          "x" = "push $touch<space>";
          "c" = "clear";
          "v" = "toggle";
          "n" = "search-next";
          "m" = "mark-load";
          "s" = null;
          "d" = "cut";
          "f" = "filter";
          "h" = "updir";
          "j" = "down";
          "k" = "up";
          "l" = "open";
          "q" = "quit";
          "w" = "$ctpv $f | less -R";
          "r" = "rename";
          "t" = null;
          "y" = "copy";
          "u" = "unselect";
          "i" = null;
          "p" = "paste";
          "gg" = "top";
          "gh" = null;
          "V" = "invert";
          "N" = "search-prev";
          "M" = "mark-save";
          "F" = null;
          "G" = "bottom";
          "H" = "set hidden!";
          "L" = null;
          "I" = "ctpv-info";
          "[" = null;
          "]" = null;
          "\",\"" = null;
          "\";\"" = null;
          "\":\"" = "read";
          "\"'\"" = null;
          "\"&\"" = "shell-async";
          "\"/\"" = "search";
          "\"?\"" = "search-back";
          "\"<space>\"" = "tag-toggle";
          "\"<enter>\"" = "open";
          "\"<c-c>\"" = lib.mkIf config.derivations.tools.cadoras.enable "$cadoras";
          "\"<c-b>\"" = null;
          "\"<c-s>\"" = "$$SHELL";
          "\"<c-d>\"" = "half-down";
          "\"<c-f>\"" = "search";
          "\"<c-l>\"" = null;
          "\"<c-r>\"" = "reload";
          "\"<c-u>\"" = "half-up";
          "\"<c-y>\"" = null;
          "\"<left>\"" = null;
          "\"<down>\"" = null;
          "\"<right>\"" = null;
          "\"<up>\"" = null;
          "\"<delete>\"" = "delete";
          "\"<pgdn>\"" = null;
          "\"<pgup>\"" = null;
        };
      };
    };
  };
}
