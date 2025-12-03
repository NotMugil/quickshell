import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

import qs.data as Data

PanelWindow {
    id: controlCenter

    WlrLayershell.layer: WlrLayer.Top
    visible: Data.GlobalStates.controlCenterOpen

    color: "transparent"
    exclusiveZone: 0

    property var cfg: Data.Config.data.settings
    property var clr: Data.Colors

    anchors {
        top: true
        right: true
    }

    Rectangle {
        id: controlCenterContainer
        color: cfg.bar.barColor
        implicitWidth: 400
        implicitHeight: 300
        anchors.fill: parent

        Item {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            //Top layer
            ColumnLayout {
                // 1st row (wifi+bluetooth+caffine)
                RowLayout {
                    ColumnLayout {

                    }
                }
                // 2nd row (nightlight+darkmode+)
                RowLayout {
                    ColumnLayout {

                    }
                }
            }
        }
    }
}
