{
  description = "NixOS configuration for RockPro64";

  inputs = {
    # Using unstable, but you can change this to a stable release like nixos-23.11
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # The magical repository for hardware-specific configurations
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