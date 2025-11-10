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
      {
        src = builtins.fetchTarball {
          url = "https://github.com/pl4neta/allOfArtist/archive/refs/heads/main.tar.gz";
          sha256 = "0arj24ylkkcgwxr4c7124vxwvmlvnhd2h67q5pmscz9gnhcig9ns";
        };
        name = "allOfArtist.js";
      }
      {
        src = builtins.fetchTarball {
          url = "https://github.com/Maskowh/spicetify-old-like-button-extension/archive/refs/heads/main.tar.gz";
          sha256 = "1z0hzz1gikn0qgfjkyaaazjigpny5zgn6c4wgfjgnqgk653hfg7n";
        };
        name = "oldLikeButton.js";
      }
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
       #skipStats spotify update broke context menu
       phraseToPlaylist
       songStats
       showQueueDuration
       #copyToClipboard spotify update broke context menu
       history
       lastfm
       #genre
       volumePercentage
     ];
  };
}
