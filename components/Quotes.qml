import QtQuick
import qs.components as Com
import qs.data as Data

Item {
    anchors.centerIn: parent

    property var cfg: Data.Config.data.settings
    property var clr: Data.Colors

    property var quotes: [
        "With freedom, flowers, books, and the moon, who could not be perfectly happy? ― Oscar Wilde",
        "தீதும் நன்றும் பிறர் தர வாரா — Kaniyan Pungundranar",
        "If you find yourself in a hole, the first thing to do is stop diggin'. — John Marston",
        "人の夢に終わりはない",
        "Life is really simple, but we insist on making it complicated. — Confucius",
        "Fortuna audaces iuvat",
        "You can die anytime, but living takes true courage. — Kenshin Himura, Rurouni Kenshin",
        "Anyone can cook, but only the fearless can be great. – Chef Gusteau",
    ]

    property int current: 0

    Com.StyledText {
        id: quote
        width: parent.width * 0.9
        anchors.centerIn: parent
        text: quotes[current]
        color: clr.current.primary_fixed
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        font.italic: true

        Behavior on opacity {
            NumberAnimation {
                duration: 1500
            }
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            parent.children[0].opacity = 0
            Qt.callLater(function() {
                current = (current + 1) % quotes.length
                parent.children[0].opacity = 1
            })
        }
    }
}
