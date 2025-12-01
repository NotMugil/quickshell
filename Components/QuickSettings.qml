import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Components as Com
import qs.Data as Data

Rectangle {
  property var clr: Data.Colors
  property var cfg: Data.Config.data.settings

  id: quicksettingsroot
  height: cfg.bar.barHeight * 0.65
  width: quicksettingsrow.implicitWidth + 10
  color: cfg.bar.buttonBg == true ? clr.current.buttonBg : "transparent"
  radius: cfg.bar.buttonRadius

  RowLayout {
    id: quicksettingsrow
    anchors.fill: parent
    anchors.leftMargin: cfg.bar.barHeight * 0.1
    anchors.rightMargin: cfg.bar.barHeight * 0.1
    spacing: 0
    Com.Network {}
    Com.Bluetooth {}
    Com.Battery {}
  }

  Com.MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Data.SessionActions.quicksettings()
  }
}
