{
  description = "My templates for nix projects";
  outputs = { self }: {
    templates = {
      default = self.templates.python;
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
      huggingface-space = {
        path = ./huggingface-space;
        description = "A template for Huggingface Space, that builds with Nix!";
        welcomeText = "Welcome to the Huggingface Space template!";
      };
      devshell = {
        path = ./devshell;
        description = "A template for a simple devshell";
        welcomeText = "Welcome to the devshell template!";
      };
    };
  };
}
