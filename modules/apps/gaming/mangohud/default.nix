{
  config,
  lib,
  user,
  ...
}:
{
  config = lib.mkIf config.apps.gaming.mangohud.enable {
    home-manager.users.${user}.programs.mangohud = lib.mkIf config.generic.home-manager.enable {
      enableSessionWide = false;
      enable = true;
      settings = {
        fps_limit = "0, 60, 80, 100, 120";
        fps_limit_method = "early"; # early or late
        vsync = "-1";
        gl_vsync = "-2";

        preset = -1;
        position = "top-right";
        round_corners = 12;
        hud_no_margin = false;
        hud_compact = true;
        offset_x = -16;
        offset_y = 16;
        table_columns = 2;
        cellpadding_y = -0.2;
        background_alpha = 0.3;
        alpha = 1.0;
        text_outline = false;
        font_size = 24;
        no_small_font = false;
        gamemode = true;
        show_fps_limit = true;
        resolution = true;
        engine_version = false;
        engine_short_names = true;
        gpu_name = true;
        vulkan_driver = false;
        exec_name = true;
        present_mode = true;

        fps = true;
        fps_sampling_period = 250;
        fps_color_change = false;
        frametime = false;
        frame_count = false;
        fps_metrics = "avg, 0.01";
        frame_timing = true;
        histogram = true;

        vram = true;
        ram = true;
        # swap = true;
        procmem = true;
        procmem_shared = true;
        procmem_virt = true;

        gpu_stats = true;
        gpu_temp = true;
        gpu_junction_temp = true;
        # gpu_power = true;
        gpu_load_change = false;

        cpu_stats = true;
        cpu_temp = true;
        # cpu_power = true;
        # cpu_mhz = true;
        cpu_load_change = false;
        core_load = false;
        core_load_change = false;

        text_color = "FFFFFF";
        gpu_color = "2EBB62";
        cpu_color = "2E97DD";
        vram_color = "AD64C1";
        ram_color = "C26693";
        engine_color = "EB5B5B";
        frametime_color = "00FF00";
        background_color = "020202";
        wine_color = "EB5B5B";

        toggle_fps_limit = "Control_L+Shift_L+KP_Divide";
        toggle_hud = "Control_L+Shift_L+KP_Multiply";
        toggle_logging = "";
        reload_cfg = "Control_L+Shift_L+KP_Subtract";
        toggle_preset = "";
        upload_log = "";
        toggle_hud_position = "";
      };
    };
  };
}
