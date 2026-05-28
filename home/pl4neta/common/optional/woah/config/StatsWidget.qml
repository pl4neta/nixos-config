import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root 

  anchors {
    horizontalCenter: parent.horizontalCenter
    bottom: systray.top
    margins: dashboard.size / 10
  }

	default property list<Stat> stats

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  width: root.size * 3 - root.size / 10
  height: root.size * 2.5 - root.size / 10
  color: root.baseColor
  radius: root.round  
  
  MouseArea {
    anchors.fill: parent
    ColumnLayout {
      anchors.centerIn: parent
      width: parent.width - root.size / 2.5
      height: parent.height - root.size / 2.5
      spacing: root.size / 10
      Repeater {
        model: stats
        delegate: Item {
          required property Stat modelData;

          Layout.fillWidth: true
          Layout.fillHeight: true

          Item {
            anchors.fill: parent
            Text { 
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              width: parent.width * .12
              text: modelData.icon//modelData.value
              font.family: root.fontFamily
              font.pointSize: 30
              color: root.textColor
            }
            Rectangle {
              anchors.verticalCenter: parent.verticalCenter
              anchors.right: parent.right
              width: parent.width * .88
              height: 20
              radius: 10
              color: "#232634"
              Rectangle {
                anchors.left: parent.left
                width: parent.width * modelData.progress
                height: parent.height
                radius: 10
                color: root.textColor
              }
            }
          }
        }
      }
    }
  }
}

