pragma Singleton
import QtQuick
import Quickshell.Io

Item {
  id: root

  property bool enetCheck: false
  property bool wifiCheck: false
  property string netIcon: "󰤭"
  property color netColor: "#414559"

  property bool btCheck: false
  property string btIcon: "󰂲"
  property color btColor: "#414559"

  property bool volCheck: false
  property string volIcon: "󰖁"
  property color volColor: "#414559"

  property bool micCheck: false
  property string micIcon: "󰍭"
  property color micColor: "#414559"

  property bool readCheck: false
  property string readIcon: "󰈉"//"󰈈"
  property color readColor: "#414559"

  property bool vpnCheck: false
  property string vpnIcon: "󰪎"//"󰖟"//"󰗹"
  property color vpnColor: "#414559"//"#ca9ee6"
  Process {
    id: netProcess
    command: ["sh", "-c",
      "nmcli -t -f TYPE,STATE device | grep -q '^ethernet:connected'"
    ]
    running: true
    onExited: (exitCode, exitStatus) => {
      root.enetCheck = (exitCode === 0)
      root.netIcon = root.enetCheck ? "󰈀" : root.netIcon
      root.netColor = root.enetCheck ? "#8caaee" : root.netColor
    }
  }
  Process {
    id: wifiProcess
    command: ["sh", "-c",
      "nmcli radio wifi | grep -q enabled"
    ]
    running: true
    onExited: (exitCode, exitStatus) => {
      root.wifiCheck = (exitCode === 0)
      if (!root.enetCheck) {
        root.netIcon = root.wifiCheck ? "󰤨" : "󰤭"
        root.netColor = root.wifiCheck ? "#8caaee" : "#414559"
      }
    }
  }
  Process {
    id: btProcess
    command: ["sh", "-c",
      "bluetoothctl show | grep -q 'Powered: yes'"
    ]
    running: true
    onExited: (exitCode, exitStatus) => {
      root.btCheck = (exitCode === 0)
      root.btIcon = btCheck ? "󰂯" : "󰂲"
      root.btColor = btCheck ? "#85c1dc" : "#414559"
    }
  }
  Process {
    id: volProcess
    command: ["sh", "-c",
      "wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED"
    ]
    running: true
    onExited: (exitCode, exitStatus) => {
      root.volCheck = (exitCode === 1)
      root.volIcon = volCheck ? "󰕾" : "󰖁"
      root.volColor = volCheck ? "#e78284" : "#414559"
    }
  }
  Process {
    id: micProcess
    command: ["sh", "-c",
      "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED"
    ]
    running: true
    onExited: (exitCode, exitStatus) => {
      root.micCheck = (exitCode === 1)
      root.micIcon = micCheck ? "󰍬" : "󰍭"
      root.micColor = micCheck ? "#e5c890" : "#414559"
    }
  }
  Timer {
    id: systemTimer
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      wifiProcess.running = true
      netProcess.running = true
      btProcess.running = true
      volProcess.running = true
      micProcess.running = true
    }
  }
  Component.onCompleted: systemTimer.triggered()
}

