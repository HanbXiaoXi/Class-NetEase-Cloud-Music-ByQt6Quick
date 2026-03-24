import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import "qrc:/Basic"
Item {
    id:messageDrawId
    anchors.fill: parent
    property real drawTopMargin: 100
    property real drawHeight :600
    signal drawerClose(bool visible) //用于关闭时打开message的mouseArea
    function open(){
        if(!drawerId.opened){
            drawerId.open()
        }else{
            drawerId.close()
        }
    }
    Drawer{
        id: drawerId
        // z: 100
        width: 300
        height: messageDrawId.drawHeight
        topMargin:messageDrawId.drawTopMargin

        background: Rectangle{
            anchors.fill: parent
            color: BasicConfig.boxBorderColor
            radius: 10
        }

        edge: Qt.RightEdge
        interactive:true
        dragMargin:0 //防止滑动
        closePolicy: Popup.CloseOnReleaseOutside
        modal: false
        onOpenedChanged:  {
            if(opened){
                messageDrawId.drawerClose(false)

            }else{
                messageDrawId.drawerClose(true)
                focus = false
            }
        }
    }
}


