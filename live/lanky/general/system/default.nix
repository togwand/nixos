{
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

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
      greetingLine = "Lanky NixOS configuration ready";
      helpLine = lib.mkForce ''
        Install an OS with "goris"
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

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = [
    "flakes"
    "nix-command"
  ];

  system.stateVersion = "25.05";
}
