{
  description = "Huggingface space flake";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      genPkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
      
      # Extract values from README.md front matter
      readmeContent = builtins.readFile ./README.md;
      lines = builtins.split "\n" readmeContent;
      
      # Helper function to extract YAML front matter values
      extractYamlValue = key: 
        let
          matchingLines = builtins.filter (line: 
            builtins.isString line && builtins.match "${key}: .*" line != null
          ) lines;
        in
        if matchingLines != [] then
          let match = builtins.match "${key}: (.*)" (builtins.head matchingLines);
          in if match != null then builtins.head match else null
        else null;
      
      sdk = extractYamlValue "sdk";
      appPort = extractYamlValue "app_port";
    in
    assert sdk == "docker";
    {      
      packages = forAllSystems (system: let
        pkgs = genPkgs.${system};
        pythonEnv = pkgs.python3.withPackages (ps: with ps; [
          gradio
        ]);
      in {
        default = pkgs.stdenv.mkDerivation {
          pname = "gradio-app";
          version = "0.1.0";
          src = ./.;
          buildInputs = [ pythonEnv ];
          dontBuild = true;
          installPhase = ''
            mkdir -p $out/bin
            cp ${./app.py} $out/bin/app.py
            
            # Create bash script to run gradio with python
            cat > $out/bin/run-gradio << 'EOF'
            #!/usr/bin/env bash
            set -euo pipefail

            cd "$(dirname "$0")"
            ${pythonEnv}/bin/python app.py --server-port "${appPort}" --server-name 0.0.0.0
            EOF
            
            chmod +x $out/bin/run-gradio
          '';
          meta.mainProgram = "run-gradio";
        };
      });
      # this is if you want to have a dev shell and iterate quickly
      devShells = forAllSystems (system: let
        pkgs = genPkgs.${system};
      in {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            (python3.withPackages (ps: with ps; [
              gradio
            ]))
          ];
        };
      });
    };
}