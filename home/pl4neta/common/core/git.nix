{ pkgs, ... }: 
{
  programs.git = {
    enable = true;
    
    userName = "Pl4neta";
    userEmail = "135662804+Pl4neta@users.noreply.github.com";
    
    extraConfig = { 
      init.defaultBranch = "master";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.defaultKeyCommand = "ssh-add -L | head -n1";
    };
  };

  home.packages = with pkgs; [
    gh
    lazygit
    onefetch
  ];

  programs.zsh.shellAliases = {
    g     = "lazygit";
    gf    = "onefetch --number-of-file-churns 0 --no-color-palette";
    ga    = "git add";
    gaa   = "git add --all";
    gs    = "git status";
    gb    = "git branch";
    gm    = "git merge";
    gd    = "git diff";
    gdp   = "git diff HEAD~1 HEAD";
    gpl   = "git pull";
    gplo  = "git pull origin";
    gps   = "git push";
    gpso  = "git push origin";
    gpst  = "git push --follow-tags";
    gcl   = "git clone";
    gc    = "git commit";
    gca   = "git commit --ammend";
    gcm   = "git commit -m";
    gacm  = "git add --all && git commit -m";
    gtag  = "git tag -ma";
    gch   = "git checkout";
    gchb  = "git checkout -b";
    glog  = "git log --oneline --decorate --graph";
    glol  = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'";
    glola = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all";
    glols = "git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat";
  };
}
