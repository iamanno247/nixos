{ config, pkgs, ... }:

{
  home.username = "anno";
  home.homeDirectory = "/home/anno";

  # Matches system stateVersion
  home.stateVersion = "26.11";

  # User-specific packages (managed per-user instead of system-wide)
  home.packages = with pkgs; [
    # Add lightweight CLI tools or user apps here
    brave
    neovim
    steam
    kitty
    vscode
  ];

  # Declarative Git setup
  programs.git = {
    enable = true;
    userName = "anno";
    userEmail = "your.email@example.com"; # Replace with your email
  };

  # Shell configuration & convenient aliases
  programs.bash = {
    enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      ff = "fastfetch";
      conf = "cd /etc/nixos && code .";
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
