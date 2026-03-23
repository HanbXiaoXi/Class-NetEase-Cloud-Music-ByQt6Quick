import QtQuick
import QtQuick.Controls
import "qrc:/leftPage"
import "qrc:/rightPage"
import "qrc:/playMusic"
import "qrc:/commonUI"
import "qrc:/loginPopup"
import "qrc:/Basic"

CloudWindow{
    id: window
    width: 1317
    height: 933
    Connections{
        target: BasicConfig
        function onOpenLoginPopup(){  //打开登录界面
            loginPopup.open()
        }
    }
    RightPage{
        id:rightRect
        anchors.top: parent.top
        anchors.left: leftRect.right
        anchors.right: parent.right
        anchors.bottom: bottomRect.top
        messageDrawHeight:parent.height - bottomRect.height//消息栏高度
        color:BasicConfig.rightPageColor
    }
    LeftPage{
        id:leftRect
        width:200
        anchors.top: parent.top
        anchors.bottom: bottomRect.top
        color:BasicConfig.leftPageColor
    }
    PlayMusic{
        id:bottomRect
        height:100
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
    LoginPopup{
        id:loginPopup
    }
    LoginPopupByOthers{
        id:loginPopupByOthers
    }

    Component.onCompleted: {

    }
}
