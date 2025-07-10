import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "root:/"

Scope {
  id: bar

  Variants {
    model: Quickshell.screens

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
        color: "transparent"

        RowLayout {
          id: row
          anchors.fill: parent
          spacing: 6
          
          Rectangle {
            anchors.right: row.right
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.fillHeight: true
          }
        }
      }

      ClockWidget {
        anchors.centerIn: parent
      }
    }
  }
}