{ pkgs, inputs, unstable, ... }: 
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}