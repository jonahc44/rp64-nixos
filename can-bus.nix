{ config, pkgs, ... }:

{
  boot.kernelModules = [ "spi-rockchip" "mcp251x" "can" "can_raw" "can_dev" ];

  hardware.deviceTree = {
    enable = true;
    name = "rockchip/rk3399-rockpro64.dtb";
    filter = "*rockpro64*";
    overlays = [
      {
        name = "mcp2515-can0";
        dtsFile = ./mcp2515-overlay.dts; 
      }
    ];
  };

  systemd.services.can0-up = {
    description = "Initialize can0 SocketCAN interface";
    bindsTo = [ "sys-subsystem-net-devices-can0.device" ];
    after = [ "sys-subsystem-net-devices-can0.device" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.iproute2}/bin/ip link set can0 up type can bitrate 500000";
      ExecStop = "${pkgs.iproute2}/bin/ip link set can0 down";
    };
  };
}