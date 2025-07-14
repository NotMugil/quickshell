import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components.common

Rectangle {
  id: workspacesroot
  color: "transparent"
  height: Config.barHeight / 1.5
  width: workspacesrow.implicitWidth 
  
  RowLayout {
    id: workspacesrow
    anchors.fill: parent
    spacing: 4

    Repeater {
      model: Hyprland.workspaces

      delegate: Rectangle {
        id: workspaceItem
        width: workspaceText.width + 10
        height: workspacesroot.height
        color: Config.buttonBackground == true && modelData.active ? Qt.alpha("#e0e1dd",0.1) : "transparent"
        radius: 5

        StyledText {
          id: workspaceText
          text: modelData.id
          anchors.centerIn: parent
          color: modelData.active ? "white" : Qt.alpha("#FFFFFF", 0.420)
        }

        MouseArea {
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: modelData.activate()
          z: 1
        }
      }
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      acceptedButtons: Qt.NoButton
      scrollGestureEnabled : bool
      z: 0
      // todo: fix the scroll sensitivity for trackpad or disable it
      onWheel: {
        if (wheel.angleDelta.y > 0) {
          Quickshell.execDetached(["hyprctl", "dispatch", "workspace", "e+1"])
        } else if (wheel.angleDelta.y < 0) {
          Quickshell.execDetached(["hyprctl", "dispatch", "workspace", "e-1"])
        }
      }
    }
  }
}