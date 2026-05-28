pragma Singleton
import QtQuick
import Quickshell.Io

Item {
  id: root

  property real cpuUsed: 0
  property real cpuUsageProgress: 0
  property real cpuTemp: 0
  property real cpuTempProgress: 0
  
  property real ramTotal: 0
  property real ramUsed: 0
  property real ramUsageProgress: 0
  
  property real swapTotal: 0
  property real swapUsed: 0
  property real swapUsageProgress: 0

  property real storageTotal: 0
  property real storageUsed: 0
  property real storageUsageProgress: 0

  readonly property var cpu: Process {
    command: ["sh", "-c",
      "echo \"$(top -bn1 | grep 'Cpu(s)' | awk -F',' '{print 100 - $4}') $(sensors | awk '/Tctl:|Tdie:|Package id 0:/ {print $2; exit}' | tr -d '+°C')\""
    ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var parts = this.text.trim().split(" ")
        root.cpuUsed = Math.round(parseFloat(parts[0]))
        root.cpuUsageProgress = root.cpuUsed / 100
        root.cpuTemp = Math.round(parseFloat(parts[1]) * 10) / 10
        root.cpuTempProgress = root.cpuTemp / 100
      }
    }
  }
  readonly property var ram: Process {
    command: ["sh", "-c",
      "awk 'BEGIN{total=0; used=0} /MemTotal:/ {total=$2} /MemAvailable:/ {avail=$2} END {printf \"%.2f %.2f\\n\", total/1024/1024, (total-avail)/1024/1024}' /proc/meminfo"
    ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var parts = this.text.trim().split(" ")
        root.ramTotal = Math.round(parseFloat(parts[0]))
        root.ramUsed = Math.round(parseFloat(parts[1]))
        root.ramUsageProgress = root.ramUsed / root.ramTotal
      }
    }
  }
  readonly property var swap: Process {
    command: ["sh", "-c",
      "awk '/SwapTotal:/ {printf \"%.2f \", $2/1024/1024}' /proc/meminfo; awk '/SwapTotal:/ {t=$2} /SwapFree:/ {f=$2} END {printf \"%.2f\", (t-f)/1024/1024}' /proc/meminfo"
    ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var parts = this.text.trim().split(" ")
        root.swapTotal = Math.round(parseFloat(parts[0]))
        root.swapUsed = Math.round(parseFloat(parts[1]))
        root.swapUsageProgress = root.swapUsed / root.swapTotal
      }
    }
  }
  readonly property var storage: Process {
    command: ["sh", "-c",
      "df -BG /home | awk 'NR==2 {gsub(/G/, \"\", $2); gsub(/G/, \"\", $3); printf \"%.2f %.2f\\n\", $2, $3}'"
    ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: {
        var parts = this.text.trim().split(" ")
        root.storageTotal = Math.round(parseFloat(parts[0]))
        root.storageUsed = Math.round(parseFloat(parts[1]))
        root.storageUsageProgress = root.storageUsed / root.storageTotal
      }
    }
  }

  Timer {
    id: statsTimer
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      cpu.running = true
      ram.running = true
      swap.running = true
      storage.running = true
    }
  }
}

