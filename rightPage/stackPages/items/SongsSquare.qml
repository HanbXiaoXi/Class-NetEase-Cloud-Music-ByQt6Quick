import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
Item {
    Flickable{
        id:flick
        contentHeight:2000
        anchors.fill:parent
        clip: true
        ScrollBar.vertical: ScrollBar{
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: 10
            contentItem: Rectangle{
                color:"#393943"
            }
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
        }
        Column{
            id:contentColumn
            anchors.fill: parent
            anchors.rightMargin: 30
            spacing: 30
            // 滑动条
            Item{
                anchors.left: parent.left
                anchors.right:parent.right
                height: 200
                MouseArea{
                    anchors.left: parent.left
                    anchors.right:parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    hoverEnabled: true
                    // onPressed:mouse=> mouse.accepted = false;
                    // onReleased: mouse=>mouse.accepted = false;
                    // onClicked: mouse=>mouse.accepted = false;
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                        leftIniImg.visible =true
                        rightIniImg.visible =true
                    }
                    onExited:{
                        cursorShape = Qt.ArrowCursor
                        leftIniImg.visible =false
                        rightIniImg.visible =false
                    }
                }
                Image {
                    id: leftIniImg
                    visible: false
                    width: 20
                    height: 40
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: 0.4
                    source: "qrc:/img/icon/left.png"
                    // MouseArea{
                    //     anchors.fill: parent
                    //     hoverEnabled: true
                    //     onEntered: {
                    //         parent.opacity += 0.3
                    //     }
                    //     onExited: {
                    //         parent.opacity -= 0.3
                    //     }
                    // }
                }
                Image {
                    id: rightIniImg
                    width: 20
                    height: 40
                    mirror: true
                    visible: false
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/img/icon/left.png"
                    opacity: 0.4
                    // MouseArea{
                    //     anchors.fill: parent
                    //     hoverEnabled: true
                    //     onEntered: {
                    //         parent.opacity += 0.3
                    //     }
                    //     onExited: {
                    //         parent.opacity -= 0.3
                    //     }
                    // }
                }
            }
        }
    }
}
