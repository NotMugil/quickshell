import Quickshell
import Quickshell.Io
import Quickshell.I3
import QtQuick
import QtQuick.Layouts

import qs.Components as Com
import qs.Data as Data

Rectangle {
  property var cfg: Data.Config.data.settings
  property var clr: Data.Colors

  id: workspacesroot
  color: "transparent"
  height: cfg.bar.barHeight / 1.5
  width: workspacesrow.implicitWidth

  RowLayout {
    id: workspacesrow
    anchors.fill: parent
    spacing: 4

    Repeater {
      model: I3.workspaces

      delegate: Rectangle {
        id: workspaceItem
        width: workspaceText.width + 10
        height: workspacesroot.height
        color: cfg.bar.buttonBg == true && modelData.active ? clr.current.buttonBg : "transparent"
        radius: cfg.bar.buttonRadius

        StyledText {
          id: workspaceText
          text: modelData.num
          anchors.centerIn: parent
          color: modelData.active ? clr.current.primary_fixed : Qt.alpha(clr.current.primary_fixed, 0.420)
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
          Quickshell.execDetached(["swaymsg", "workspace", "next"])
        } else if (wheel.angleDelta.y < 0) {
          Quickshell.execDetached(["swaymsg", "workspace", "prev"])
        }
      }
    }
  }
}
