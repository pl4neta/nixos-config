{ pkgs, lib, inputs, ...}: 
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in 
{
  #nixpkgs.config.allowUnfreePredicate = pkg:
  #  builtins.elem (lib.getName pkg) [
  #    "spotify"
  #  ];

  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "macchiato";
     enabledCustomApps = with spicePkgs.apps; [
	marketplace
	lyricsPlus
	newReleases
     ];
     enabledExtensions = with spicePkgs.extensions; [
      ({
        src = ../../.config/spicetify/extensions;
        name = "allOfArtist.js";
      })
       adblock
       fullAppDisplay
       loopyLoop
       shuffle
       groupSession
       playlistIcons
       fullAlbumDate
       goToSong
       listPlaylistsWithSong
       playlistIntersection
       skipStats
       phraseToPlaylist
       songStats
       showQueueDuration
       copyToClipboard
       history
       lastfm
       #genre
       volumePercentage
     ];
  };
}
