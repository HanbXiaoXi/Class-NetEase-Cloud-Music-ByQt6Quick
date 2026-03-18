import QtQuick 2.15
import QtQuick.Controls
import "qrc:/Basic"

Popup{
    id:mainId
    anchors.centerIn: parent
    width: 466
    height: 638
    clip:true
    closePolicy: Popup.NoAutoClose
    onOpened:{
        showAnimation.restart()
    }
    background: Rectangle{
        anchors.fill: parent
        color:BasicConfig.loginColor
        radius:10
        Image{
            width: 20
            height:width
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 15
            source:"qrc:/img/icon/close.png"
            opacity:0.4
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                    parent.opacity += 0.4
                }
                onExited:{
                    cursorShape =Qt.ArrowCursor
                    parent.opacity -= 0.4
                }
                onClicked: {
                    mainId.close()
                    parent.opacity = 0.4
                }
            }
        }
        Label{
            id:loginText
            text:"扫码登陆"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            color:BasicConfig.secondFontColor
            font.pixelSize: 30
        }
        Image {
            id:pic
            x:50
            y:170
            width: 200
            height:width*1.5
            source: "qrc:/img/img/login/loginTest.png"

        }
        Image {
            id:qrcode
            x:350
            y:270
            width: 200
            height:width
            source:"qrc:/img/img/login/QR.png"
        }
        //QR码下面超文本链接
        // unfinished
        Label{
            width : 100
            wrapMode:Text.WordWrap
            textFormat:Qt.RichText
            text:""
            visible: qrcode.width === 200 || qrcode.width === 300
            anchors.top: qrcode.bottom
            anchors.topMargin: showAnimation.showFlag ? 20 :30
            anchors.horizontalCenter: qrcode.horizontalCenter
        }

        //动画变换区域
        MouseArea{
            anchors.top: parent.top
            anchors.topMargin: 150
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 175
            hoverEnabled: true
            onEntered: {
                showAnimation.showFlag = false
                // console.log("showFlag Changed")
            }
            onExited: {
                showAnimation.showFlag = true
                // console.log("showFlag Changed")
            }
        }
        //动画变换
        ParallelAnimation{
            id:showAnimation
            property bool showFlag: true
            NumberAnimation{
                target: pic
                property: "x"
                duration: 300
                from:showAnimation.showFlag ? 50 : 133
                to: showAnimation.showFlag? 133: 50
            }
            NumberAnimation{
                target: pic
                property: "y"
                duration: 300
                from:showAnimation.showFlag ? 170 : 150
                to: showAnimation.showFlag? 150:170
            }
            NumberAnimation{
                target: pic
                property: "opacity"
                duration: 300
                from:showAnimation.showFlag ? 1 : 0
                to: showAnimation.showFlag? 0 : 1
            }
            NumberAnimation{
                target: qrcode
                property: "y"
                duration: 300
                from:showAnimation.showFlag ? 225 : 150
                to: showAnimation.showFlag? 150 :   225
            }
            NumberAnimation{
                target: qrcode
                property: "x"
                duration: 300
                from:showAnimation.showFlag ? 250 : 83
                to: showAnimation.showFlag? 83 :   250
            }
            NumberAnimation{
                target: qrcode
                property: "width"
                duration: 300
                from:showAnimation.showFlag ? 200 : 300
                to: showAnimation.showFlag? 300 :  200
            }
            onShowFlagChanged: {
                restart()
            }
        }
        // 其他方法登录
        Label{
            text:"其他方法登录"
            color: BasicConfig.popupBackgroudColor
            anchors.bottom:parent.bottom
            anchors.bottomMargin: 80
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
            MouseArea{
                anchors.fill:parent
                hoverEnabled: true
                onEntered: {
                    parent.color = BasicConfig.firstFontColor
                    parent.font.underline = true
                }
                onExited: {
                    parent.color = BasicConfig.secondFontColor
                    parent.font.underline = false
                }
                onClicked: {
                    loginPopup.close()
                    loginPopupByOthers.open()
                }
            }
        }
    }
}
