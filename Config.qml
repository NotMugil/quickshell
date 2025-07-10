pragma Singleton

import QtQuick
import Quickshell

Singleton {
  id: root
    
  readonly property url wallpaperPath: "root:/assets/blue.mp4"

  readonly property real barHeight: 30
  readonly property real barWidth: 0
  readonly property real borderThickness: 8
  readonly property real borderRadius: 10
  readonly property string barPosition: "bottom" // top or bottom
}


