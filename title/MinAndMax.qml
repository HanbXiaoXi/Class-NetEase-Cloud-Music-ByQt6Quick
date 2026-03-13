import QtQuick 2.15

Item {
    Row{
        id:minAndMax
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: 10
        spacing:30
        property real iconSize: 16
        Image{
            id:miniModeRect
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/minimode.png"
            opacity: 0.3
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.7
                    parent.width = parent.iconSize*1.2
                    console.log("1")
                }
                onExited: {
                    parent.opacity=0.3
                }
            }
        }
        Image{
            id:miniRect
            width:parent.iconSize
            height:width
            anchors.verticalCenter:parent.verticalCenter
            source:"qrc:/img/icon/minimize.png"
            opacity: 0.4
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.7
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=0.4
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
            opacity: 0.5

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.8
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=0.5
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
            opacity: 0.5
            MouseArea{

                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity=0.8
                    parent.width = parent.iconSize*1.2
                }
                onExited: {
                    parent.opacity=0.5
                }
                onClicked: {
                    Qt.quit()
                }
            }
        }
    }
}
