import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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

          Rectangle {
            color: "transparent"
            width: leftrow.implicitWidth + 20
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            anchors.left: row.left

            RowLayout {
              id: leftrow
              anchors.fill: parent
              spacing: 6

              Rectangle {
                id: homeroot
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Config.borderThickness
                color: "blue"
                width: homeicon.implicitWidth + 5
                height: Config.barHeight / 1.5 

                Icon {
                  id: homeicon
                  icon: "toast" 
                  fill: 1
                  grad: 0
                  font.pixelSize: 18
                  anchors.centerIn: parent
                  color: "white"
                }

                MouseArea {
                  acceptedButtons: Qt.LeftButton | Qt.RightButton
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: {
                    console.log("Icon clicked!")
                  }
                }
              }  

              Rectangle {
                id: workspacesroot
                color: "red"
                height: Config.barHeight / 1.5
                width: 20
              }
            }
          }
        }
      }

      ClockWidget {
        anchors.centerIn: parent
      }

    }
  }
}