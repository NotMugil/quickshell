import QtQuick

Text {
    id: root
    property alias fontSize: root.font.pixelSize
    property alias fontWeight: root.font.weight
    property alias textColor: root.color
    property alias horizontalAlignment: root.horizontalAlignment
    property alias verticalAlignment: root.verticalAlignment

    font.family: "JetBrainsMono Nerd Font"
    fontSize: 12
    fontWeight: Font.Normal
    textColor: "white"
    horizontalAlignment: Text.AlignLeft
    verticalAlignment: Text.AlignVCenter
    renderType: Text.NativeRendering
}