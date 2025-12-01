import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Wayland

import qs.Data as Data
import qs.Components as Com

Image {
  antialiasing: true
  asynchronous: true
  fillMode: Image.PreserveAspectCrop
  layer.enabled: true
  retainWhileLoading: true
  smooth: true
  source: Data.Config.data.wallSrc

  onStatusChanged: {
    if (this.status == Image.Error) {
      console.log("[ERROR] Wallpaper source invalid");
      console.log("[INFO] Please disable set wallpaper if not required");
    }
  }
}
