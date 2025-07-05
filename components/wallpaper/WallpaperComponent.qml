import QtQuick
import Quickshell
import QtMultimedia
import Quickshell.Services.UPower 

import "root:/"

Rectangle {
    anchors.fill: parent
    color: "black"

    Loader {
        anchors.fill: parent
        sourceComponent: getWallpaperState()

        Component {
            id: video_wallpaper
            Video {      
                id: wallpaper
                anchors.fill: parent
                autoPlay: true
                muted: true
                loops: MediaPlayer.Infinite
                source: Config.wallpaperPath
                fillMode : VideoOutput.PreserveAspectCrop 
            }
        }

        Component {
            id: image_wallpaper
            Video {      
                id: wallpaper
                anchors.fill: parent
                autoPlay: false
                muted: true
                loops: MediaPlayer.Infinite
                source: Config.wallpaperPath
                fillMode : VideoOutput.PreserveAspectCrop 
                Component.onCompleted: {
                wallpaper.play()
                wallpaper.pause()
                }
            }
        }

        function getWallpaperState(){
            var powerprofile = PowerProfiles.profile
            // console.log("Current power profile:", powerprofile)
            if (powerprofile == "0" ) {
                return image_wallpaper
            }
            else {
                return video_wallpaper
            }
        }
    }
}