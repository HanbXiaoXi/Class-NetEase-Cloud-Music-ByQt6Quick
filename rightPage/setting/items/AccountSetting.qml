import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
Item{

    anchors.left: parent.left
    anchors.right: parent.right
    height: cutLine.y -itemTitleLabel.y
    Label{
        id:itemTitleLabel
        text:"账号"
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: parent.left
        color:BasicConfig.firstFontColor
    }
    Label{
        id:itemDiscriptionLabel
        text:"登录获得音乐同步，320K高音质下载"
        font.pixelSize: 14
        font.family:BasicConfig.fontFamily
        anchors.verticalCenter: itemTitleLabel.verticalCenter
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        color:BasicConfig.secondFontColorLight
    }
    Rectangle{
        id:loginBottom
        width: 100
        height: 20
        radius: 15
        anchors.left: itemDiscriptionLabel.left
        anchors.top: itemDiscriptionLabel.bottom
        anchors.topMargin: 20
        color: BasicConfig.selectorUnderLineColor
        Label{
            text:"立即登录"
            font.pixelSize: 16
            font.family: BasicConfig.fontFamily
            anchors.centerIn: parent
            color: BasicConfig.firstFontColor
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity =0.8
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    parent.opacity = 1
                    cursorShape = Qt.ArrowCursor
                }
            }
        }
    }

    Column{
        id:selects
        height: implicitHeight
        anchors.right: loginBottom.right
        anchors.left: itemDiscriptionLabel.left
        anchors.top: loginBottom.bottom
        anchors.topMargin: 20
        spacing:20
        //开机自启动
        Label{
            id:qucikLogin
            text:"快速登录"
            font.pixelSize: 14
            font.bold: true
            font.family:BasicConfig.fontFamily
            color:BasicConfig.firstFontColor
        }
        CustomCheckBox{
            id:setBootStartup
            firstText:"开启快速登录"
        }

    }
    CustomCutLine{//下划线
        id: cutLine
        anchors.top: selects.bottom
        anchors.topMargin: 40
    }
}

