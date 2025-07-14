import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components.common

Rectangle {
  id: batteryRoot
  color: "transparent"
  width: batteryicon.implicitWidth + 5
  Layout.fillHeight: true
  Layout.alignment: Qt.AlignRight

  function getBatteryStatus() {
    let batState = "bluetooth_disabled"
    if (BatteryStatus.isCharging == "1" && BatteryStatus.health == "full") {
      batState = "battery_charging_full"
    } else if (BatteryStatus.isCharging == "1" && BatteryStatus.health == "good") {
      batState = "battery_charging_50"
    } else if (BatteryStatus.isCharging == "1" && BatteryStatus.health == "low") {
      batState = "battery_charging_30"
    } else if (BatteryStatus.isCharging == "1" && BatteryStatus.health == "caution") {
      batState = "battery_charging_20"
    } else if (BatteryStatus.health == "charged") {
      batState = "battery_full"
    } else if (BatteryStatus.health == "full") {
      batState = "battery_4_bar"
    } else if (BatteryStatus.health == "good") {
      batState = "battery_3_bar"
    } else if (BatteryStatus.health == "low") {
      batState = "battery_2_bar"
    } else if (BatteryStatus.health == "caution") {
      batState = "battery_1_bar"
    } else {
      batState = "battery_0_bar"
    }
    return batState;
  }

  function getBatteryColor() {
    let batState = "bluetooth_disabled"
    if (BatteryStatus.isCharging == "1") {
      batState = "white"
    } else if (BatteryStatus.health == "full") {
      batState = "white"
    } else if (BatteryStatus.health == "good") {
      batState = "white"
    } else if (BatteryStatus.health == "low") {
      batState = "white"
    } else if (BatteryStatus.health == "caution") {
      batState = "red"
    } else {
      batState = "white"
    }
    return batState;
  }

  Icon {
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
