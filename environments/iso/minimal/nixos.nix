{
  lib,
  modulesPath,
  pkgs,
  hm,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./hm/home-manager.nix
    hm.nixosModules.home-manager
    ../../../scripts/overlay.nix
  ];

  boot = {
    consoleLogLevel = 3;
    kernelParams = ["quiet" "udev.log_level=3"];
    initrd.verbose = false;
  };

  users.defaultUserShell = pkgs.zsh;

  console = {
    font = "t0-13b-uni.psf";
    useXkbConfig = true;
  };

  services = {
    getty = {
      greetingLine = "My minimal NixOS installation environment";
      helpLine = lib.mkForce ''
        Applications available on this installation environment:
        Installer script: nixos-installer (aliases: installer, install, installation, script)
        Configured: nixvim, zsh, ranger
        Default: git, bat, disko
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
    pathsToLink = ["/share/zsh"];
  };

  programs = {
    zsh.enable = true;
  };

  nixpkgs = {
    hostPlatform = "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings.experimental-features = ["flakes" "nix-command"];

  system.userActivationScripts.zshrc = "touch .zshrc";
}
