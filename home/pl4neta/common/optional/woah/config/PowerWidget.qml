import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root 

  anchors {
    left: stats.right
    bottom: notes.top
    margins: dashboard.size / 10
  }

	default property list<PowerButton> buttons

  required property var props

  property real size: props.size
  property real round: props.round
  property color baseColor: props.baseColor
  property color textColor: props.textColor
  property string fontFamily: props.fontFamily

  width: root.size * 4 - root.size / 10
  height: root.size * 1 - root.size / 10
  color: root.baseColor
  radius: root.round  

  MouseArea {
    anchors.fill: parent
    RowLayout {
      anchors.centerIn: parent
      width: parent.width - root.size / 5
      height: parent.height - root.size / 5
      spacing: root.size / 10
      Repeater {
        model: buttons
        delegate: Item {
          required property PowerButton modelData;

          Layout.fillWidth: true
          Layout.fillHeight: true

          MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            onClicked: modelData.exec()
          }
          Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: modelData.icon
            font.pointSize: 50
            color: modelData.color
            opacity: ma.containsMouse ? 0.75 : 1
          }
        }
      }
    }
  }
}
