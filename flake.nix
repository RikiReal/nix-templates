{
  description = "My personal Nix flake templates";

  outputs = { self }: {
    templates = {
      cpp = {
        path = ./cpp;
        description = "C++ development environment";
      };
      default = self.templates.cpp;
    };
  };
}
