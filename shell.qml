import Quickshell
import QtQuick 
import Quickshell.Wayland
import Quickshell.Hyprland
import QtMultimedia

Variants {
  model: Quickshell.screens
  
  PanelWindow {    
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Background
    
    anchors {
      top: true
      left: true
      right: true
      bottom: true
    }

    height: HyprlandMonitor.height
    width: HyprlandMonitor.width


    Rectangle {
      anchors.fill: parent
      color: "black"
      
      Video {      
          id: wallpaper
          anchors.fill: parent
          autoPlay: true
          muted: true
          loops: MediaPlayer.Infinite
          source: "root:/wall.mp4"
      }
    }

  }
}