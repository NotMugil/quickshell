import QtQuick

import qs.components.common
import qs.config

Rectangle {
  id: clockroot
  anchors.verticalCenter: parent.verticalCenter
  width: clock.implicitWidth + 5
  height: Config.barHeight
  color: "transparent" 

  StyledText {
    id: clock
    text: Time.time
    horizontalAlignment: Text.AlignRight
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
      clock.text = Time.date
    }

    onExited: {
      clock.text = Time.time
    }
  }
}