{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  options = { };
  config = {
    home-manager.users.${user}.programs.ranger = {
      enable = true;
      extraPackages = with pkgs; [
        poppler_utils
        mediainfo
      ];
      settings = {
        automatically_count_files = false;
        autosave_bookmarks = true;
        autoupdate_cumulative_size = false;
        binary_size_prefix = true;
        column_ratios = "10,7";
        collapse_preview = false;
        colorscheme = "default";
        confirm_on_delete = true;
        dirname_in_tabs = false;
        display_free_space_in_status_bar = false;
        display_size_in_main_column = true;
        display_size_in_status_bar = false;
        display_tags_in_all_columns = true;
        draw_borders = "both";
        draw_progress_bar_in_status_bar = true;
        hostname_in_titlebar = false;
        line_numbers = "false";
        padding_right = false;
        preview_directories = true;
        preview_files = true;
        preview_images = true;
        preview_images_method = "sixel";
        preview_max_size = 0;
        save_backtick_bookmark = false;
        show_hidden = true;
        show_selection_in_titlebar = false;
        size_in_bytes = false;
        sort_case_insensitive = true;
        status_bar_on_top = false;
        tilde_in_titlebar = true;
        unicode_ellipsis = true;
        vcs_aware = true;
        vcs_backend_git = "enabled";
        viewmode = "miller";
        sixel_dithering = "None";
        wrap_plaintext_previews = false;
        wrap_scroll = true;
      };
    };
  };
}
