import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "Singleton" 1.0

Rectangle {
  id: root 

  anchors {
    right: power.left
    bottom: time.top
    margins: dashboard.size / 10
  }

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  property string title: Player.title
  property string artist: Player.artist
  property string album: Player.album

  width: root.size * 4 - root.size / 10
  height: root.size * 2 - root.size / 10
  color: root.baseColor
  radius: root.round  

  function updateAnimation(anim, text, textHolder, constraintWidth, timer) {
    anim.stop()
    textHolder.x = 0

    if (text.width > constraintWidth) {
      anim.from = 0
      anim.to = -(text.width + textHolder.spacing)
      anim.duration = text.width * 25
      timer.restart()
    }
  }

  MouseArea {
    anchors.fill: parent
    Rectangle {
      width: parent.width - root.size / 2.5
      height: parent.height - root.size / 2.5
      color: "transparent"
      anchors.centerIn: parent
      Rectangle {
        width: parent.height
        height: parent.height
        color: "transparent"
        Rectangle {
          width: parent.width - root.size / 5
          height: parent.height - root.size / 5
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
          radius: root.round
          clip: true
          color: "transparent"
          Image {
            visible: Player.cover ? true : false
            anchors.fill: parent
            source: Player.cover
            fillMode: Image.preserveAspectCrop
          }
          Rectangle {
            visible: Player.cover ? false : true
            anchors.fill: parent
            color: "#414559"
            radius: root.round
            Text {
              text: "󰝛"
              font.pointSize: 95
              font.family: fontFamily
              anchors.centerIn: parent
            }
          }
        }
      }
      Rectangle {
        width: parent.width - parent.height
        height: parent.height
        color: "transparent"
        anchors.right: parent.right
        Rectangle {
          width: parent.width
          height: parent.height / 3 * 1.75
          color: "transparent"
          Rectangle {
            id: mediaInfo
            width: parent.width
            implicitHeight: childrenRect.height
            anchors.bottom: parent.bottom
            anchors.margins: 15
            color: "transparent"
            clip: true
            Row {
              id: titleHolder
              spacing: 50
              Text {
                id: titleText
                text: title
                font.pointSize: 25
                color: root.textColor
                onTextChanged: Qt.callLater(() => updateAnimation(mediaTitleMarqueesAnimation, titleText, titleHolder, mediaInfo.width, mediaTitleMarqueesTimer))
                onWidthChanged: Qt.callLater(() => updateAnimation(mediaTitleMarqueesAnimation, titleText, titleHolder, mediaInfo.width, mediaTitleMarqueesTimer))
              }
              Text {
                text: title
                font.pointSize: 25
                color: root.textColor
                visible: titleText.width > mediaInfo.width
              }
              NumberAnimation on x {
                id: mediaTitleMarqueesAnimation
                from: 0
                to: -(titleText.width + titleHolder.spacing)
                duration: titleText.width * 25
                loops: Animation.Infinite
                running: false
              }
              Timer {
                id: mediaTitleMarqueesTimer
                interval: 1000
                running: false
                repeat: false
                onTriggered: titleText.width > mediaInfo.width ? mediaTitleMarqueesAnimation.start() : 0
              }
              Component.onCompleted: {() => Qt.callLater(updateAnimation(mediaTitleMarqueesAnimation, titleText, titleHolder, mediaInfo.width, mediaTitleMarqueesTimer))}
            }
            Row {
              id: artistHolder
              spacing: 50
              anchors.top: titleHolder.bottom
              Text {
                id: artistText
                text: artist + album
                color: root.textColor
                font.pointSize: 15
                onTextChanged: Qt.callLater(() => updateAnimation(mediaArtistMarqueesAnimation, artistText, artistHolder, mediaInfo.width, mediaArtistMarqueesTimer))
                onWidthChanged: Qt.callLater(() => updateAnimation(mediaArtistMarqueesAnimation, artistText, artistHolder, mediaInfo.width, mediaArtistMarqueesTimer))
              }
              Text {
                text: artist + album
                color: root.textColor
                font.pointSize: 15
                visible: artistText.width > mediaInfo.width
              }
              NumberAnimation on x {
                id: mediaArtistMarqueesAnimation
                from: 0
                to: -(artistText.width + artistHolder.spacing)
                duration: artistText.width * 25
                loops: Animation.Infinite
                running: false
              }
              Timer {
                id: mediaArtistMarqueesTimer
                interval: 1000
                running: false
                repeat: false
                onTriggered: artistText.width > mediaInfo.width ? mediaArtistMarqueesAnimation.start() : 0
              }
              Component.onCompleted: {() => Qt.callLater(updateAnimation(mediaArtistMarqueesAnimation, artistText, artistHolder, mediaInfo.width, mediaArtistMarqueesTimer))}
            }
          }
        }
        Rectangle {
          width: parent.width
          height: parent.height / 3 * 1.25
          color: "transparent"
          anchors.bottom: parent.bottom
          Rectangle {
            width: parent.width
            implicitHeight: childrenRect.height
            anchors.top: parent.top
            anchors.margins: 15
            color: "transparent"
            Rectangle {
              id: bar
              width: parent.width
              height: 20
              radius: 10
              color: "#232634"
              Rectangle {
                color: root.textColor
                width: parent.width * Player.progress
                height: parent.height
                anchors.left: parent.left
                radius: 10
              }
              MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                  let frac = mouse.x / bar.width
                  Player.player.position = frac * Player.length
                }
              }
            }
            Row {
              anchors.top: bar.bottom
              anchors.margins: 15
              anchors.horizontalCenter: parent.horizontalCenter
              spacing: 45
              Button {
                width: 40
                height: 30
                background: Rectangle {
                  color: root.textColor
                  radius: width / 5
                }
                onClicked: Player.player.previous()
                Text {
                  width: parent.width
                  height: parent.height
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  text: "󰒮"
                  font.pointSize: 15
                }
              }
              Button {
                width: 40
                height: 30
                background: Rectangle {
                  color: root.textColor
                  radius: width / 5
                }
                onClicked: Player.player.togglePlaying()
                Text {
                  width: parent.width
                  height: parent.height
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  text: Player.isPlaying ? "󰏤" : "󰐊"
                  font.pointSize: 15
                }
              }
              Button {
                width: 40
                height: 30
                background: Rectangle {
                  color: root.textColor
                  radius: width / 5
                }
                onClicked: Player.player.next()
                Text {
                  width: parent.width
                  height: parent.height
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  text: "󰒭"
                  font.pointSize: 15
                }
              }
            }
          }
        }
      }
    }
  }
}

