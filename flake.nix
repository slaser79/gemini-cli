{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default =
          with pkgs;
          mkShell {
            packages = [
              nodejs_20 
              git       
            ];

            shellHook = ''
              if [  -f .env ]; then
                source .env
              fi
              echo "Entering Node.js development shell."
              echo "Node.js version: $(node -v)"
              echo "npm version: $(npm -v)"
              echo "Git version: $(git --version)"
            '';
          };
      }
    );
}
