import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.Data as Data
import qs.Components as Com
import qs.Widgets as Widget

Scope {
    Variants {
    model: Quickshell.screens

    PanelWindow {
        id: layerRoot
        screen: modelData

        implicitWidth: modelData.width
        implicitHeight: modelData.height

        required property ShellScreen modelData
        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        WlrLayershell.layer: WlrLayer.Background
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        focusable: false


        Widget.Wallpaper {
            id: wallpaper

            anchors.fill: parent
            source: ""

            Component.onCompleted: {
            source = Data.Config.data.wallSrc;

            Data.Config.data.wallSrcChanged.connect(() => {
                if (walAnimation.running) {
                walAnimation.complete();
                }
                animatingWal.source = Data.Config.data.wallSrc;
            });
            animatingWal.statusChanged.connect(() => {
                if (animatingWal.status == Image.Ready) {
                walAnimation.start();
                }
            });

            walAnimation.finished.connect(() => {
                wallpaper.source = animatingWal.source;
                animatingWal.source = "";
                animatinRect.width = 0;
            });
            }
        }

        Rectangle {
            id: animatinRect

            anchors.right: parent.right
            clip: true
            color: "transparent"
            height: layerRoot.screen.height
            width: 0

            NumberAnimation {
            id: walAnimation

            duration: Data.MaterialEasing.emphasizedTime * 5
            easing.bezierCurve: Data.MaterialEasing.emphasized
            from: 0
            property: "width"
            target: animatinRect
            to: Math.max(layerRoot.screen.width)
            }

            Widget.Wallpaper {
            id: animatingWal

            anchors.right: parent.right
            height: layerRoot.height
            source: ""
            width: layerRoot.width
            }
        }
        }
    }
}
