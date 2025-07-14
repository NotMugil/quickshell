import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components.common

Rectangle {
  id: bluetoothRoot
  color: "transparent"
  width: bluetoothicon.implicitWidth + 5
  Layout.fillHeight: true
  Layout.alignment: Qt.AlignRight

  readonly property string bluetoothStatus: BluetoothStatus.btState || "disabled"

  function getBluetoothStatus() {
    let bluState = "bluetooth_disabled"
    if (BluetoothStatus.powered) {
        if (BluetoothStatus.paired) {
            bluState = "bluetooth_connected"
        } else {
            bluState = "bluetooth"
        }
    }
    return bluState;
  }

  Icon {
    id: bluetoothicon
    icon: getBluetoothStatus()
    fill: 1
    grad: 0
    font.pixelSize: 14
    anchors.centerIn: parent
    color: BluetoothStatus.powered ? "white" : Qt.alpha("#F9F9F9", 0.6)
  }
}
