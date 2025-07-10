import Quickshell
import QtQuick
import Quickshell.Wayland
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import "root:/"
import "."

Scope {
  id: wallpaper

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: wallpaper_window
      property var modelData
      screen: modelData

      WlrLayershell.exclusionMode: ExclusionMode.Auto
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

      FastBlur {
        source: wallpaperContent
        radius: 32
        anchors.fill: wallpaperContent
      }

      Item { // Defines the wallpaper area without blur
        id: clearCenter
        anchors.fill: parent
        clip: true

        Rectangle {
          id: clearMask
          anchors.fill: parent
          anchors.margins: Config.borderThickness
          anchors.topMargin: Config.barPosition === "top" ? Config.barHeight : Config.borderThickness
          anchors.bottomMargin: Config.barPosition === "bottom" ? Config.barHeight : Config.borderThickness
          radius: Config.borderRadius
          color: "transparent" 
        }

        WallpaperComponent {
          id: wallpaperContentClear
          anchors.fill: parent
          anchors.margins: Config.borderThickness
          anchors.topMargin: Config.barPosition === "top" ? Config.barHeight : Config.borderThickness
          anchors.bottomMargin: Config.barPosition === "bottom" ? Config.barHeight : Config.borderThickness
        }
      }

      mask: Region {
          x: 0
          y: 0
          width: Config.barWidth == 0 ? modelData.width : Config.barWidth
          height: Config.barHeight == 0 ? modelData.height : Config.barHeight
      }
      
      ExclusionZone {
          anchors.top: true
          exclusiveZone: Config.barPosition == "bottom" ? Config.borderThickness : Config.barWidth
          screen: modelData
      }

      ExclusionZone {
          anchors.bottom: true
          exclusiveZone: Config.barPosition == "top" ? Config.borderThickness : Config.barWidth
          screen: modelData
      }
      
      ExclusionZone {
          anchors.left: true
          exclusiveZone: Config.borderThickness
          screen: modelData
      }
      ExclusionZone {
          anchors.right: true
          exclusiveZone: Config.borderThickness
          screen: modelData
      }

      Item {
        id: borderRoot
        anchors.fill: parent

        Rectangle {
            id: borderRect
            anchors.fill: parent
            color: Config.barColor
            visible: false
        }

        Item {
          id: borderMask
          anchors.fill: parent
          layer.enabled: true
          visible: false

          Rectangle {
            anchors.fill: parent
            anchors.margins: Config.borderThickness
            anchors.topMargin: Config.barPosition === "top" ? Config.barHeight : Config.borderThickness
            anchors.bottomMargin: Config.barPosition === "bottom" ? Config.barHeight : Config.borderThickness
            radius: Config.borderRadius
          }
        }

        MultiEffect {
            id: finalShape
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

  component ExclusionZone: PanelWindow {
      color: "transparent"
      exclusiveZone: Config.borderThickness
      mask: Region {}
  }
}