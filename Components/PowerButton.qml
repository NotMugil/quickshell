import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Components as Com
import qs.Data as Data

Rectangle {
  id: powerroot
  anchors.verticalCenter: parent.verticalCenter
  color: cfg.bar.buttonBg == true ? Qt.alpha("#e0e1dd",0.1) : "transparent"
  radius: 5
  width: powericon.implicitWidth + 5
  height: cfg.bar.barHeight / 1.5

  // border.color: "red"

  Com.Icon {
    anchors.fill: centerI
    id: powericon
    icon: "mode_off_on"
    fill: 1
    grad: 0
    font.pixelSize: 14
    anchors.centerIn: parent
    color: "white"
  }

  Com.MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["wlogout", "-b", "5"])
  }
}
