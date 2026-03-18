import QtQuick 2.15

Item {
    id:settingBar
    height: parent.height
    width: minAndMax.width + setAndOthers.width + separator.width
    signal messageOpen()
    property real opac: 0.5
    property alias messageAreaVisible: messageArea.visible
    Row{
        id:setAndOthers
        height: parent.height
        anchors.right: separator.left
        anchors.rightMargin: 10
        spacing:12
        property real iconSize: 18
        Image{
            id:loadStateDown
            width:parent.iconSize*0.8
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/down.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
            }
        }
        Image{
            id:message
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/e-mail.png"
            opacity: settingBar.opac
            MouseArea{
                id:messageArea
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                onClicked: {
                    settingBar.messageOpen()
                }
            }
        }
        // 设置按钮
        Image{
            id:setting
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/setting.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                // 压入设置界面
                onClicked: {
                    mainStackView.push("qrc:/rightPage/setting/UseSetting.qml")
                }
            }
        }
        Image{
            id:skin
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/clothes.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                onClicked: {
                }
            }
        }
    }
    //分隔符
    Rectangle{
        id:separator
        width:1
        height: minAndMax.iconSize
        anchors.verticalCenter:parent.verticalCenter
        anchors.right: minAndMax.left
        anchors.rightMargin: 10
        color: "gray"
        opacity: 0.3
    }


    Row{
        id:minAndMax
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: 20
        spacing:15
        property real iconSize: 16
        Image{
            id:miniModeRect
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/minimode.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
            }
        }
        Image{
            id:miniRect
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/minimize.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                onClicked: {
                    window.showMinimized()
                }
            }
        }
        Image{
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/checkbox-non.png"
            opacity: settingBar.opac

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                onClicked: {
                    if(window.visibility === Window.Maximized){
                        window.showNormal()
                    }else{
                        window.showMaximized()
                    }
                }
            }
        }
        Image{
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/exit.png"
            opacity: settingBar.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                }
                onExited: {
                    parent.opacity=settingBar.opac
                }
                onClicked: {
                    Qt.quit()
                }
            }
        }
    }
}
