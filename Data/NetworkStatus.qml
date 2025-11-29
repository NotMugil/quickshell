/*--------------------------------
--- Network service by andrel ---*
--------------------------------*/

pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
	property string netType
	property string netStrength

	reloadableId: "network"

	Process {
		running: true
		command: ["nmcli", "m"]
		stdout: SplitParser {
			onRead: getNetType.running = true	// update the network type on connection change
		}
	}

	Process {
	    id: getNetType
		running: true
		command: ["nmcli", "-g", "STATE,TYPE", "d"]
		stdout: StdioCollector {
			onStreamFinished: {
				const lines = text.trim().split('\n');
				root.netType = lines.find(line => line.startsWith('connected:'))?.split(':')[1] || null;
				getNetStrength.running = (root.netType === 'wifi')		// get network strength if connection is wireless
			}
		}
	}

	Process { id: getNetStrength
		running: false
		command: ["nmcli", "-g", "ACTIVE,SIGNAL", "d", "w"]
		stdout: StdioCollector {
			onStreamFinished: {
				const lines = text.split('\n');
				root.netStrength = lines.find(line => line.startsWith('yes:'))?.split(':')[1] || null;
			}
		}
	}

	Timer {
		interval: 60000
		running: true
		repeat: true
		onTriggered: getNetStrength.running = (root.netType === 'wifi')
	}
}
