import QtQuick
import Qt5Compat.GraphicalEffects
import qs.Data as Data

Text {
  id: root

  property var cfg: Data.Config.data.settings

  property alias fontSize: root.font.pixelSize
  property alias fontWeight: root.font.weight
  property alias textColor: root.color
  property alias horizontalAlignment: root.horizontalAlignment
  property alias verticalAlignment: root.verticalAlignment

  font.family: cfg.lock.fontFamily
  fontSize: 36
  fontWeight: Font.ExtraBold
  textColor: "white"
  horizontalAlignment: Text.AlignLeft
  verticalAlignment: Text.AlignVCenter
  renderType: Text.NativeRendering
}
