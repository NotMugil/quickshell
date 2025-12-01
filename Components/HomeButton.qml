import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import qs.Components as Com
import qs.Data as Data

Rectangle {
    property var cfg: Data.Config.data.settings
    property var clr: Data.Colors

    id: homeroot
    anchors.verticalCenter: parent.verticalCenter
    color: cfg.bar.buttonBg == true ? clr.current.buttonBg : "transparent"
    radius: cfg.bar.buttonRadius
    width: cfg.bar.barHeight * 0.65
    height: cfg.bar.barHeight * 0.65

    Com.Icon {
        id: homeicon
        icon: "tile_medium"
        fill: 1
        grad: 0
        font.pixelSize: parent.width * 0.73
        anchors.centerIn: parent
        color: "white"
    }

    Com.MouseArea {
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Data.SessionActions.launcher()
    }
}
