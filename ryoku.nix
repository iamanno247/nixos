# Managed by ryoku-install.
{ config, lib, pkgs, ... }:

{
  programs.ryoku = {
    enable = true;
    binaryCache.enable = true;
    defaultCompositor = "hyprland";
    browser = "chromium";
    shell = "zsh";
    optionalApps = [
      "prompt"
      "bash-edit"
      "fastfetch"
      "yazi"
      "cli-tools"
      "git-tools"
      "pavucontrol"
      "songrec"
      "openrgb"
      "upscale"
      "localsend"
      "gamescope"
      "gamemode"
      "mangohud"
      "vm"
      "docker"
      "flatpak"
      "go"
      "pytools"
      "mise"
    ];
  };

  # NVIDIA GeForce RTX 5060 Ti Configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = lib.mkForce {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    nvidiaPersistenced = true;
  };
  
 nixpkgs.config.allowUnfree = true;
}
