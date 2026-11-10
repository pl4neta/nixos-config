# FIXME(starter): adjust to you security requirements
{
  config,
  ...
}:
{
  programs.ssh =
   {
      enable = true;

      settings."*" = {
        controlMaster = "auto";
        controlPath = "${config.home.homeDirectory}/.ssh/sockets/S.%r@%h:%p";
        controlPersist = "20m";
        serverAliveCountMax = 3;
        serverAliveInterval = 5;
        hashKnownHosts = true;
        addKeysToAgent = "yes";
      };
   };
  home.file = {
    ".ssh/config.d/.keep".text = "# Managed by Home Manager";
    ".ssh/sockets/.keep".text = "# Managed by Home Manager";
  };
}
