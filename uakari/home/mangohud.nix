{...}: {
  programs.mangohud = {
    enableSessionWide = false;
    enable = true;
    settings = {
      fps_limit = "60, 90, 120, 144, 0";
      fps_limit_method = "early"; # "early" or "late"
      vsync = "1"; # 0 adaptive, 1 off, 2 mailbox, 3 on
      gl_vsync = "0"; # 0 off, anything over 0: refresh rate/(number)
      # picmip = -16; # [-16 to 16]. Negative sharp, positve blurry
      # af = 16; # [0 to 16]
      # bicubic = true;
      # trilinear = true;
      # retro = true;

      preset = -1; # -1 default, 0 nothing, 1 fps only, 2 horizontal, 3 extended, 4 full
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
      # text_outline_color = "000000";
      # text_outline_thickness = 1.5;
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
      # fps_value = "30,60";
      # fps_color = "B22222,FDFD09,39F900";
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
      # gpu_load_value= "60, 90";
      # gpu_load_color= "39F900,FDFD09,B22222";
      # gpu_fan = true;

      cpu_stats = true;
      cpu_temp = true;
      # cpu_power = true;
      # cpu_mhz = true;
      cpu_load_change = false;
      # cpu_load_value = "60,90";
      # cpu_load_color = "39F900,FDFD09,B22222";
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

      toggle_hud = "Control_R+Shift_R+KP_Divide";
      toggle_fps_limit = "Control_R+Shift_R+KP_Multiply";
      reload_cfg = "Control_R+Shift_R+F10+KP_Subtract";
      toggle_logging = "";
      upload_log = "";
      toggle_hud_position = "";
      toggle_preset = "";
    };
  };
}
