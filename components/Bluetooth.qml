import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components as Com
import qs.data as Data
import qs.services

Rectangle {
  id: bluetoothRoot
  color: "transparent"
  width: cfg.bar.barHeight * 0.65
  height: cfg.bar.barHeight * 0.65
  Layout.alignment: Qt.AlignRight

  readonly property string bluetoothStatus: Bluetooth.btState || "disabled"

  function getBluetoothStatus() {
    let bluState = "bluetooth_disabled"
    if (Bluetooth.powered) {
        if (Bluetooth.paired) {
            bluState = "bluetooth_connected"
        } else {
            bluState = "bluetooth"
        }
    }
    return bluState;
  }

  Com.Icon {
    id: bluetoothicon
    icon: getBluetoothStatus()
    fill: 1
    grad: 0
    font.pixelSize: parent.width * 0.73
    anchors.centerIn: parent
    anchors.verticalCenter: parent
    color: Bluetooth.powered ? "white" : Qt.alpha("#F9F9F9", 0.6)
  }
}
