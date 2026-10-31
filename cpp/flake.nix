{
  description = "C++ development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
          # Tools needed for development
          packages = with pkgs; [
            # Compilers and build tools
            gcc
            cmake
            gnumake
            ninja

            # Debugging and analysis
            gdb
            valgrind
            cppcheck

            # LSP and formatting (clangd, clang-format)
            clang-tools
          ];

          # C++ libraries your project depends on
          buildInputs = with pkgs; [
            # e.g., boost, gtest, sfml
          ];

          shellHook = ''
            echo "##########################"
            echo "C++ dev environment active"
            echo "##########################"
            export CC=gcc
            export CXX=g++
          '';
        };
    };
}
