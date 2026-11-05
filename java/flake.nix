{
  description = "Java development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        pkgs.jdk21
        pkgs.maven
        pkgs.gradle
        pkgs.jetbrains.idea-community
      ];

      shellHook = ''
        alias idea='idea-community'
        echo "##########################"
        echo "Java dev environment active"
        echo "##########################"
        export JAVA_HOME="${jdk}"
        export PATH="$JAVA_HOME/bin:$PATH"

        java -version
      '';
    };
  };
}
