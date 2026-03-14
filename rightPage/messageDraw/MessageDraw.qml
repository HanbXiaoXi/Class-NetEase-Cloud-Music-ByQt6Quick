import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
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
        z: 100
        width: 300
        height: messageDrawId.drawHeight
        topMargin:messageDrawId.drawTopMargin
        edge: Qt.RightEdge
        interactive:true
        closePolicy: Popup.CloseOnReleaseOutside
        modal: false
        onOpenedChanged:  {
            if(opened){
                messageDrawId.drawerClose(false)
            }else{
                messageDrawId.drawerClose(true)
            }
        }
    }
}


