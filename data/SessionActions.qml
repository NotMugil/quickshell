pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

import qs.data as Data

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
    Data.GlobalStates.controlCenterOpen = !Data.GlobalStates.controlCenterOpen
  }

  function nextws() {
    Quickshell.execDetached(["swaymsg", "workspace", "next"])
  }

  function prevws() {
    Quickshell.execDetached(["swaymsg", "workspace", "prev"])
  }
}
