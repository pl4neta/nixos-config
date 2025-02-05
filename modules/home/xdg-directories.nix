{ pkgs, ... }:
{
environment.etc."xdg/user-dirs.defaults".text = ''
  DESKTOP=${HOME}/system/desktop
  DOWNLOAD=${HOME}/downloads
  TEMPLATES=${HOME}/system/templates
  PUBLICSHARE=${HOME}/system/public
  DOCUMENTS=${HOME}/documents
  MUSIC=${HOME}/media/music
  PICTURES=${HOME}/media/photos
  VIDEOS=${HOME}/media/video
'';
environment.sessionVariables = {
    XDG_CONFIG_HOME = "${HOME}/.dotfiles/.config";
};
}
