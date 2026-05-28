import QtQuick
import Quickshell.Io

QtObject {
	required property string command
	required property string icon
  required property color color

	id: button

	readonly property var process: Process {
		command: ["sh", "-c", button.command]
	}

	function exec() {
		process.startDetached();
		Global.open = false;
	}
}

