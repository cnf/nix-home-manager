{ lib, config, pkgs, unstable, ... }: {
  options = {
    my.debuggers.enable = lib.mkEnableOption "Install debug tools";
  };
  config = lib.mkIf config.my.debuggers.enable {
    home.packages = with pkgs;[
      gdb
      #probe-rs
      #probe-rs-tools
      openocd
      espflash
      blackmagic
      picocom

      #stlink
      stlink-gui
      stlink-tool

      #unstable.my-hydrabus
      #unstable.my-hydratool

      flashrom
      binwalk
      sasquatch
      jefferson
      dumpifs

      gtkwave

      #ida-free

      # DBus
      bustle

    ];
  };
}
