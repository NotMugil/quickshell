import Quickshell
import QtQuick
import QtQuick.Layouts

import qs.components as Com
import qs.data as Data
import qs.services

Rectangle {
  id: batteryRoot
  color: "transparent"
  width: cfg.bar.barHeight * 0.65
  height: cfg.bar.barHeight * 0.65
  Layout.alignment: Qt.AlignRight

  function getBatteryStatus() {
    let batState = "bluetooth_disabled"
    if (Battery.isCharging == "1" && Battery.health == "full") {
      batState = "battery_charging_full"
    } else if (Battery.isCharging == "1" && Battery.health == "good") {
      batState = "battery_charging_50"
    } else if (Battery.isCharging == "1" && Battery.health == "low") {
      batState = "battery_charging_30"
    } else if (Battery.isCharging == "1" && Battery.health == "caution") {
      batState = "battery_charging_20"
    } else if (Battery.health == "charged") {
      batState = "battery_full"
    } else if (Battery.health == "full") {
      batState = "battery_4_bar"
    } else if (Battery.health == "good") {
      batState = "battery_3_bar"
    } else if (Battery.health == "low") {
      batState = "battery_2_bar"
    } else if (Battery.health == "caution") {
      batState = "battery_1_bar"
    } else {
      batState = "battery_0_bar"
    }
    return batState;
  }

  function getBatteryColor() {
    let batState = "bluetooth_disabled"
    if (Battery.isCharging == "1") {
      batState = "white"
    } else if (Battery.health == "full") {
      batState = "white"
    } else if (Battery.health == "good") {
      batState = "white"
    } else if (Battery.health == "low") {
      batState = "yellow"
    } else if (Battery.health == "caution") {
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
    font.pixelSize: parent.width * 0.73
    anchors.centerIn: parent
    anchors.verticalCenter: parent
    color: getBatteryColor()
  }
}
