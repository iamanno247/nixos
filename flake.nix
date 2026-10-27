{
  inputs = {
    ryoku = {
      url = "github:ryoku-dev/Ryoku-on-NixOS/main";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    voxtype.url = "github:peteonrails/voxtype";
  };

  outputs = { ryoku, nixpkgs, voxtype, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ryoku.nixosModules.default
        ./ryoku.nix
        ./configuration.nix
      ];
    };
  };
}
