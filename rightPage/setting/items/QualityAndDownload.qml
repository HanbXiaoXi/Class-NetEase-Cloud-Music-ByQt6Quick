import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"
import QtQuick.Dialogs

Item{
    anchors.left: parent.left
    anchors.right: parent.right
    height: cutLine.y -itemTitleLabel.y
    Label{
        id:itemTitleLabel
        text:"音质与下载"
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: parent.left
        color:BasicConfig.firstFontColor
    }
    Column{
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        id :selects
        spacing: 20
        //下载目录
        Column{
            spacing :10
            Label{
                text:"下载目录"
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                Label{
                    text:"(默认将文件下载在该文件夹中)"
                    font.pixelSize: 14
                    font.bold: true
                    font.family: BasicConfig.fontFamily
                    anchors.left: parent.right
                    anchors.leftMargin: 10
                    color:BasicConfig.secondFontColor
                }
            }
            Label{
                id:downloadPath
                text:  "/"   //下载路径
                width: implicitWidth < 300 ? implicitWidth :300
                elide: Text.ElideLeft
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                Rectangle{
                    id:pathBottom
                    width: 80
                    height: 26
                    y:-5
                    radius: 15
                    anchors.left:parent.right
                    anchors.leftMargin: 20  //距离路径宽度
                    color:BasicConfig.rightPageColor
                    border.color: BasicConfig.windowBoderColor
                    Label{
                        text:"更改目录"
                        font.pixelSize: 14
                        font.family: BasicConfig.fontFamily
                        anchors.centerIn: parent
                        color: BasicConfig.firstFontColor
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                pathBottom.color = BasicConfig.boxBorderColor
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                pathBottom.color = BasicConfig.rightPageColor
                                cursorShape = Qt.ArrowCursor
                            }
                            onClicked: {
                                downloadPathDialog.open()
                            }
                        }
                    }
                }
            }
            FolderDialog{
                id:downloadPathDialog
                onAccepted: {
                    let s = String(currentFolder)
                    // console.log(s)
                    downloadPath.text =s.slice(8,) //截取
                }
            }
        }
        Column{
            spacing :10
            Label{
                text:"缓存目录"
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
            Label{
                id:cachePath
                text:  "/"   //路径
                width: implicitWidth < 300 ? implicitWidth :300
                elide: Text.ElideLeft
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                Rectangle{
                    id:cacheBottom
                    width: 80
                    height: 26
                    y:-5
                    radius: 15
                    anchors.left:parent.right
                    anchors.leftMargin: 20  //距离路径宽度
                    color:BasicConfig.rightPageColor
                    border.color: BasicConfig.windowBoderColor
                    Label{
                        text:"更改目录"
                        font.pixelSize: 14
                        font.family: BasicConfig.fontFamily
                        anchors.centerIn: parent
                        color: BasicConfig.firstFontColor
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                cacheBottom.color = BasicConfig.boxBorderColor
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                cacheBottom.color = BasicConfig.rightPageColor
                                cursorShape = Qt.ArrowCursor
                            }
                            onClicked: {
                                cachePathDialog.open()
                            }
                        }
                    }
                }
            }
            FolderDialog{
                id:cachePathDialog
                onAccepted: {
                    let s = String(currentFolder)
                    // console.log(s)
                    cachePath.text =s.slice(8,) //截取
                }
            }

        }
        //缓存大小
        Row{
            spacing:10
            Label{
                text:"缓存最大占用"
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
            Slider{
                id:memorySlider
                value:10
                from:10
                to:50
                stepSize:0.5
                width:300
                height:14
            }
            Label{
                text: memorySlider.value.toFixed(1) +"G" // real.toFixed(n)精度保留n位
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                color: BasicConfig.firstFontColor
            }
            Rectangle{
                id:cacheSizeBottom
                width: 80
                height: 26
                y:-5
                radius: 15
                color:BasicConfig.rightPageColor
                border.color: BasicConfig.windowBoderColor
                Label{
                    text:"清除缓存"
                    font.pixelSize: 14
                    font.family: BasicConfig.fontFamily
                    anchors.centerIn: parent
                    color: BasicConfig.firstFontColor
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            SizeBottom.color = BasicConfig.boxBorderColor
                            cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            SizeBottom.color = BasicConfig.rightPageColor
                            cursorShape = Qt.ArrowCursor
                        }
                        onClicked: {
                            //缓存删除
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

}


