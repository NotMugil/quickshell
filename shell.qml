import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import qs.config
import qs.components.wallpaper
import qs.components.bar


ShellRoot {
  id: root

  Component.onCompleted: Config
  Wallpaper {} 
  Bar {}
}