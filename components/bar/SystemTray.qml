import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray

import "root:/"

Rectangle {
  id: systray
  color: "transparent"
  width: parent.width
  implicitHeight: Config.barHeight

  RowLayout {
    id: systray_row
    anchors.centerIn: parent
    spacing: 10
    
    Repeater {
      model: SystemTray.items

      delegate: Rectangle {
        id: sysitem
        IconImage {
          anchors.centerIn: parent
          width: systray.width / 2
          height: Config.barHeight / 2
          source: modelData.icon
        }

        QsMenuAnchor {
          id: menu
          menu: sysitem.modelData.menu
        }

        MouseArea {
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          anchors.fill: parent

          onClicked: event => {
            if (event.button === Qt.LeftButton)
                modelData.activate();
            else if (modelData.hasMenu)
                menu.open();
          }   
        }
      }
    }
  }
}      
    