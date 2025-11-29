pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

import qs.Data as Data

Singleton {
  id: root

  property alias data: jsonData
  property alias fgGenProc: generateFg
  property string wallFg: ""

  FileView {
    path: Data.Paths.config + "/settings.json"

    // when changes are made on disk, reload the file's content
    watchChanges: true
    onFileChanged: reload()

    // when changes are made to properties in the adapter, save them
    onAdapterUpdated: writeAdapter()

    JsonAdapter {
        id: jsonData

        property bool mousePsystem: false
        property bool reservedShell: false
        property bool setWallpaper: true
        property bool wallFgLayer: false
        property string wallSrc: Quickshell.env("HOME") + "/Pictures/Wallpapers"

        property JsonObject settings: JsonObject {
            property JsonObject bar: JsonObject {
                property int fontSize: 12
                property int trayIconSize: 16
                property bool monochromeTrayIcons: true
                property string barPosition: "top"
                property bool buttonBg: true
                property int borderThickness: 10
                property int barHeight: 30
                property string barColor: Qt.rgba(0, 0, 0, 0.69)
                property real barOpacity: 0.9
                property int cornerRadius: 14
            }
        }
    }
  }

  IpcHandler {
    function setWallpaper(path: string) {
      path = Qt.resolvedUrl(path);
      jsonData.wallSrc = path;
    }

    target: "settings"
  }

  Process {
    id: generateFg

    property string script: Data.Paths.urlToPath(Qt.resolvedUrl("../scripts/extractFg.sh"))

    command: ["bash", script, Data.Paths.urlToPath(jsonData.wallSrc), Data.Paths.urlToPath(Data.Paths.cache)]

    stdout: SplitParser {
      onRead: data => {
        if (/\[.*\]/.test(data)) {
          console.log(data);
        } else if (/FOREGROUND/.test(data)) {
          root.wallFg = data.split(" ")[1];
        } else {
          console.log("[EXT] " + data);
        }
      }
    }
  }

  Connections {
    function onWallFgLayerChanged() {
      onWallSrcChanged();
    }

    function onWallSrcChanged() {
        if (jsonData.wallSrc != "" && !generateFg.running) {
            generateFg.running = true;
        }
    }

    target: jsonData
  }
}
