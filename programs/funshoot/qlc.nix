{ pkgs, lib, config, ... }:
{
  config = lib.mkIf config.my.funshoot.enable {

    home.packages = with pkgs; [
      qlcplus
    ];

  };
}
