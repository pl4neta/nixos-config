import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Item {
  id: root
  property bool open: false

  IpcHandler {
    target: "dashboard"

    function dashToggle() { Global.open = !Global.open; }
    function dashOpen() { Global.open = true; }
    function dashClose() { Global.open = false; }
  }
}
