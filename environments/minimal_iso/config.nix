{
  lib,
  pkgs,
  user,
  ...
}:
{
  boot = {
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    initrd.verbose = false;
  };

  users.defaultUserShell = pkgs.zsh;

  console = {
    useXkbConfig = true;
  };

  services = {
    getty = {
      greetingLine = "Minimal environment";
      helpLine = lib.mkForce ''
        Script:
        nixos-installer

        Applications:
        bat (default)
        disko (default)
        git (default)
        nixvim
        ranger
        zsh
      '';
    };
    xserver.xkb = {
      layout = "latam";
      options = "caps:swapescape";
    };
  };

  environment = {
    variables = {
      VISUAL = "nvim";
    };
    pathsToLink = [ "/share/zsh" ];
  };

  programs = {
    zsh.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      ${user} = {
        programs = {
          bat.enable = true;
          git.enable = true;
          home-manager.enable = true;
        };
        home = {
          packages = with pkgs; [
            nixos-installer
            disko
          ];
          file = { };
          username = user;
          homeDirectory = "/home/${user}";
          stateVersion = "24.11";
        };
      };
    };
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  system.stateVersion = "24.11";
}
