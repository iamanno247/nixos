{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   security.wrappers.Hyprland.source =
  lib.mkForce "${config.programs.hyprland.package}/bin/.Hyprland-wrapped";

   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   nix.settings.access-tokens = "";

  # Bootloader.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."anno" = {
    isNormalUser = true;
    description = "ANNO";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Environment variables for npm packages in home directory
   environment.sessionVariables = {
     PATH = [ "$HOME/.npm-packages/bin" ];
  };

# Enable nix-ld to execute standard unpatched binaries
  programs.nix-ld.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
     inputs.voxtype.packages.${pkgs.system}.vulkan
     wtype
     wl-clipboard
     hyprpolkitagent
     git
     brave
     vscode
     qbittorrent
     nodejs
     (discord.override {
       withVencord = true;
     })
  ];

  system.stateVersion = "26.05";
}
