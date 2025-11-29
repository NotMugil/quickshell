import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.Components as Com
import qs.Data as Data

Rectangle {
  id: batteryRoot
  color: "transparent"
  width: batteryicon.implicitWidth + 5
  Layout.fillHeight: true
  Layout.alignment: Qt.AlignRight

  function getBatteryStatus() {
    let batState = "bluetooth_disabled"
    if (Data.BatteryStatus.isCharging == "1" && Data.BatteryStatus.health == "full") {
      batState = "battery_charging_full"
    } else if (Data.BatteryStatus.isCharging == "1" && Data.BatteryStatus.health == "good") {
      batState = "battery_charging_50"
    } else if (Data.BatteryStatus.isCharging == "1" && Data.BatteryStatus.health == "low") {
      batState = "battery_charging_30"
    } else if (Data.BatteryStatus.isCharging == "1" && Data.BatteryStatus.health == "caution") {
      batState = "battery_charging_20"
    } else if (Data.BatteryStatus.health == "charged") {
      batState = "battery_full"
    } else if (Data.BatteryStatus.health == "full") {
      batState = "battery_4_bar"
    } else if (Data.BatteryStatus.health == "good") {
      batState = "battery_3_bar"
    } else if (Data.BatteryStatus.health == "low") {
      batState = "battery_2_bar"
    } else if (Data.BatteryStatus.health == "caution") {
      batState = "battery_1_bar"
    } else {
      batState = "battery_0_bar"
    }
    return batState;
  }

  function getBatteryColor() {
    let batState = "bluetooth_disabled"
    if (Data.BatteryStatus.isCharging == "1") {
      batState = "white"
    } else if (Data.BatteryStatus.health == "full") {
      batState = "white"
    } else if (Data.BatteryStatus.health == "good") {
      batState = "white"
    } else if (Data.BatteryStatus.health == "low") {
      batState = "yellow"
    } else if (Data.BatteryStatus.health == "caution") {
      batState = "red"
    } else {
      batState = "white"
    }
    return batState;
  }

  Com.Icon {
    id: batteryicon
    icon: getBatteryStatus()
    fill: 1
    grad: 0
    font.pixelSize: 14
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    color: getBatteryColor()
  }
}
