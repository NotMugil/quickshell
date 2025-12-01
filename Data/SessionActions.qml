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

  function quicksettings() {
    Quickshell.execDetached(["loginctl", "lock-session"]);
  }

  function nextws() {
    Quickshell.execDetached(["swaymsg", "workspace", "next"])
  }

  function prevws() {
    Quickshell.execDetached(["swaymsg", "workspace", "prev"])
  }
}
