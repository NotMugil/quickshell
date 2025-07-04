import Quickshell
import QtQuick 
import Quickshell.Wayland

Variants {
  model: Quickshell.screens

  PanelWindow {
    
    // WlrLayershell.exclusionMode: ExclusionMode.Ignore
    // WlrLayershell.layer: WlrLayer.Background

    anchors.top: true
    anchors.left: true
    anchors.right: true


    implicitHeight: 30

    Text {
      // center the bar in its parent component (the window)
      anchors.centerIn: parent

      text: "hello world"
    }
  }
}