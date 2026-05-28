import QtQuick
import QtQuick.Controls
import "Singleton" 1.0

Rectangle {
  id: root 

  anchors {
    right: systray.left
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

  width: root.size * 4 - root.size / 10
  height: root.size * 4 - root.size / 10
  color: root.baseColor
  radius: root.round  

  MouseArea {
    anchors.fill: parent
    Item {
      width: parent.width - root.size / 2.5
      height: parent.height - root.size / 2.5
      anchors.centerIn: parent
      Row {
        width: parent.width
        height: parent.height
        spacing: root.size / 10
        Rectangle {
          width: parent.width - root.size * 2 / 3 - parent.spacing
          height: parent.height
          radius: root.round
          color: "#232634"
          Column {
            width: parent.width - root.size / 10
            height: parent.height - root.size / 10
            spacing: root.size / 10
            anchors.centerIn: parent
            Repeater {
              model: Notification.notifications
              delegate : Rectangle {
                width: parent.width
                height: 100
                radius: root.round - root.size / 20
                color: root.baseColor
                Rectangle {
                  height: parent.height
                  width: parent.height
                  anchors.left: parent.left 
                  color: "transparent"
                  Rectangle {
                    width: parent.width - root.size / 5
                    height: parent.height - root.size / 5
                    anchors.centerIn: parent
                    radius: root.round - root.size / 20
                    color: "#414559"
                    Text{
                      text: ""//"󰇮"
                      font.pointSize: 45
                      color: "#232634"
                      opacity: .5
                      anchors.centerIn: parent
                    }
                    Text{
                      text: modelData.count ? modelData.count : ""
                      font.pointSize: 25
                      color: root.textColor
                      anchors.centerIn: parent
                    }
                  }
                }
                Item{
                  width: parent.width - parent.height - (notificationRemove.width + notificationRemove.anchors.rightMargin)
                  height: parent.height - root.size / 5
                  anchors.verticalCenter: parent.verticalCenter
                  anchors.right: notificationRemove.left
                  Text {
                    text: modelData.appName ? modelData.appName : "Unknown"
                    font.pointSize: 14
                    color: root.textColor
                    anchors.verticalCenter: parent.verticalCenter
                  }
                }
                MouseArea {
                  id: notificationRemove
                  implicitWidth: childrenRect.width
                  implicitHeight: childrenRect.height
                  anchors.right: parent.right
                  anchors.rightMargin: root.size / 10
                  anchors.verticalCenter: parent.verticalCenter
                  onClicked: Notification.dismissApp(modelData.appName)
                  Text {
                    width: font.pointSize
                    text: ""
                    color: "#e78284"
                    font.pointSize: 30
                    font.family: root.fontFamily
                  }
                }
              }
            }
          }
        }
        Column {
          width: root.size * 2 / 3
          height: parent.height
          spacing: root.size / 10
          Button {
            width: parent.width
            height: width
            background: Rectangle {
              color: "#babbf1"
              radius: root.round
            }
            Text {
              width: parent.width
              height: parent.height
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              text: "󰂚"//󰂛
              color: "#232634"
              font.pointSize: 35
              font.family: root.fontFamily
            }
          }
          Rectangle {
            width: parent.width
            height: width
            color: "#232634"
            radius: root.round
            Button {
              width: parent.width - root.size / 10
              height: parent.height - root.size / 10
              anchors.centerIn: parent
              background: Rectangle {
                color: root.baseColor
                radius: root.round - root.size / 20
              }
              onClicked: Notification.dismissAll()
              Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "󰩹"
                color: "#e78284"
                font.pointSize: 35
                font.family: root.fontFamily
              }
            }
          }
        }
      }
    }
  }
}
