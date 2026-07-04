{
  description = "NixOS configuration for RockPro64";

  nixConfig = {
    extra-substituters = [ "https://jonahc44.cachix.org" ];
    extra-trusted-public-keys = [ "jonahc44.cachix.org-1:B1DPvVmdi5h1TGUNCFLbG8BxO9cHtu8rOLTdfjPjwbk=" ];
  };

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