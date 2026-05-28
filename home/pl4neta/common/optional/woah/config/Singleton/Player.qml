pragma Singleton
import QtQuick
import Quickshell.Io
import Quickshell.Services.Mpris

Item {
  id: root

  property var players: [
    "Spotify"
  ]

  property var player: getPlayer()
  property string identity: player ? player.identity : null
  property string title: player ? player.trackTitle ? player.trackTitle : "Unknown" : "No Music"
  property string artist: player ? player.trackArtist ? player.trackArtist : "Unknown" : ""
  property string album: player && player.trackAlbum ? " • "+player.trackAlbum : ""
  property string cover: player && player.trackArtUrl ? player.trackArtUrl : ""
  property real length: player && player.lengthSupported ? player.length : null
  property real position: player && player.positionSupported ? player.position : null
  property real progress: player && player.position && player.length ? player.position / player.length : null
  property real isPlaying: player ? player.isPlaying : false

  function getPlayer() {
    //console.log(JSON.stringify(Mpris.players.values))
    for (let p of Mpris.players.values) {
      if (players.includes(p.identity)) return p //add prio on playing and prio on recent
    }
    //return Mpris.players.values[0] ? Mpris.players.values[0] : null
  }

  Timer {
    id: playerTimer
    interval: 500
    running: true
    repeat: true
    onTriggered: {
      length = player && player.lengthSupported ? player.length : null
      position = player && player.positionSupported ? player.position : null
      progress = player && player.position && player.length ? player.position / player.length : null
    }
  }
}

