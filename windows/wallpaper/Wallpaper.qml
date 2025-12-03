import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import qs.data as Data
import qs.components as Com

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


        WallpaperContent {
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

        Image {
            id: fg
            opacity: 0
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

            Component.onCompleted: {
                walAnimation.finished.connect(function() {
                    fg.opacity = 1;
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

            WallpaperContent {
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
