{
  description = "NixOS configuration for RockPro64";

  nixConfig = {
    extra-substituters = [ "https://jonahc44.cachix.org" ];
    extra-trusted-public-keys = [ "jonahc44.cachix.org-1:B1DPvVmdi5h1TGUNCFLbG8BxO9cHtu8rOLTdfjPjwbk=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # The repository for hardware-specific configurations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, sops-nix, ... }@inputs: {
    nixosConfigurations.rockpro64 = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      specialArgs = { inherit inputs; };
      
      modules = [
        nixos-hardware.nixosModules.pine64-rockpro64
        sops-nix.nixosModules.sops
        ./configuration.nix        
      ];
    };
  };
}