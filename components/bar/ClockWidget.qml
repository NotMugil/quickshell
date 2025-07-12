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
  }

  MouseArea {
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      console.log("Clock clicked!")
    }
  }
}