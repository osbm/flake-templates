{
  description = "My templates for nix projects";
  outputs = { self }: {
    templates = {
      pytorch = {
        path = ./pytorch;
        description = "A template for PyTorch projects";
        welcomeText = "Welcome to the PyTorch project template!";
      };
      python = {
        path = ./python;
        description = "A template for Python projects";
        welcomeText = "Welcome to the Python project template!";
      };
      rust = {
        path = ./rust;
        description = "A template for Rust projects";
        welcomeText = "Welcome to the Rust project template!";
      };
    };
  };
}