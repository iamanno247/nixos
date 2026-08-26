# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Dhaka";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Allow unfree packages (Mandatory for Nvidia drivers)
  nixpkgs.config.allowUnfree = true;

  # --- NVIDIA DRIVERS (Disabled for VM, uncomment when moving to host PC) ---
  # hardware.graphics = {
  #   enable = true;
  # };
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   powerManagement.finegrained = false;
  #   open = true; # Open-source kernel modules variant
  #   package = config.boot.kernelPackages.nvidiaPackages.production;
  # };
  # --------------------------------------------------------------------------

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable Docker daemon with auto-pruning
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # Enable KVM/QEMU virtualization & Virt-Manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Gaming options
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Enable Flakes and new Nix CLI
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic Nix Store Maintenance & Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.settings.auto-optimise-store = true;

  # Define a user account.
  users.users."anno" = {
    isNormalUser = true;
    description = "anno";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Applications & Tools
    git
    fastfetch
    
    # System Utilities
    p7zip
    unzip
    ripgrep
    fd
  ];

  system.stateVersion = "26.11";

}
