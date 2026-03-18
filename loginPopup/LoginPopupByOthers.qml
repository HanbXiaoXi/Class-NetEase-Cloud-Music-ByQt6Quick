import QtQuick 2.15
import QtQuick.Controls
import "qrc:/Basic"

Popup {
    id:mainId
    anchors.centerIn: parent
    width: 466
    height: 638
    clip:true
    closePolicy: Popup.NoAutoClose
    background: Rectangle{
        anchors.fill: parent
        color:BasicConfig.loginColor
        radius:10
        //关闭按钮
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
        // QR登录
        Label{
            text:"扫码登录"
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
                    loginPopupByOthers.close()
                    loginPopup.open()

                }
            }
        }
    }
}
