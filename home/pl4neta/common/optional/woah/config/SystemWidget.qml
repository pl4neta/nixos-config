import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root 

  anchors {
    right: media.left
    bottom: notifications.top
    margins: dashboard.size / 10
  }

	default property list<SystemButton> buttons

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  width: root.size * 3 - root.size / 10
  height: root.size * 2 - root.size / 10
  color: root.baseColor
  radius: root.round  

  MouseArea {
    anchors.fill: parent
    GridLayout {
      anchors.centerIn: parent
      width: parent.width - root.size / 2.5
      height: parent.height - root.size / 2.5
      columns: 3
      columnSpacing: root.size / 7.5
      rowSpacing: root.size / 7.5

      Repeater {
        model: buttons
        delegate: Rectangle {
          required property SystemButton modelData;

          Layout.fillWidth: true
          Layout.fillHeight: true
          color: modelData.color
          radius: root.round
          Text {
            text: modelData.icon
            font.pointSize: 35
            anchors.centerIn: parent
            color: "#232634"
          }
        }
      }
    }
  }
}
