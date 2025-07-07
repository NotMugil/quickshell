import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import "root:/"
import "./WallpaperComponent"

Scope {
  id: wallpaper

  Variants {
      model: Quickshell.screens

      PanelWindow {
          id: wallpaper_window
          property var modelData
          screen: modelData

          WlrLayershell.exclusionMode: ExclusionMode.Exclusive
          WlrLayershell.layer: WlrLayer.Background

          anchors {
              top: true
              left: true
              right: true
              bottom: true
          }

          WallpaperComponent {
              id: wallpaperContent
              anchors.fill: parent
          }

          Item {
              id: borderRoot
              anchors.fill: parent

              Rectangle {
                  id: borderRect
                  anchors.fill: parent
                  color: Qt.alpha("#000000", 0.85)
                  visible: false
              }

              Item {
                  id: borderMask
                  anchors.fill: parent
                  layer.enabled: true
                  visible: false

                  Rectangle {
                      id: borderBlur
                      anchors.fill: parent
                      anchors.margins: Config.borderThickness
                      anchors.leftMargin: Config.barWidth == 0 ? Config.borderThickness : Config.barHeight
                      anchors.topMargin: Config.barHeight == 0 ? Config.borderThickness : Config.barHeight
                      radius: Config.borderRadius
                  }
              }

              MultiEffect {
                  anchors.fill: parent
                  maskEnabled: true
                  maskInverted: true
                  maskSource: borderMask
                  source: borderRect
                  maskThresholdMin: 0.5
                  maskSpreadAtMin: 1
              }
          }
      }
  }
}