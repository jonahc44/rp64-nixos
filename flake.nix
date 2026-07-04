{
  description = "NixOS configuration for RockPro64";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # The repository for hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }: {
    nixosConfigurations.rockpro64 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      
      modules = [
        # Pull in the RockPro64 specific hardware quirks
        nixos-hardware.nixosModules.pine64-rockpro64
        
        ./configuration.nix        
        ./hardware-configuration.nix
      ];
    };
  };
}