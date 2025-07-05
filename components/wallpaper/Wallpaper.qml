import Quickshell
import QtQuick 
import Quickshell.Wayland

import "root:/"
import "./WallpaperComponent"

Scope {
  id: bar
  Variants {
    model: Quickshell.screens
    
    PanelWindow {    
      id: wallpaper_window
      property var modelData
      screen: modelData

      WlrLayershell.exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Background
      
      anchors {
        top: true
        left: true
        right: true
        bottom: true
      }

      WallpaperComponent {}
    }
  }
}
