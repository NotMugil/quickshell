pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.Widgets as Widget

Scope {
    WlSessionLock {
        id: lock
        onLockedChanged: if (!locked) {
            // Optional: reset any global state if needed
        }

        Widget.Lockscreen{ lock: lock }
    }

    IpcHandler {
        target: "lockscreen"

        function lock()    { locker.start() }
        function unlock()  { lock.locked = false }
    }

    Timer {
        id: locker
        interval: 200
        onTriggered: lock.locked = true
    }
}
