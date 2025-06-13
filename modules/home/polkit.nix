{ pkgs, ... }:

{
  home.packages = [
    pkgs.lxqt.lxqt-policykit
  ];

  systemd.user.services.polkit-agent = {
    Unit = {
      Description = "LXQT PolicyKit Agent";
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}

