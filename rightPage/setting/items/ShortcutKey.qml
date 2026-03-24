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
    // 输入映射区
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
            model:shortCutModel
            delegate: mappingItem
        }
        //启用全局快捷键
        CustomCheckBox{
            id:enableGlobalShortcut
            firstText:"启用全局快捷键"
            selected:true
            secondText:"(云音乐在后台时也能响应)"
        }
        //使用系统媒体快捷键
        CustomCheckBox{
            id:enablehSystemMediaShortcut
            firstText:"使用系统媒体快捷键"
            selected:true
            secondText:"播放/暂停、上一首、下一首、停止"
            Rectangle{
                id:loginBottom
                width: 80
                height: 30
                y:-5
                radius: 15
                anchors.left:parent.right
                anchors.leftMargin: 250
                color:BasicConfig.rightPageColor
                border.color: BasicConfig.windowBoderColor
                Label{
                    text:"恢复默认"
                    font.pixelSize: 14
                    font.family: BasicConfig.fontFamily
                    anchors.centerIn: parent
                    color: BasicConfig.firstFontColor
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            loginBottom.color = BasicConfig.boxBorderColor
                            cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            loginBottom.color = BasicConfig.rightPageColor
                            cursorShape = Qt.ArrowCursor
                        }
                        onClicked: {
                            enableGlobalShortcut.selected = true
                            enablehSystemMediaShortcut.selected = true
                            shortCutModel.clear()
                            shortCutModel.append({description:"播放/暂停",shotcut: "Ctrl + P",globalShotcut:"Ctrl + Alt + P"})
                            shortCutModel.append({description: "上一首",shotcut: "Ctrl + Left",globalShotcut: "Ctrl + Alt + Left"})
                            shortCutModel.append({description: "下一首",shotcut:"Ctrl + Right",globalShotcut: "Ctrl + Alt + Right"})
                            shortCutModel.append({description:"音量加",shotcut: "Ctrl + Up",globalShotcut:"Ctrl + Alt + Up"})
                            shortCutModel.append({description:"音量减",shotcut: "Ctrl + Down",globalShotcut: "Ctrl + Alt + Down"})
                            shortCutModel.append({description:"mini/完整模式",shotcut:"Ctrl + M",globalShotcut:"Ctrl + Alt + M"})
                            shortCutModel.append({description:"喜欢歌曲",shotcut: "Ctrl + L",globalShotcut:"Ctrl + Alt + L"})
                            shortCutModel.append({description:"打开/关闭歌词",shotcut: "Ctrl + D",globalShotcut:"Ctrl + Alt + D"})
                            shortCutModel.append({description:"翻译当前歌词",shotcut: "Ctrl + T",globalShotcut:"空"})
                        }
                    }
                }
            }
        }

    }
    CustomCutLine{//下划线
        id: cutLine
        anchors.top: selects.bottom
        anchors.topMargin: 20
    }
    //快捷键model
    ListModel{
        id:shortCutModel
        ListElement{description:"播放/暂停";shotcut: "Ctrl + P";globalShotcut:"Ctrl + Alt + P"}
        ListElement{description: "上一首";shotcut: "Ctrl + Left";globalShotcut: "Ctrl + Alt + Left"}
        ListElement{description: "下一首";shotcut:"Ctrl + Right";globalShotcut: "Ctrl + Alt + Right"}
        ListElement{description:"音量加";shotcut: "Ctrl + Up";globalShotcut:"Ctrl + Alt + Up"}
        ListElement{description:"音量减";shotcut: "Ctrl + Down";globalShotcut: "Ctrl + Alt + Down"}
        ListElement{description:"mini/完整模式";shotcut:"Ctrl + M";globalShotcut:"Ctrl + Alt + M"}
        ListElement{description:"喜欢歌曲";shotcut: "Ctrl + L";globalShotcut:"Ctrl + Alt + L"}
        ListElement{description:"打开/关闭歌词";shotcut: "Ctrl + D";globalShotcut:"Ctrl + Alt + D"}
        ListElement{description:"翻译当前歌词";shotcut: "Ctrl + T";globalShotcut:"空"}
    }
    //快捷键 delegate
    Component{
        id:mappingItem
        Item{
            anchors.left:parent.left
            anchors.right: parent.right
            height: 50
            Label{
                id:functionId
                anchors.left: parent.left
                text:description
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
            CustomInputMapping{
                id:shotCutTextField
                text:shotcut
                height:30
                width:180
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:functionId.left
                anchors.leftMargin: 160
            }
            CustomInputMapping{
                id:shotCutGobalTextField
                text:globalShotcut
                height:30
                width:180
                anchors.verticalCenter: parent.verticalCenter
                anchors.left:shotCutTextField.left
                anchors.leftMargin: 200


            }
        }
    }
}


