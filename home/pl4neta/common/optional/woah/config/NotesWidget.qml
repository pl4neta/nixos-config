import QtQuick
import Quickshell
import Quickshell.Io
import QtQuick.Controls
import "Singleton" 1.0

Rectangle {
  id: root 

  anchors {
    left: systray.right
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

  property var notes: []

  width: root.size * 4 - root.size / 10
  height: root.size * 5 - root.size / 10
  color: root.baseColor
  radius: root.round  

  FileView {
    id: notesFile
    path: Quickshell.env("HOME") + "/.notes"
    onLoaded: {
      try {
        notes = JSON.parse(notesFile.text())
        //console.log(notes, notes[0], notes[0].date, notes[0].text)
      }
      catch (e) {
        notes = []
      }
    }
  }

  MouseArea {
    anchors.fill: parent
    Column {
      width: parent.width - root.size / 2.5 
      height: parent.height - root.size / 2.5 
      spacing: root.size / 10 
      anchors.centerIn: parent

      Rectangle {
        width: parent.width
        height: parent.height - parent.spacing - root.size / 1.25
        color: "#232634"
        radius: root.round
        Rectangle {
          id: notesDisplay
          clip: true
          width: parent.width - root.size / 10
          height: parent.height - root.size / 10
          anchors.centerIn: parent
          radius: root.round
          color: "transparent"
          ScrollView {
            id: notesBox
            anchors.fill: parent
            Column {
              width: notesDisplay.width
              spacing: root.size / 10
              Repeater {
                id: notesRepeater
                model: notes
                delegate: Rectangle {
                  id: note
                  width: parent.width
                  implicitHeight: childrenRect.height
                  color: root.baseColor
                  radius: root.round - root.size / 20
                  opacity: modelData.completed ? .5 : 1
                  property bool editing: false
                  Item {
                    width: parent.width
                    implicitHeight: childrenRect.height + 10
                    Item {
                      id: noteBar
                      width: parent.width
                      height: 45
                      anchors.top: parent.top
                      anchors.bottomMargin: 10
                      Item {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.margins: 5
                        anchors.verticalCenter: parent.verticalCenter
                        Text {
                          height: !modelData.lastUpdate ? parent.height : implicitHeight
                          anchors.top: parent.top
                          anchors.topMargin: !modelData.lastUpdate ? 3 : 0
                          id: noteDate
                          text: modelData.date
                          font.pointSize: 14
                          color: props.textColor
                          font.family: props.fontFamily
                          verticalAlignment: Text.AlignVCenter
                        }
                        Text {
                          anchors.top: noteDate.bottom
                          visible: modelData.lastUpdate ? true : false
                          text: modelData.lastUpdate ? modelData.lastUpdate : null
                          font.pointSize: 10
                          color: props.textColor
                          font.family: props.fontFamily
                          verticalAlignment: Text.AlignVCenter
                        }
                      }
                      Button {
                        visible: !note.editing
                        width: parent.height - 15
                        height: parent.height - 15
                        anchors.right: notesEdit.left
                        anchors.margins: 7.5
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                          color: modelData.completed ? "#414559" : "#a6d189"
                          radius: width / 5
                        }
                        onClicked: {notes[index].completed = !notes[index].completed; notesFile.setText(JSON.stringify(notes)); notes = [...notes]}
                        Text {
                          width: parent.width
                          height: parent.height
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          text: modelData.completed ? "󰅖" : "󰄬"
                          color: modelData.completed ? root.textColor : "#232634"
                          font.pointSize: 14
                          font.family: root.fontFamily
                        }
                      }
                      Button {
                        id: notesEdit
                        visible: !note.editing
                        width: parent.height - 15
                        height: parent.height - 15
                        anchors.right: notesDel.left
                        anchors.margins: 7.5
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                          color: modelData.completed ? "#414559" : "#e5c890"
                          radius: width / 5
                        }
                        onClicked: {note.editing = true;noteTextarea.forceActiveFocus();let noteItem = notesRepeater.itemAt(index);notesBox.contentItem.contentY = noteItem.y + noteItem.height/2 - notesBox.height/2}
                        Text {
                          width: parent.width
                          height: parent.height
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          text: "󰏫"
                          color: modelData.completed ? root.textColor : "#232634"
                          font.pointSize: 14
                          font.family: root.fontFamily
                        }
                      }
                      Button {
                        id: notesEditConfirm
                        visible: note.editing
                        width: parent.height - 15
                        height: parent.height - 15
                        anchors.right: notesEditCancel.left
                        anchors.margins: 7.5
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                          color: modelData.completed ? "#414559" : "#a6d189"
                          radius: width / 5
                        }
                        onClicked: {note.editing = false; if (notes[index].text != noteTextarea.text){notes[index].text = noteTextarea.text; notes[index].lastUpdate = Clock.currentDay; notesFile.setText(JSON.stringify(notes)); notes = [...notes]}}
                        Text {
                          width: parent.width
                          height: parent.height
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          text: "󰄬"
                          color: modelData.completed ? root.textColor : "#232634"
                          font.pointSize: 14
                          font.family: root.fontFamily
                        }
                      }
                      Button {
                        id: notesEditCancel
                        visible: note.editing
                        width: parent.height - 15
                        height: parent.height - 15
                        anchors.right: parent.right
                        anchors.margins: 7.5
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                          color: modelData.completed ? "#414559" : "#e78284"
                          radius: width / 5
                        }
                        onClicked: {note.editing = false; noteTextarea.text = modelData.text}
                        Text {
                          width: parent.width
                          height: parent.height
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          text: "󰅖"
                          color: modelData.completed ? root.textColor : "#232634"
                          font.pointSize: 14
                          font.family: root.fontFamily
                        }
                      }
                      Button {
                        id: notesDel
                        visible: !note.editing
                        width: parent.height - 15
                        height: parent.height - 15
                        anchors.right: parent.right
                        anchors.margins: 7.5
                        anchors.verticalCenter: parent.verticalCenter
                        background: Rectangle {
                          color: modelData.completed ? "#414559" : "#e78284"
                          radius: width / 5
                        }
                        onClicked: {notes.splice(index, 1); notesFile.setText(JSON.stringify(notes)); notes = [...notes]}
                        Text {
                          width: parent.width
                          height: parent.height
                          horizontalAlignment: Text.AlignHCenter
                          verticalAlignment: Text.AlignVCenter
                          text: "󰩹"
                          color: modelData.completed ? root.textColor : "#232634"
                          font.pointSize: 14
                          font.family: root.fontFamily
                        }
                      }
                    }
                    TextArea {
                      id: noteTextarea
                      width: parent.width
                      anchors.top: noteBar.bottom
                      anchors.topMargin: 10
                      anchors.right: parent.right
                      anchors.left: parent.left
                      anchors.rightMargin: 10 
                      anchors.leftMargin: 10 
                      text: modelData.text
                      font.pointSize: 14
                      color: props.textColor
                      font.family: props.fontFamily
                      wrapMode: TextArea.Wrap
                      readOnly: !note.editing
                      focus: note.editing
                      background: Rectangle {
                        color: note.editing ? "#232634" : "transparent"
                        radius: root.round - root.size / 20
                      }
                    } 
                  }
                }
              }
            }
          }
        }
      }
      Row {
        width: parent.width
        height: root.size / 1.25
        spacing: root.size / 10
        ScrollView {
          width: parent.width - root.size / 1.25 - parent.spacing
          height: parent.height
          TextArea {
            width: parent.width
            height: parent.height
            background: Rectangle {
              color: "#232634"
              radius: root.round
            }
            font.pointSize: 14
            color: props.textColor
            font.family: props.fontFamily
            wrapMode: TextArea.Wrap

            Keys.priority: Keys.BeforeItem
            Keys.onPressed: (event) => {
              if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                if (!(event.modifiers & Qt.ShiftModifier)) {
                  event.accepted = true
                  submit()
                }
              }
            }
            function submit() {
              notes = [...notes, {"date": Clock.currentDay, "text": text, "completed": false}]
              notesFile.setText(JSON.stringify(notes))
              text = ""
              notesBox.contentItem.contentY = notesBox.contentItem.contentHeight
            }
          }
        }
        Rectangle {
          width: root.size / 1.25
          height: parent.height
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
            Text {
              width: parent.width
              height: parent.height
              horizontalAlignment: Text.AlignHCenter
              verticalAlignment: Text.AlignVCenter
              text: "󰩹"
              color: "#e78284"
              font.pointSize: 45
              font.family: root.fontFamily
            }
          }
        }
      }
    }
  }
}

