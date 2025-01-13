self: super: {
  my-freerouting = super.callPackage ./freerouting.nix { };
  my-mqttx = super.callPackage ./mqttx.nix {};
}
