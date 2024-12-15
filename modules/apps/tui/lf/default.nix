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
      home.packages = with pkgs; [
        poppler_utils
        file
        tree
        chafa
        mediainfo
        python312Packages.pygments
        python312Packages.docx2txt
      ];
      xdg.mimeApps = {
        enable = true;
        # associations.added = {};
        # associations.removed = {};
        defaultApplications = {
          "text/markdown" = [ "nvim.desktop" ];
          "text/x-todo-txt" = [ "nvim.desktop" ];
          "application/toml" = [ "nvim.desktop" ];
        };
      };
      wayland.windowManager.hyprland.settings = lib.mkIf config.apps.desktop.hyprland.enable {
        exec-once = [
          (lib.mkIf config.apps.desktop.foot.enable "[workspace 1 silent] uwsm app -- foot lf")
        ];
        bind = [
          (lib.mkIf config.apps.desktop.foot.enable "$window-easy, m, exec, uwsm app -- foot lf")
          (lib.mkIf config.apps.desktop.foot.enable "$window, m, exec, uwsm app -- foot sudo lf")
        ];
      };
      programs.lf = {
        enable = true;
        cmdKeybindings = {
          "\"<c-j>\"" = "cmd-history-next";
          "\"<c-k>\"" = "cmd-history-prev";
        };
        commands = {
          sel-info = "%echo \"MIME $(xdg-mime query filetype $f) | APP $(xdg-mime query default $(xdg-mime query filetype $f))\"";
          open = "$$OPENER $f";
        };
        previewer = {
          keybinding = "w";
          source = pkgs.writeShellScript "pv.sh" ''
            #!/bin/sh
            format_ext() {
            local formatter style
            formatter="16m" 
            style="nord"
            pygmentize -l $1 -f $formatter -O style=$style <"$2";exit
            }

            case "$1" in
            *.nix) format_ext nix "$1";;
            *.sh) format_ext shell "$1";;
            *.md) format_ext md "$1";;
            *.lock) format_ext json "$1";;
            *.txt) format_ext text "$1";;
            *.toml) format_ext toml "$1";;
            *.pdf)
            file=$(basename $1 .pdf)
            pdftocairo -jpeg -singlefile "$1" "/tmp/$file"
            if [[ -n $2 ]]
            then chafa -f sixels -s "$2x$3" "/tmp/$file.jpg";exit
            fi;;
            *.docx) docx2txt "$1";exit;;
            esac

            case "$(file -Lb --mime-type -- "$1")" in
            inode/directory) tree -l -aCL 3 --filelimit=30 --dirsfirst --noreport "$1";exit;;
            image/*)
            if [[ -n $2 ]]
            then chafa -f sixels -s "$2x$3" "$1";exit
            fi;;
            text/plain) echo<"$("$1")";exit;;
            *) mediainfo "$1";exit;;
            esac
          '';
        };
        settings = {
          anchorfind = false;
          autoquit = true;
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
          "w" = null;
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
          "I" = "sel-info";
          "[" = null;
          "]" = null;
          "\",\"" = null;
          "\";\"" = null;
          "\":\"" = "read";
          "\"'\"" = null;
          "\"&\"" = null;
          "\"/\"" = "search";
          "\"?\"" = "search-back";
          "\"<space>\"" = "tag-toggle";
          "\"<enter>\"" = "open";
          "\"<c-c>\"" = # Need to add a cadoras option to the apps modules and mkIf here if enabled
            "$cadoras";
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
