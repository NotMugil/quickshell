pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  function launcher() {
    Quickshell.execDetached(["sherlock"]);
  }

  function poweroff() {
    Quickshell.execDetached(["poweroff"]);
  }

  function reboot() {
    Quickshell.execDetached(["reboot"]);
  }

  function suspend() {
    Quickshell.execDetached(["loginctl", "lock-session"]);
    Quickshell.execDetached(["systemctl", "suspend"]);
  }
}
