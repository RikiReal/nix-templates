{
  description = "My personal Nix flake templates";

  outputs = { self }: {
    templates = {
      cpp = {
        path = ./cpp;
        description = "C++ development environment";
      };
      java = {
        path = ./java;
        description = "Java development environment";
      };
      default = self.templates.cpp;
    };
  };
}
