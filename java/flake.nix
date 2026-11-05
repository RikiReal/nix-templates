{
  description = "Java development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Pin your preferred JDK version here (e.g. jdk17, jdk21, or default pkgs.jdk)
      jdk = pkgs.jdk21;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          # JDK runtime & compiler
          jdk

          # Build systems
          pkgs.maven
          pkgs.gradle

          # LSP & formatting
          pkgs.jdt-language-server
          pkgs.google-java-format
        ];

        shellHook = ''
          echo "###########################"
          echo "Java dev environment active"
          echo "###########################"

          # Ensure tools, IDEs, and build runners pick up this shell's JDK
          export JAVA_HOME="${jdk}"
          export PATH="$JAVA_HOME/bin:$PATH"

          java -version
        '';
      };
    };
}
