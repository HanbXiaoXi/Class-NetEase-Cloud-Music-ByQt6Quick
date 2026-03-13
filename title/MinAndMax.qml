import QtQuick 2.15

Item {
    id:mainId
    height: parent.height
    width: minAndMax.width + setAndOthers.width + separator.width
    property real opac: 0.5
    Row{
        id:setAndOthers
        height: parent.height
        anchors.right: separator.left
        anchors.rightMargin: 10
        spacing:12
        property real iconSize: 18
        Image{
            id:loadStateDown
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/down.png"
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                    console.log("1")
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
            }
        }
        Image{
            id:message
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/e-mail.png"
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
                onClicked: {
                }
            }
        }
        Image{
            id:setting
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/setting.png"
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
                onClicked: {
                }
            }
        }
        Image{
            id:skin
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/clothes.png"
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
                onClicked: {
                }
            }
        }
    }
    Rectangle{
        id:separator
        width:2
        height: minAndMax.iconSize * 0.8
        anchors.verticalCenter:parent.verticalCenter
        anchors.right: minAndMax.left
        anchors.rightMargin: 15
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
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                    console.log("1")
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
            }
        }
        Image{
            id:miniRect
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/minimize.png"
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
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
            opacity: mainId.opac

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
                onClicked: {
                    if(window.visibility === Window.FullScreen){
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
            opacity: mainId.opac
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.9
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=mainId.opac
                }
                onClicked: {
                    Qt.quit()
                }
            }
        }
    }
}
