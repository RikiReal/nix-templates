{
  description = "Java development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    jdk = pkgs.jdk21;
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        jdk
        pkgs.maven
        pkgs.gradle
        pkgs.jetbrains.idea
      ];

      shellHook = ''
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
