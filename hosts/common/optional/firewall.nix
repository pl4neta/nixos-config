{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      7127
    ];
    allowedUDPPorts = [
      7127
    ];
  };
}
