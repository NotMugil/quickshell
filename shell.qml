//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick
import qs.Layers as Lay
import qs.Data as Data

ShellRoot {
  Variants {
    model: Quickshell.screens

    Scope {
        id: scopeRoot

        // inhibit the reload popup
        Connections {
            function onReloadCompleted() {
                Quickshell.inhibitReloadPopup();
            }

            function onReloadFailed() {
                Quickshell.inhibitReloadPopup();
            }

            target: Quickshell
        }

        Lay.Bar {}
        LazyLoader {
            activeAsync: Data.Config.data.setWallpaper
            component: Lay.Wallpaper {}
        }

    Lay.Lockscreen {
    }
    }
  }

}
