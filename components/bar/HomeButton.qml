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
  anchors.leftMargin: Config.borderThickness
  color: "transparent"
  width: homeicon.implicitWidth + 5
  height: Config.barHeight

  Icon {
    id: homeicon
    icon: "toast" 
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
    onClicked: Quickshell.execDetached(["rofi", "-show", "drun", "-theme", "~/.config/rofi/launcher.rasi"])
  }
}  