{...}: {
  programs.ranger = {
    enable = true;
    settings = {
      show_hidden = true;
      draw_borders = "separators";
      binary_size_prefix = true;
      line_numbers = "absolute";
      preview_images = true;
      preview_images_method = "sixel";
      vcs_aware = true;
      vcs_backend_git = "enabled";
    };
  };
}
