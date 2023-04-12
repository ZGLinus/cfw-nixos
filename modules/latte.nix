{ lib, pkgs, config, ... }:
with lib;
let 
  cfg = config.services.latte-dock;
in {
  options.services.latte-dock = {
    enable = mkEnableOption "latte-dock service";
  };

  config = {
    systemd.services.latte-dock = {
      wantedBy = ["multi-user.target"];
      wants = ["plasma-kscreen.service"];
      serviceConfig.ExecStart = /run/current-system/sw/bin/latte-dock;
    };
  };
}