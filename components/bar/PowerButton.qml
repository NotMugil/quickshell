import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components.common

Rectangle {
  id: powerroot
  anchors.verticalCenter: parent.verticalCenter
  color: Config.buttonBackground == true ? Qt.alpha("#e0e1dd",0.1) : "transparent"
  radius: 5
  width: powericon.implicitWidth + 5
  height: Config.barHeight / 1.5

  Icon {
    id: powericon
    icon: "mode_off_on" 
    fill: 1
    grad: 0
    font.pixelSize: 14
    anchors.centerIn: parent
    color: "white"
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["wlogout", "-b", "5"])
  }
}  
