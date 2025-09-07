self: super: {
  my-freerouting = super.callPackage ./freerouting.nix {};
  my-mqttx = super.callPackage ./mqttx.nix {};
  my-nextmeeting = super.callPackage ./nextmeeting.nix {};
  my-ollama-gui = super.callPackage ./ollama-gui.nix {};
  my-nautilus_archiver_tools = super.callPackage ./nautilus_archiver_tools.nix {};
  my-tailscale-systray = super.callPackage ./tailscale-systray.nix {};
  my-cistercian = super.callPackage ./cistercian.nix {};
  my-hyprswitch = super.callPackage ./hyprswitch.nix {};
  my-appimage-menu-updater = super.callPackage ./appimage-menu-updater.nix {};
  my-gr-ieee802-11 = super.callPackage ./gr-ieee802-11.nix {};
}
