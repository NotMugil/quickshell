import QtQuick

import qs.Components as Com
import qs.Data as Data


Rectangle {
  property var cfg: Data.Config.data.settings

  id: clockroot
  anchors.verticalCenter: parent.verticalCenter
  width: clock.implicitWidth + 5
  height: cfg.bar.barHeight * 0.65
  color: "transparent"

  Com.StyledText {
    anchors.fill: parent
    id: clock
    fontSize: cfg.bar.barHeight * 0.35
    text: Data.Time.time
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true
    onClicked: {
      console.log("Clock clicked!")
    }

    onEntered: {
      clock.text = Data.Time.date
    }

    onExited: {
      clock.text = Data.Time.time
    }
  }
}
