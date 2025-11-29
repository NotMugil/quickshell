// heavily referenced soramane's lockscreen code
// https://github.com/caelestia-dots/shell/tree/main/modules/lock
pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pam
import QtQuick.Effects
import Quickshell.Wayland
import Quickshell.Widgets

import qs.Data as Data
import qs.Widgets as Wid
import qs.Components as Com

WlSessionLockSurface {
  id: surface
  property bool error: false
  property string inputBuffer: ""
  readonly property list<string> kokomi: ["aw", "ma", "nc", "re", "ep", "er"]
  required property WlSessionLock lock
  property string maskedBuffer: ""
  property bool unlocking: false

  property var cfg: Data.Config.data.settings
  property var clr: Data.Colors

  Wid.Wallpaper {
    id: wallpaper
    anchors.fill: parent

    layer.effect: MultiEffect {
      id: walBlur
      autoPaddingEnabled: false
      blurEnabled: true
      NumberAnimation on blur {
        duration: Data.MaterialEasing.emphasizedTime
        easing.type: Easing.Linear
        from: 0
        to: 0.69
      }

      NumberAnimation {
        duration: Data.MaterialEasing.emphasizedTime * 1.5
        easing.type: Easing.Linear
        property: "blur"
        running: surface.unlocking
        target: walBlur
        to: 0
      }
    }
  }

  Item {
    anchors.centerIn: parent
    clip: true
    height: kokomiText.contentHeight
    width: (pam.active) ? 0 : kokomiText.contentWidth

    Behavior on width {
      NumberAnimation {
        duration: Data.MaterialEasing.emphasizedTime
        easing.bezierCurve: Data.MaterialEasing.emphasized
      }
    }

    Rectangle {
      id: gradient

      anchors.fill: kokomiText
      visible: false

      gradient: Gradient {
        GradientStop {
          color: clr.current.primary
          position: 0.0
        }

        GradientStop {
          color: (surface.error) ? clr.current.error : clr.current.tertiary
          position: 1.0
        }
      }
    }

    Text {
      id: kokomiText

      anchors.centerIn: parent
      anchors.verticalCenterOffset: contentHeight * 0.2
      font.bold: true
      font.family: "Libre Barcode 128"
      font.pointSize: 400
      layer.enabled: true
      layer.smooth: true
      opacity: fg.opacity
      renderType: Text.NativeRendering
      text: surface.maskedBuffer
      visible: false
    }

    MultiEffect {
      anchors.fill: gradient
      maskEnabled: true
      maskSource: kokomiText
      maskSpreadAtMin: 1.0
      maskThresholdMax: 1.0
      maskThresholdMin: 0.5
      source: gradient
    }
  }

  Item {
    id: fgContainer
    anchors.fill: parent
    clip: true
    anchors.topMargin: cfg.bar.barHeight
    anchors.bottomMargin: cfg.bar.barHeight
    visible: !Data.Config.fgGenProc.running

    Image {
        id: fg
        anchors.fill: parent
        anchors.topMargin: -cfg.bar.barHeight
        anchors.bottomMargin: -cfg.bar.barHeight
        antialiasing: true
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.smooth: true
        mipmap: true
        smooth: true
        source: Data.Config.wallFg
        // Don't show the fg if fg is being generated
        visible: !Data.Config.fgGenProc.running

        NumberAnimation on opacity {
            duration: Data.MaterialEasing.emphasizedTime
            easing.type: Easing.Linear
            from: 0
            to: 1
        }

        NumberAnimation {
            duration: Data.MaterialEasing.emphasizedTime * 1.5
            easing.type: Easing.Linear
            from: 1
            property: "opacity"
            running: surface.unlocking
            target: fg
            to: 0
        }
    }
  }

  Rectangle {
    id: inputRect

    anchors.centerIn: parent
    clip: true
    color: (surface.error) ? clr.current.error : (surface.unlocking) ? clr.current.primary : clr.current.surface
    focus: true
    height: 40
    radius: 20
    width: inputRow.width

    Behavior on color {
      ColorAnimation {
        duration: 200
      }
    }
    NumberAnimation on opacity {
      duration: Data.MaterialEasing.emphasizedTime
      easing.type: Easing.Linear
      from: 0
      to: 1
    }
    Behavior on width {
      NumberAnimation {
        duration: Data.MaterialEasing.emphasizedTime
        easing.bezierCurve: Data.MaterialEasing.emphasized
      }
    }

    Keys.onPressed: kevent => {
      if (pam.active) {
        return;
      }

      if (kevent.key === Qt.Key_Enter || kevent.key === Qt.Key_Return) {
        pam.start();
        return;
      }

      if (kevent.key === Qt.Key_Backspace) {
        if (kevent.modifiers & Qt.ControlModifier) {
          surface.inputBuffer = "";
          surface.maskedBuffer = "";
          return;
        }
        surface.inputBuffer = surface.inputBuffer.slice(0, -1);
        surface.maskedBuffer = surface.maskedBuffer.slice(0, -1);
        return;
      }

      if (kevent.text) {
        surface.inputBuffer += kevent.text;
        surface.maskedBuffer += surface.kokomi[Math.floor(Math.random() * 6)];
      }
    }

    SequentialAnimation {
      running: surface.unlocking

      PauseAnimation {
        duration: Data.MaterialEasing.emphasizedTime * 1.2
      }

      NumberAnimation {
        duration: Data.MaterialEasing.emphasizedTime * 0.3
        easing.type: Easing.Linear
        from: 1
        property: "opacity"
        target: inputRect
        to: 0
      }
    }

    MouseArea {
      id: rowMarea

      anchors.centerIn: parent
      height: inputRow.height
      hoverEnabled: true
      width: inputRow.width

      RowLayout {
        id: inputRow

        anchors.centerIn: parent
        height: inputRect.height
        spacing: 0

        Item {
          Layout.fillHeight: true
          implicitWidth: this.height
          visible: rowMarea.containsMouse

          Com.Icon {
            anchors.centerIn: parent
            antialiasing: true
            color: (surface.error) ? clr.current.on_error : (surface.unlocking) ? clr.current.on_primary : clr.current.on_surface
            fill: 1
            font.pointSize: 16
            icon: "bedtime"
          }

          Com.MouseArea {
            anchors.fill: parent
            anchors.margins: 4

            onClicked: Data.SessionActions.suspend()
          }
        }

        Item {
          Layout.fillHeight: true
          implicitWidth: this.height

          Com.Icon {
            id: lockIcon

            anchors.centerIn: parent
            antialiasing: true
            color: (surface.error) ? clr.current.on_error : (surface.unlocking) ? clr.current.on_primary : clr.current.on_surface
            fill: pam.active
            font.pointSize: 16
            icon: "lock"

            Behavior on color {
              ColorAnimation {
                duration: 200
              }
            }
            Behavior on rotation {
              NumberAnimation {
                duration: lockRotatetimer.interval
                easing.type: Easing.Linear
              }
            }
          }

          Timer {
            id: lockRotatetimer

            interval: 500
            repeat: true
            running: pam.active
            triggeredOnStart: true

            onRunningChanged: if (lockIcon.rotation < 180) {
              lockIcon.rotation = 360;
            } else {
              lockIcon.rotation = 0;
            }
            onTriggered: lockIcon.rotation += 50
          }
        }

        Item {
          Layout.fillHeight: true
          implicitWidth: this.height
          visible: pam.message.includes("fingerprint")

          Connections {
            function onMessageChanged() {
              if (pam.message.includes("Failed")) {
                pamText.icon = "fingerprint_off";
                reFingerTimer.start();
              }
            }

            target: pam
          }

          Timer {
            id: reFingerTimer

            interval: 300

            onTriggered: pamText.icon = "fingerprint"
          }

          Com.Icon {
            id: pamText

            anchors.centerIn: parent
            color: (surface.error) ? clr.current.on_error : (surface.unlocking) ? clr.current.on_primary : (reFingerTimer.running) ? clr.current.error : clr.current.on_surface
            font.pointSize: 16
            icon: "fingerprint"

            Behavior on color {
              ColorAnimation {
                duration: 200
              }
            }
          }
        }

        Item {
          Layout.fillHeight: true
          implicitWidth: this.height
          visible: rowMarea.containsMouse && !pam.active && !surface.unlocking

          Com.Icon {
            anchors.centerIn: parent
            antialiasing: true
            color: (surface.error) ? clr.current.on_error : (surface.unlocking) ? clr.current.on_primary : clr.current.on_surface
            fill: 1
            font.pointSize: 16
            icon: "login"
          }

          Com.MouseArea {
            anchors.fill: parent
            anchors.margins: 4

            onClicked: pam.start()
          }
        }
      }
    }
  }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: topBar
            Layout.preferredHeight: cfg.bar.barHeight
            Layout.fillWidth: true
            color: cfg.bar.barColor

            Canvas {
                anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
                anchors.leftMargin: cfg.bar.cornerRadius
                anchors.rightMargin: cfg.bar.cornerRadius
                height: 2
                onPaint: {
                    const ctx = getContext("2d")
                    ctx.strokeStyle = "rgba(255, 255, 255, 0.420)"
                    ctx.lineWidth = 1
                    ctx.setLineDash([10, 15])
                    ctx.beginPath()
                    ctx.moveTo(0, 1)
                    ctx.lineTo(width, 1)
                    ctx.stroke()
                }
            }
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Com.CornerThingy {
                z: 10
                width: parent.width
                anchors.fill: parent
                cornerType: "inverted"
                cornerHeight: cfg.bar.cornerRadius
                cornerWidth: cfg.bar.cornerRadius
                color: cfg.bar.barColor
                corners: [0, 1] // 0 is top right, 1 is top left, 2 is bottom left, 3 is bottom right
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

       Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Com.CornerThingy {
                z: 10
                width: parent.width
                anchors.fill: parent
                cornerType: "inverted"
                cornerHeight: cfg.bar.cornerRadius
                cornerWidth: cfg.bar.cornerRadius
                color: cfg.bar.barColor
                corners: [2, 3] // 0 is top right, 1 is top left, 2 is bottom left, 3 is bottom right
            }
        }

        Rectangle {
            id: bottomBar
            Layout.preferredHeight: cfg.bar.barHeight
            Layout.fillWidth: true
            color: cfg.bar.barColor

            Canvas {
                anchors { left: parent.left; right: parent.right; top: parent.top }
                anchors.leftMargin: cfg.bar.cornerRadius
                anchors.rightMargin: cfg.bar.cornerRadius
                height: 2
                onPaint: {
                    const ctx = getContext("2d")
                    ctx.strokeStyle = "rgba(255, 255, 255, 0.420)"
                    ctx.lineWidth = 1
                    ctx.setLineDash([10, 15])
                    ctx.beginPath()
                    ctx.moveTo(0, 1)
                    ctx.lineTo(width, 1)
                    ctx.stroke()
                }
            }
        }
    }


  PamContext {
    id: pam

    onCompleted: res => {
      if (res === PamResult.Success) {
        surface.unlocking = true;
        surface.inputBuffer = "";
        surface.maskedBuffer = "";
        return;
      }

      surface.error = true;
      revertColors.running = true;
    }
    onResponseRequiredChanged: {
      if (!responseRequired)
        return;

      respond(surface.inputBuffer);
      surface.inputBuffer = "";
      surface.maskedBuffer = "";
    }
  }

  Timer {
    id: revertColors

    interval: 2000

    onTriggered: surface.error = false
  }

  Timer {
    id: unlockTimer

    interval: Data.MaterialEasing.emphasizedTime * 1.5
    running: surface.unlocking

    onTriggered: surface.lock.locked = false
  }
}
