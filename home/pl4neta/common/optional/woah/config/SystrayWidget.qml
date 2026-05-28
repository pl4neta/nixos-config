import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Rectangle {
  id: root 

  anchors {
    horizontalCenter: parent.horizontalCenter
    bottom: parent.bottom
    margins: dashboard.size / 10
    bottomMargin: 0
  }

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  width: root.size * 3 - root.size / 10
  height: root.size * 0.5 - root.size / 10
  color: root.baseColor
  radius: root.round  

  MouseArea {
    anchors.fill: parent
    Row{
      anchors.centerIn: parent
      spacing: root.size / 10
      Repeater {
        model: SystemTray.items
        delegate: Item {
          required property var modelData
          width: (root.height - root.size / 10)* .65 
          height: (root.height - root.size / 10) * .65
          Image {
            anchors.fill: parent
            source: modelData.icon
            fillMode: Image.PreserveAspectFit
          }
          MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: (mouse) => {
              if (mouse.button === Qt.LeftButton) modelData.activate()
              else if (mouse.button === Qt.RightButton) {
                let pos = mapToItem(null, mouse.x, mouse.y)
                modelData.display(w,pos.x,pos.y);
              }
            }
          }
        }
      }
    }
  }
}

