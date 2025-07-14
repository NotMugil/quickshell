import QtQuick
import Quickshell
import QtQuick.Layouts

import qs.config
import qs.components.common

Rectangle {
  id: networkroot
  color: "transparent"
  width: networkicon.implicitWidth + 5
  Layout.fillHeight: true
  Layout.alignment: Qt.AlignRight

  // get the network type
  readonly property string networkType: {
	let type = "disconnected"
	if (NetworkStatus.netType) {
	  type = NetworkStatus.netType
	}
	return type;
  }
  // get the signal strength if the connection is wireless
  readonly property int networkStrength: {
	let strength = 0
	if (networkType === 'wifi') {
	  strength = Math.round(NetworkStatus.netStrength /25) *25;	// round the signal strength to the nearest quarter
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

  Icon {
    id: networkicon
    icon: getNetworkStatus()
    fill: 1
    grad: 0
    font.pixelSize: 14
    anchors.centerIn: parent
    color: networkType == "disconnected" ? Qt.alpha("#f9f9f9", 0.7) : "white"
  }
}