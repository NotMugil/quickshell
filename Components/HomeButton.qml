import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Components as Com
import qs.Data as Data

Rectangle {
    property var cfg: Data.Config.data.settings

    id: homeroot
    anchors.verticalCenter: parent.verticalCenter
    color: cfg.bar.buttonBg == true ? Qt.alpha("#e0e1dd",0.1) : "transparent"
    radius: 5
    width: homeicon.implicitWidth + 5
    height: cfg.bar.barHeight / 1.5

    Com.Icon {
        id: homeicon
        icon: "tile_medium"
        fill: 1
        grad: 0
        font.pixelSize: 16
        anchors.centerIn: parent
        color: "white"
    }

    Com.MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["rofi", "-show", "drun", "-theme", "~/.config/rofi/launcher.rasi"])
    }
}
