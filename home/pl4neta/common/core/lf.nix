{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
      ''${{
        printf "Directory Name: "
        read DIR
        mkdir $DIR
      }}
      '';
#cmd trash %set -f; mv $fx ~/.trash
      trash =  ''%trash-put $fx'';

# define a custom 'delete' command
      delete = ''
      ''${{
      set -f
      printf "$fx\n"
      printf "delete?[y/n]"
      read ans
      [ "$ans" = "y" ] && rm -rf $fx
      }}
      '';
    };

    keybindings = {

      "<delete>" = "trash";
      "<s-delete>" = "delete";

      c = "mkdir";
      "." = "set hidden!";
      "<enter>" = "open";
      
      ee = "editor-open";
      V = ''$${pkgs.bat}/bin/bat --paging=always "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      ignorecase = true;
    };

    extraConfig = 
    let 
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5
        
        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi
        
        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in
    ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };

}
