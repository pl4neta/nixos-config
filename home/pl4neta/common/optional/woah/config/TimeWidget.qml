import QtQuick
import "Singleton" 1.0

Rectangle {
  id: root 

  anchors {
    horizontalCenter: parent.horizontalCenter
    bottom: stats.top
    margins: dashboard.size / 10
  }

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  width: root.size * 3 - root.size / 10
  height: root.size * 1 - root.size / 10
  color: root.baseColor
  radius: root.round
  
  MouseArea {
    anchors.fill: parent
    Text {
      id: time
      font.pointSize: 40
      font.family: root.fontFamily
      color: root.textColor
      lineHeight: 0.7
      font.letterSpacing: 0
      text: Clock.currentTime
      anchors {
        margins: root.size / 10
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.horizontalCenter
      }
    }

    Text {
      font.pointSize: 23
      font.family: root.fontFamily
      color: root.textColor
      lineHeight: 0.7
      text: Clock.currentWeek
      horizontalAlignment: Text.AlignRight
      anchors {
        margins: root.size / 10
        verticalCenter: parent.verticalCenter
        right: time.left
      }
    }

    Text {
      font.pointSize: 23
      font.family: root.fontFamily
      color: root.textColor
      lineHeight: 0.7
      text: Clock.currentDate
      horizontalAlignment: Text.AlignLeft
      anchors {
        margins: root.size / 10
        verticalCenter: parent.verticalCenter
        left: time.right
      }
    }
  }
}
