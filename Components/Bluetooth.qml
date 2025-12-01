import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.Components as Com
import qs.Data as Data

Rectangle {
  id: bluetoothRoot
  color: "transparent"
  width: cfg.bar.barHeight * 0.65
  height: cfg.bar.barHeight * 0.65
  Layout.alignment: Qt.AlignRight

   // border.color: "red"


  readonly property string bluetoothStatus: Data.BluetoothStatus.btState || "disabled"

  function getBluetoothStatus() {
    let bluState = "bluetooth_disabled"
    if (Data.BluetoothStatus.powered) {
        if (Data.BluetoothStatus.paired) {
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
    color: Data.BluetoothStatus.powered ? "white" : Qt.alpha("#F9F9F9", 0.6)
  }
}
