import QtQuick 2.15
import QtQuick.Controls
import "qrc:/title"
Rectangle{
    id:rightRect
    property alias membershipInfo :membershipInfo.text
    Rectangle{ //任务栏
        height:60
        anchors.left: parent.left
        anchors.top:  parent.top
        anchors.right:  parent.right
        color:parent.color
        Row{
            Item{
                height: 30
                width:140
                anchors.verticalCenter:parent.verticalCenter
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                    Rectangle{
                        id:userIconRect
                        width: 30
                        height:width
                        radius:width/2
                        color:"#2d2d37"
                        Image{
                            width: parent.width
                            height:width
                            anchors.centerIn: parent
                            source:"qrc:/img/icon/userAvatar.png"
                            opacity: 0.4
                        }
                    }
                    Text{
                        id:loadStateText
                        anchors.verticalCenter: parent.verticalCenter
                        text:"未登录"
                        font.pixelSize: 14
                        font.family: "微软雅黑 light"
                        color:"white"
                        opacity: 0.3
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.opacity=0.6
                                parent.width = parent.iconSize*1.2
                            }
                            onExited: {
                                parent.opacity=0.3
                            }
                        }
                    }
                    Item{
                        id:membershipLogo
                        width: userIconRect.width*2
                        height: userIconRect.height
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle{
                            id:vipRect
                            width: parent.width
                            height: 12
                            radius: height/2
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#dadada"
                            opacity: 0.8
                            Label{
                                id:membershipInfo
                                text:"VIP开通"
                                anchors.right: parent.right
                                anchors.rightMargin: parent.radius
                                anchors.verticalCenter: parent.verticalCenter
                                font.pixelSize: parent.radius+2
                                font.bold: true
                                font.family: "微软雅黑 light"
                                color:"white"
                                opacity: 0.8
                            }
                        }
                        Rectangle{
                            id:bgBordRect
                            width: vipRect.height + 6
                            height: width
                            anchors.left: parent.left
                            anchors.leftMargin: parent.radius
                            anchors.verticalCenter: parent.verticalCenter
                            radius: width/2
                            border.width: 1
                            border.color: rightRect.color
                            color: "#dadada"
                            opacity: 0.8
                        }
                    }
                }
            }
        }

        //MinAndMax
        MinAndMax{
            id:minAndMax
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 20
        }

    }
}
