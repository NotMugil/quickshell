import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import qs.components as Com
import qs.data as Data

Rectangle {
    id: root

    property var cfg: Data.Config.data.settings
    property string time: "00:00"
    property string date: "January 1, Sunday"

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter
    width: clock.implicitWidth
    height: clock.implicitHeight
    color: "transparent"
    anchors.topMargin: cfg.bar.barHeight + 50

        //border.color: "red"
        //border.width: 2

    ColumnLayout {
        id: clock
        width: parent.width
        height: parent.height
        spacing: -10

        Rectangle {
            id: timeWrapper
            width: time.width
            height: time.height
            color: "transparent"
                //border.color: "blue"
                //border.width: 2
            anchors.horizontalCenter: parent.horizontalCenter

            Com.LockFont {
                id: time
                text: root.time
                color: clr.current.primary_fixed
                fontSize: cfg.lock.timeFontSize
            }
        }

        Rectangle {
            id: dateWrapper
            width: date.width
            height: date.height
            color: "transparent"
                //border.color: "green"
                //border.width: 2
            anchors.horizontalCenter: parent.horizontalCenter

            Com.LockFont {
                id: date
                Layout.alignment: Qt.AlignHCenter
                text: root.date
                color: clr.current.primary_fixed
                fontSize: cfg.lock.dateFontSize
            }
        }
    }


Process {
    id: timeProc
    command: [ "date", "+%H:%M" ]
    running: true

    stdout: StdioCollector {
        onStreamFinished: root.time = this.text
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
    }
}
}
