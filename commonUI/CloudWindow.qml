import QtQuick
import QtQuick.Controls
Window {
    id: window
    width: 1317
    height: 933
    visible: true
    minimumWidth: 1050
    minimumHeight: 750
    title: qsTr("Hello World")
    flags: Qt.FramelessWindowHint |Qt.Window |Qt.WindowSystemMenuHint |
           Qt.WindowMaximizeButtonHint |Qt.WindowMinimizeButtonHint
    property int bw: 3
    //窗口拖动 可能会覆盖前面的功能

    //大小窗口转换
    function toggleMaximized() {
        if (window.visibility === Window.Maximized) {
            window.showNormal();
        } else {
            window.showMaximized();
        }
    }

    // The mouse area is just for setting the right cursor shape
    MouseArea {
        z:100
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width :20
        hoverEnabled: true

        cursorShape: {
            const p = Qt.point(mouseX, mouseY);
            const b = bw +3 ; // Increase the corner size slightly
            if (window.visibility != Window.Maximized){
                // if (p.x < b && p.y < b) return Qt.SizeFDiagCursor;
                if (p.x >= width - b && p.y >= height - b) return Qt.SizeFDiagCursor;
                // if (p.x < b && p.y >= height - b) return Qt.SizeBDiagCursor;
                if (p.x < width+b && p.x >= width - b) return Qt.SizeHorCursor;
                // if (p.y < b || p.y >= height - b) return Qt.SizeVerCursor;
            }
        }
        acceptedButtons: Qt.NoButton // don't handle actual events
    }

    DragHandler {
        id: resizeHandler
        grabPermissions: TapHandler.TakeOverForbidden
        target: null
        onActiveChanged: if (active) {
                             const p = resizeHandler.centroid.position;
                             const b = bw + 20; // Increase the corner size slightly
                             let e = 0;
                             // if (p.x < b) { e |= Qt.LeftEdge }
                             if (p.x < width+b && p.x >= width - b) { e |= Qt.RightEdge }
                             // if (p.y < b) { e |= Qt.TopEdge }
                             if (p.y >= height - b) { e |= Qt.BottomEdge }
                             if(e)
                             window.startSystemResize(e);
                         }
    }

    ToolBar {
        width: parent.width-2*bw
        height: 60
        x:bw;y:bw
        Item {
            anchors.fill: parent
            TapHandler {
                onTapped: if (tapCount === 2) toggleMaximized()
                gesturePolicy: TapHandler.DragThreshold
            }
            DragHandler {
                grabPermissions: TapHandler.CanTakeOverFromAnything
                onActiveChanged: if (active) { window.startSystemMove(); }
            }
        }
    }

    // MouseArea{
    //     id:dragArea
    //     anchors.top: parent.top
    //     anchors.left: parent.left
    //     anchors.right: parent.right
    //     height: 80
    //     property point mousePos:"0,0"
    //     acceptedButtons: Qt.NoButton
    //     onPressed: (mouse)=>{
    //         mousePos = Qt.point(mouse.x,mouse.y)
    //     }
    //     onPositionChanged: function(mouse){
    //         let delta = Qt.point(mouse.x -mousePos.x,mouse.y -mousePos.y)
    //         window.x += delta.x
    //         window.y += delta.y
    //     }
    // }

}
