import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs.config
import qs.components.common
import qs.components.bar

Scope {
  id: bar

  Variants {
    model: Quickshell.screens

    Process {
        id: process
        onRunningChanged: {
            if (!running) {
                console.log("Command finished. Exit code:", exitCode)
                console.log("Output:", output)
            }
        }
    }

    PanelWindow {
      property var modelData
      screen: modelData

      color: "transparent"
      implicitHeight: Config.barHeight
      
      anchors {
        top: Config.barPosition === "top" ? true : false
        bottom: Config.barPosition === "bottom" ? true : false
        left: true
        right: true
      }

      Rectangle {
        id: barBase
        width: parent.width
        height: parent.height
        color: "transparent"

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
            Layout.leftMargin: Config.borderThickness != 0 ? Config.borderThickness : 8

            RowLayout {
              id: leftrow
              anchors.fill: parent
              spacing: 12

              HomeButton {}
              Workspaces {}
            }
          }

          // Center widgets
          ClockWidget {
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
            Layout.rightMargin: Config.borderThickness != 0 ? Config.borderThickness : 8

            RowLayout {
              id: rightrow
              anchors.fill: parent
              spacing: 10
              
              //ClockWidget {}
              QuickSettings {}
              PowerButton {}
            }

          }
        }
      }
    }
  }
}
