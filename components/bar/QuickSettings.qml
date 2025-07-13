import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.config
import qs.components.common

Rectangle {
  id: quicksettingsroot
  height: Config.barHeight / 1.5
  width: quicksettingsrow.implicitWidth + 10
  //color: Qt.alpha("#FFFFFF", 0.07)
  color: "transparent"
  radius: 2
  
  RowLayout {
    id: quicksettingsrow
    anchors.fill: parent
    spacing: -5

    Network {}
    Bluetooth {}
    Battery {}
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Quickshell.execDetached(["wlogout", "-b", "5"])
  }
}

