import QtQuick
import Quickshell

import "root:/"
import "./components" as Components

ShellRoot {
  id: root

  Component.onCompleted: Config
  Components.Wallpaper {}
}