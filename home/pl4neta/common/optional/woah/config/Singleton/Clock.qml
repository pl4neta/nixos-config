pragma Singleton
import QtQuick
import Quickshell.Io

Item {
  property string currentTime: ""
  property string currentDate: ""
  property string currentWeek: ""
  property string currentDay: ""
  property string rawWeek: ""

  Timer {
    id: clockTimer
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      var now = new Date()
      currentTime = Qt.formatDateTime(now, "HH\nmm")
      currentDate = Qt.formatDateTime(now, "dd\nMMMM")
      rawWeek = Qt.formatDateTime(now, "dddd")
      currentWeek = rawWeek.slice(0, -3) + "\n" + rawWeek.slice(-3)
      currentDay = Qt.formatDateTime(now, "dd/MM/yyyy HH:mm")
    }
  }
  Component.onCompleted: clockTimer.triggered()
}

