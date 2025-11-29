import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.Components as Com
import qs.Data as Data

Scope {
  id: barrr

  Variants {

    Process {
        id: process
        onRunningChanged: {
            if (!running) {
                console.log("Command finished. Exit code:", exitCode)
                console.log("Output:", output)
            }
        }
    }

    model: Quickshell.screens
    delegate: PanelWindow {
      screen: modelData

      property var modelData
      property var cfg: Data.Config.data.settings
      color: "transparent"
      implicitHeight: cfg.bar.barHeight

      anchors {
        top: cfg.bar.barPosition === "top" ? true : false
        bottom: cfg.bar.barPosition === "bottom" ? true : false
        left: true
        right: true
      }

      Rectangle {
        id: barBase
        width: parent.width
        height: parent.height
        color: "transparent"

        Rectangle {
            id: barBg
            width: parent.width
            height: parent.height
            color: cfg.bar.barColor
        }

        RowLayout {
          id: row
          anchors.fill: parent
          spacing: 6

          // Left widgets
          Rectangle {
            id: leftbarBase
            color: "transparent"
            width: leftrow.implicitWidth
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: cfg.bar.borderThickness != 0 ? cfg.bar.borderThickness : 8

            RowLayout {
              id: leftrow
              anchors.fill: parent
              spacing: 12

              Com.HomeButton {}
              Com.Workspaces {}
            }
          }

          // Center widgets
          Com.ClockWidget {
            Layout.alignment: Qt.AlignCenter
            anchors.centerIn: parent
          }

          // Right widgets
          Rectangle {
            id: rightbarBase
            color: "transparent"
            width: rightrow.implicitWidth
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: cfg.bar.borderThickness != 0 ? cfg.bar.borderThickness : 8

            RowLayout {
              id: rightrow
              anchors.fill: parent
              spacing: 10

              Com.QuickSettings {}
              Com.PowerButton {}
            }

          }
        }
      }
    }
  }
}
