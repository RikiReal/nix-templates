{
  description = "Java development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
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
        alias idea="intellij-idea &"
        echo "##########################"
        echo "Java dev environment active"
        echo "##########################"
        export JAVA_HOME=${jdk}/lib/openjdk/
        export PATH="$JAVA_HOME/bin:$PATH"

        java -version
      '';
    };
  };
}
