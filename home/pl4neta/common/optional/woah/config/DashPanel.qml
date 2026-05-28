import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "Singleton" 1.0

Variants {
	id: root
	property color backgroundColor: "#f2232634"

	property color baseColor: "#303446"
  property color textColor: "#c6d0f5"
  property color mauve: "#ca9ee6"
  property color red: "#e78284"
  property color peach: "#ef9f76"
  property color yellow: "#e5c890"
  property color green: "#a6d189"
  property color blue: "#8caaee"
  property color sapphire: "#85c1dc"

  property string fontFamily: "JetBrainsMono Nerd Font Mono" 
  property real maxW: Screen.width * 0.65
  property real maxH: Screen.height * 0.65
  property real aspect: 98/53

	model: Quickshell.screens
	PanelWindow {
		id: w

		property var modelData
		screen: modelData

		exclusionMode: ExclusionMode.Ignore
		WlrLayershell.layer: WlrLayer.Overlay
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    visible: Global.open

		color: "transparent"

		contentItem {
			focus: true
			Keys.onPressed: event => {
				if (event.key == Qt.Key_Escape) Global.open = false;
			}
		}

		anchors {
			top: true
			left: true
			bottom: true
			right: true
		}

		Rectangle {
			color: backgroundColor;
			anchors.fill: parent

			MouseArea {
				anchors.fill: parent
				onClicked: Global.open = false

        Rectangle {
          id: dashboard

          anchors.centerIn: parent
          width: Math.min(maxW, maxH * aspect)
          height: width / aspect

          property real size: (height + height / 60) / 6
          property int round: 15
          property var props: ({
            size: dashboard.size,
            round: dashboard.round,
            baseColor: root.baseColor,
            textColor: root.textColor,
            fontFamily: root.fontFamily
          })

          color: "transparent"

          SystrayWidget {id: systray; props: dashboard.props}
          StatsWidget {id: stats; props: dashboard.props
            Stat {
              icon: ""
              value: Stats.cpuUsed
              progress: Stats.cpuUsageProgress
            }
            Stat {
              icon: ""
              value: Stats.cpuTemp
              progress: Stats.cpuTempProgress
            }
            Stat {
              icon: ""
              value: Stats.ramUsed
              progress: Stats.ramUsageProgress
            }
            Stat {
              icon: "󰯎"
              value: Stats.swapUsed
              progress: Stats.swapUsageProgress
            }
            Stat {
              icon: ""
              value: Stats.storageUsed
              progress: Stats.storageUsageProgress
            }
          }
          TimeWidget {id: time; props: dashboard.props}
          NotesWidget {id: notes;props: dashboard.props}
          NotificationsWidget {id: notifications; props: dashboard.props}
          PowerWidget {id: power; props: dashboard.props
            PowerButton {
              command: "systemctl poweroff"
              icon: "󰐥"
              color: red
            }
            PowerButton {
              command: "systemctl reboot"
              icon: "󰑐"
              color: yellow
            }
            PowerButton {
              command: "systemctl hibernate"
              icon: "󰤄"
              color: mauve
            }
            PowerButton {
              command: "hyprlock"
              icon: "󰌾"
              color: blue
            }
            PowerButton {
              command: "hyprctl dispatch exit"
              icon: "󰿅"
              color: green
            }
          }
          MediaWidget {id: media; props: dashboard.props}
          SystemWidget {id: settings; props: dashboard.props
            SystemButton {
              command: "nmcli radio wifi | grep -q enabled && nmcli radio wifi off || nmcli radio wifi on"
              icon: System.netIcon
              color: System.netColor
            }
            SystemButton {
              command: "bluetoothctl show | grep -q 'Powered: yes' && bluetoothctl power off || bluetoothctl power on"
              icon: System.btIcon
              color: System.btColor
            }
            SystemButton {
              command: ""
              icon: System.readIcon
              color: System.readColor//mauve
            }
            SystemButton {
              command: "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
              icon: System.volIcon
              color: System.volColor
            }
            SystemButton {
              command: "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
              icon: System.micIcon
              color: System.micColor
            }
            SystemButton {
              command: ""
              icon: System.vpnIcon
              color: System.vpnColor//green
            }
          }
        }
			}
		}
	}
}

