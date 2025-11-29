import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.Components as Com
import qs.Data as Data

Rectangle {
  id: bluetoothRoot
  color: "transparent"
  width: bluetoothicon.implicitWidth + 5
  Layout.fillHeight: true
  Layout.alignment: Qt.AlignRight

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
    font.pixelSize: 14
    anchors.centerIn: parent
    color: Data.BluetoothStatus.powered ? "white" : Qt.alpha("#F9F9F9", 0.6)
  }
}
