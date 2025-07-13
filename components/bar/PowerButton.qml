import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components.common

Rectangle {
  id: powerroot
  anchors.verticalCenter: parent.verticalCenter
  anchors.left: parent.left
  color: "transparent"
  width: powericon.implicitWidth + 5
  height: Config.barHeight

  Icon {
    id: powericon
    icon: "mode_off_on" 
    fill: 1
    grad: 0
    font.pixelSize: 18
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