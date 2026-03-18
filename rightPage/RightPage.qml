import QtQuick 2.15
import QtQuick.Controls
import "qrc:/Basic"
import "qrc:/rightPage/title"
import "qrc:/rightPage/messageDraw"
import "qrc:/rightPage/stackPages"
import "qrc:/rightPage/setting"
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

    //邮箱Popup
    MessageDraw{
        id:messageDraw
        anchors.fill: parent
        height:parent.height - taskBar.height
        drawTopMargin:taskBar.height +20
        drawHeight:rightRect.messageDrawHeight - drawTopMargin
    }
    //位于中间 有最大值
    StackView{
        id:mainStackView
        anchors.top:taskBar.bottom
        width: parent.width < 1800 ? parent.width :1800
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        clip: true
        initialItem: "qrc:/rightPage/stackPages/CloudMusicCherryPick.qml"
    }


    Connections{   //连接窗口打开关闭
        target: minAndMax
        function onMessageOpen(){
            messageDraw.open()
        }

    }
    Connections{ // 在邮箱打开时让邮箱图标的MouseArea无效
        target: messageDraw
        function onDrawerClose(visible){
            minAndMax.messageAreaVisible = visible
        }
    }

}
