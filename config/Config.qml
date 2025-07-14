pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root
    
  readonly property url wallpaperPath: "root:/assets/megarex.mp4"

  readonly property string barPosition: "top" // top or bottom
  readonly property real barHeight: 30
  readonly property real barWidth: 0
  readonly property real borderThickness: 0
  readonly property real borderRadius: 10

  readonly property bool buttonBackground: true

  readonly property real barOpacity: 0.603
  readonly property color barColor: Qt.alpha("#000000", barOpacity)
}


