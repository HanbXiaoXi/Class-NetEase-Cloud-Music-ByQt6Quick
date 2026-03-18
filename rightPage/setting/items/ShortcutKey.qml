import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"

Item{
    anchors.left: parent.left
    anchors.right: parent.right
    height: cutLine.y -itemTitleLabel.y
    Label{
        id:itemTitleLabel
        text:"快捷键"
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: parent.left
        color:BasicConfig.firstFontColor
    }
    Label{
        text:"功能说明"
        font.pixelSize: 14
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        color:BasicConfig.firstFontColor
    }
    Label{
        text:"快捷键"
        font.pixelSize: 14
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 320
        color:BasicConfig.firstFontColor
    }
    Label{
        text:"全局快捷键"
        font.pixelSize: 14
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 500
        color:BasicConfig.firstFontColor

    }

    Column{
        id:selects
        height: implicitHeight
        anchors.top: itemTitleLabel.bottom
        anchors.topMargin: 20
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        anchors.right: parent.right
        spacing:20
        Repeater{
            Item{
                anchors.left:parent.left
                anchors.right: parent.right
                height: 50
                Label{
                    anchors.left: parent.left
                    font.pixelSize: 14
                    color:BasicConfig.firstFontColor
                }
            }
        }
    }
    CustomCutLine{//下划线
        id: cutLine
        anchors.top: selects.bottom
        anchors.topMargin: 20
    }

}


