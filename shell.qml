//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import QtQuick

import qs.windows.bar
import qs.windows.lockscreen
import qs.windows.osdpanel
import qs.windows.quicksettings
import qs.windows.wallpaper

import qs.data as Data

ShellRoot {
  Variants {
    model: Quickshell.screens

    Scope {
        id: scopeRoot

        Bar {}
        QuickSettings {}
        Lockscreen {}
        LazyLoader {
            activeAsync: Data.Config.data.showOsd
            component: OsdPanel {}
        }
        LazyLoader {
            activeAsync: Data.Config.data.setWallpaper
            component: Wallpaper {}
        }

        Connections {
            function onReloadCompleted() {
                Quickshell.inhibitReloadPopup();
            }

            function onReloadFailed() {
                Quickshell.inhibitReloadPopup();
            }

            target: Quickshell
        }
    }
  }
}
