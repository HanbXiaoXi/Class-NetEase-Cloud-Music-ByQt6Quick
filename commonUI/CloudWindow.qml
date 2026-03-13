import QtQuick
import QtQuick.Controls
Window {
    id: window
    width: 1317
    height: 933
    visible: true
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint |Qt.Window |Qt.WindowSystemMenuHint |
           Qt.WindowMaximizeButtonHint |Qt.WindowMinimizeButtonHint
    //窗口拖动 可能会覆盖前面的功能
    MouseArea{
        anchors.fill: parent
        property point mousePos:"0,0"
        onPressed: (mouse)=>{
            mousePos = Qt.point(mouse.x,mouse.y)
        }
        onPositionChanged: function(mouse){
            let delta = Qt.point(mouse.x -mousePos.x,mouse.y -mousePos.y)
            window.x += delta.x
            window.y += delta.y

        }
    }

}
