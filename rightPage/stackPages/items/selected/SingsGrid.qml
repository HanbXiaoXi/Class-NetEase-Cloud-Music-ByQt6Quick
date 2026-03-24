import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"

// 模型格式：
/*
title:歌曲名
artist：歌手名
src:图片url
*/
Item{
    height: songsLabel.height +songsGrid.height
    id:gridId
    property alias title: songsLabel.text
    property alias model:songsRep.model

    Label{
        id: songsLabel
        font.bold: true
        color: BasicConfig.firstFontColor
        font.family:BasicConfig.fontFamily
        font.pixelSize: 20
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -20
        anchors.leftMargin: 36
    }
    Grid{
        id:songsGrid
        anchors.top: songsLabel.bottom
        width:parent.width -44
        anchors.horizontalCenter: parent.horizontalCenter
        height:300 + 20*2
        spacing: 20
        clip:true //防止后面图片露出
        flow: GridView.FlowTopToBottom
        Repeater{
            anchors.fill: parent
            id:songsRep
            delegate:Rectangle{
                width: parent.width <1200 ? (parent.width-20)/2 :(parent.width-40)/3
                height: 100
                color:"transparent"
                //用于高光所在歌曲块
                Rectangle{
                    id:highLightRect
                    anchors.fill: parent
                    radius: 10
                    color:BasicConfig.boxBorderColor
                    visible: false
                    opacity: 0.3
                }
                Image {
                    id:songImg
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top:parent.top
                    anchors.topMargin: 10
                    width:80
                    height:width
                    source: src
                }
                //歌名
                Label{
                    id:songTitle
                    y:parent.height*0.2
                    anchors.left:songImg.right
                    anchors.leftMargin: 10
                    text:title
                    color: BasicConfig.firstFontColor
                    font.pixelSize: 15
                    font.family:BasicConfig.fontFamily
                }
                //歌曲作者
                Label{
                    id:songArtist
                    anchors.left:songImg.right
                    anchors.leftMargin: 10
                    anchors.top: songTitle.bottom
                    anchors.topMargin: 3
                    text:artist
                    color: BasicConfig.secondFontColor
                    font.pixelSize: 12
                    font.family:BasicConfig.fontFamily
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        highLightRect.visible = true
                        leftImg.visible =true
                        rightImg.visible =true
                    }
                    onExited:{
                        highLightRect.visible = false
                        leftImg.visible =false
                        rightImg.visible =false
                    }
                }
            }
        }
    }
    MouseArea{ //左箭头区域
        anchors.left: parent.left
        width:20
        height: parent.height
        hoverEnabled: true
        onEntered: {
            cursorShape = Qt.PointingHandCursor
            leftImg.opacity += 0.3
            leftImg.visible =true
            rightImg.visible =true
        }
        onExited:{
            cursorShape = Qt.ArrowCursor
            leftImg.opacity -= 0.3
            leftImg.visible =false
            rightImg.visible =false
        }
    }
    MouseArea{ //右箭头区域
        anchors.right: parent.right
        width:20
        height: parent.height
        hoverEnabled: true
        onEntered: {
            cursorShape = Qt.PointingHandCursor
            rightImg.opacity += 0.3
            leftImg.visible =true
            rightImg.visible =true
        }
        onExited:{
            cursorShape = Qt.ArrowCursor
            rightImg.opacity -= 0.3
            leftImg.visible =false
            rightImg.visible =false
        }
    }
    //左箭头
    Image {
        id: leftImg
        visible: false
        width: 20
        height: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        opacity: 0.4
        source: "qrc:/img/icon/left.png"
    }
    //右箭头
    Image {
        id: rightImg
        width: 20
        height: 40
        mirror: true
        visible: false
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/img/icon/left.png"
        opacity: 0.4
    }
}
