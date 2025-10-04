{
  description = "Development Shell For this repository";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = {
    nixpkgs,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.cudaSupport = system == "x86_64-linux";
      };

      pythonWithDeps = pkgs.python312.withPackages (
        ppkgs: with pkgs.python312Packages; [
            pip
            (if system == "x86_64-linux" then torchWithCuda else torch)
            ipython
          ]
      );
    in {
      default = pkgs.mkShell {
        packages = [
          pythonWithDeps
        ];
        shellHook = ''
          echo 'Welcome to the ai development.'
          echo 'Python version: ${pythonWithDeps.python.version}'
          echo 'Python path: ${pythonWithDeps}'
        '';
      };
    });
  };
}