import QtQuick 2.15
import QtQuick.Controls
import "qrc:/rightPage/title"
import "qrc:/rightPage/messageDraw"
Rectangle{
    id:rightRect
    property real messageDrawHeight: 700

    Rectangle{ //任务栏
        id:taskBar
        height:60
        anchors.left: parent.left
        anchors.top:  parent.top
        anchors.right:  parent.right
        color:parent.color
        //搜索框 Search bar
        UserSearch{
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        //用户信息
        UserBar{
            id:userBar
            height:parent.height
            anchors.right:parent.right
            anchors.rightMargin: minAndMax.width * 1.25
        }
        //MinAndMax
        MinAndMax{
            id:minAndMax
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 15
        }
    }
    MessageDraw{
        id:messageDraw
        anchors.fill: parent
        height:parent.height - taskBar.height
        drawTopMargin:taskBar.height +20
        drawHeight:rightRect.messageDrawHeight - drawTopMargin
    }



    Connections{   //消息连接
        target: minAndMax
        function onMessageOpen(){
            messageDraw.open()
        }
    }
    Connections{
        target: messageDraw
        function onDrawerClose(visible){
            minAndMax.messageAreaVisible = visible
        }
    }

}
