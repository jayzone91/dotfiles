{
  description = "Jay's Arch Linux workstation configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations.jay = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./nix/hosts/archlinux
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system}.home-manager = self.homeConfigurations.jay.activationPackage;
    };
}
