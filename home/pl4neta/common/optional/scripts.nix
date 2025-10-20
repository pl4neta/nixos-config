{ pkgs, ... }:
let
  scriptsDir = ./scripts;
  scriptFiles = builtins.attrNames (builtins.readDir scriptsDir);
in
{
  home.file = builtins.listToAttrs (map
    (name: {
      name = ".local/bin/${name}";
      value = {
        source = "${scriptsDir}/${name}";
        executable = true;
      };
    })
    scriptFiles);
  home.packages = with pkgs; [
    jq 
  ];
}

