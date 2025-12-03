pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  property string time: "00:00"
  property string date: "January 1, Sunday"
  property string datetime: ""

  Process {
    id: timeProc
	command: [ "date", "+%H:%M" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.time = this.text
    }
  }

  Process {
    id: datetimeProc
	command: [ "date", "+%H:%M | %d/%m" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.datetime = this.text
    }
  }

  Process {
    id: dateProc
	command: [ "date", "+%B %-d, %A" ]
    running: true

    stdout: StdioCollector {
      onStreamFinished: root.date = this.text
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      timeProc.running = true
      dateProc.running = true
      datetimeProc.running = true
    }
  }
}
