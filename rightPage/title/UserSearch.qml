import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Basic
Item {
    id:uerSearch
    anchors.left: parent.left
    anchors.leftMargin: 40
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    property real opac: 0.5
    Row{
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing :8
        Rectangle{
            id:backForward
            width: 27
            height: 34
            color:"transparent"
            border.width: 1
            border.color: "#2b2b31"
            radius: 8
            Image{
                anchors.centerIn: parent
                width:22
                height:width
                source:"qrc:/img/icon/left.png"
                opacity:uerSearch.opac +0.3
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                property color transColor:"#241c26"
                onEntered:{
                    parent.color = transColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: {

                }
            }
        }

        //输入框
        TextField{
            id:searchTextField
            height:backForward.height
            width:250
            color: "white"
            font.pixelSize: 14
            font.wordSpacing:0
            leftPadding: 40                 //左边空出
            placeholderText:"请输入歌曲"
            background: Rectangle{
                anchors.fill:parent
                color:"transparent"
                border.color: "#36262f"
                border.width: 1
                radius: 8
                Image{
                    id:searchIcon
                    width:18
                    height:width
                    source:"qrc:/img/icon/search.png"
                    anchors.verticalCenter:parent.verticalCenter
                    anchors.left:parent.left
                    anchors.leftMargin: 16
                    opacity:uerSearch.opac
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:{
                            parent.opacity = uerSearch.opac + 0.3
                        }
                        onExited: {
                            parent.opacity = uerSearch.opac
                        }
                        onClicked: {
                        }
                    }
                }

            }


        }
        Rectangle{
            id:soundHound
            height:backForward.height
            width:height
            color:"transparent"
            border.color: "#36262f"
            border.width: 1
            radius:8
            Image {
                width:16
                height:width
                anchors.centerIn: parent
                source: "qrc:/img/icon/microphone.png"
                opacity:uerSearch.opac + 0.3
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                property color transColor:"#241c26"
                onEntered:{
                    parent.color = transColor
                }
                onExited: {
                    parent.color = "transparent"
                }
                onClicked: {

                }
            }
        }
    }


}
