import Quickshell
import QtQuick 

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: "transparent"

  Text {
    // center the bar in its parent component (the window)
    anchors.centerIn: parent
    color: "white"
    text: "hello world"
  }
}