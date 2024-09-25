{ pkgs, ... }:
{
environment.etc."xdg/user-dirs.defaults".text = ''
  DESKTOP=${home}/system/desktop
  DOWNLOAD=${home}/downloads
  TEMPLATES=${home}/system/templates
  PUBLICSHARE=${home}/system/public
  DOCUMENTS=${home}/documents
  MUSIC=${home}/media/music
  PICTURES=${home}/media/photos
  VIDEOS=${home}/media/video
'';
environment.etc.sessionVariables = {
    XDG_CONFIG_HOME = "${HOME}/.dotfiles/.config";
};
}
