import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components.common

Rectangle {
  id: homeroot
  anchors.verticalCenter: parent.verticalCenter
  anchors.left: parent.left
  color: "transparent"
  width: homeicon.implicitWidth + 5
  height: Config.barHeight / 1.5

  Icon {
    id: homeicon
    icon: "tile_medium" 
    fill: 1
    grad: 0
    font.pixelSize: 16
    anchors.centerIn: parent
    color: "white"
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["rofi", "-show", "drun", "-theme", "~/.config/rofi/launcher.rasi"])
  }
}  