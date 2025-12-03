import QtQuick

import qs.components as Com
import qs.data as Data
import qs.services

Rectangle {
  property var cfg: Data.Config.data.settings
  property var clr: Data.Colors
  id: clockroot
  width: clock.implicitWidth + 10
  height: cfg.bar.barHeight * 0.65
  color: cfg.bar.buttonBg == true ? clr.current.buttonBg : "transparent"
  radius: cfg.bar.buttonRadius

  Com.StyledText {
    anchors.centerIn: parent
    id: clock
    fontSize: cfg.bar.barHeight * 0.35
    text: Time.datetime
  }
}
