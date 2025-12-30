{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }@inputs:
  let
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; };
    host = import ./host.nix;
  in
  {
    darwinConfigurations.${host.hostname} = nix-darwin.lib.darwinSystem {
      inherit pkgs;
      specialArgs = { inherit host; };
      modules = [ ./darwin.nix ];
    };
    
    homeConfigurations.${host.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit host; };
      modules = [ ./home.nix ];
    };
  };
}
