import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

import "root:/"
import "./components/wallpaper/"
import "./components/bar/"


ShellRoot {
  id: root

  Component.onCompleted: Config
  Wallpaper {} 
  Bar {}
}