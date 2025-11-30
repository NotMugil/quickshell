import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Components as Com
import qs.Data as Data

Rectangle {
  property var cfg: Data.Config.data.settings
  property var clr: Data.Colors

  id: powerroot
  anchors.verticalCenter: parent.verticalCenter
  color: cfg.bar.buttonBg == true ? clr.current.buttonBg : "transparent"
  radius: cfg.bar.buttonRadius
  width: powericon.implicitWidth + 5
  height: cfg.bar.barHeight / 1.5

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
