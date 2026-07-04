{
  description = "NixOS configuration for RockPro64";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    
    # The repository for hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, impermanence, ... }: {
    nixosConfigurations.rockpro64 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = { inherit impermanence; };
      
      modules = [
        # Pull in the RockPro64 specific hardware quirks
        nixos-hardware.nixosModules.pine64-rockpro64
        
        ./configuration.nix        
      ];
    };
  };
}