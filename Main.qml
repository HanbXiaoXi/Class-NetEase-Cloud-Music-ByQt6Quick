import QtQuick
import QtQuick.Controls
import "qrc:/leftPage"
import "qrc:/rightPage"
import "qrc:/playMusic"
import "qrc:/commonUI"

CloudWindow{
    id: window
    width: 1317
    height: 933
    LeftPage{
        id:leftRect
        width:255
        anchors.top: parent.top
        anchors.bottom: bottomRect.top
        color:"#1a1a21"
    }
    RightPage{
        id:rightRect
        anchors.top: parent.top
        anchors.left: leftRect.right
        anchors.right: parent.right
        anchors.bottom: bottomRect.top
        color:"#13131a"
    }
    PlayMusic{
        id:bottomRect
        height:100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}
