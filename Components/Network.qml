import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.Components as Com
import qs.Data as Data

Rectangle {
  id: networkroot
  color: "transparent"
  width: cfg.bar.barHeight * 0.65
  height: width
  Layout.alignment: Qt.AlignRight

  // border.color: "red"

  readonly property string networkType: {
	let type = "disconnected"
	if (Data.NetworkStatus.netType) {
	  type = Data.NetworkStatus.netType
	}
	return type;
  }

  readonly property int networkStrength: {
	let strength = 0
	if (networkType === 'wifi') {
	  strength = Math.round(Data.NetworkStatus.netStrength /25) *25;
	}
	return strength;
  }

  function getNetworkStatus() {
	if (networkType === 'disconnected') {
        return "signal_wifi_off";
    } else if (networkType === 'wifi') {
      if (networkStrength === 0) {
        return "signal_wifi_0_bar";
      } else if (networkStrength < 40) {
    	return "network_wifi_bar_1";
	  } else if (networkStrength < 60) {
    	return "network_wifi_bar_2";
      } else if (networkStrength < 75) {
        return "network_wifi_bar_3";
      } else {
        return "signal_wifi_4_bar";
      }
    }
    return "wifi_find";
  }

  Com.Icon {
    id: networkicon
    icon: getNetworkStatus()
    fill: 1
    grad: 0
    font.pixelSize: parent.width * 0.73
    anchors.centerIn: parent
    anchors.verticalCenter: parent
    color: networkType == "disconnected" ? Qt.alpha("#f9f9f9", 0.7) : "white"
  }
}
