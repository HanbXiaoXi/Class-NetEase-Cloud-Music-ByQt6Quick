import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "./selected"
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
            // 滑动条 轮播图
            Item{
                id:carouselId
                anchors.left: parent.left
                anchors.right:parent.right
                height: 280
                MouseArea{
                    anchors.fill: parent
                    // anchors.left: parent.left
                    // anchors.leftMargin: 20
                    // anchors.right:parent.right
                    // anchors.rightMargin: 20
                    // anchors.top: parent.top
                    // anchors.bottom: parent.bottom
                    hoverEnabled: true
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
                //左箭头
                Image {
                    id: leftIniImg
                    visible: false
                    width: 20
                    height: 40
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    opacity: 0.4
                    source: "qrc:/img/icon/left.png"
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.opacity += 0.3
                        }
                        onExited: {
                            parent.opacity -= 0.3
                        }
                        onClicked: {
                            startAni.triggered()
                            startAni.restart() //重新开始计时
                        }
                    }
                }
                //右箭头
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
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.opacity += 0.3
                        }
                        onExited: {
                            parent.opacity -= 0.3
                        }
                        onClicked: {
                            carouselModel.insert(0,carouselModel.get(4))// 最后一个图片置入首部
                            carouselModel.remove(5)
                            startAni.restart() //重新开始计时
                        }
                    }
                }


                Item {
                    clip: true
                    width:flick.width * 0.9
                    height:parent.height-30
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    ListModel{
                        id:carouselModel
                        ListElement{src:"qrc:/img/img/selects/171053.png"}
                        ListElement{src:"qrc:/img/img/selects/171059.png"}
                        ListElement{src:"qrc:/img/img/selects/171104.png"}
                        ListElement{src:"qrc:/img/img/selects/171110.png"}
                        ListElement{src:"qrc:/img/img/selects/171118.png"}
                    }
                    ListView{
                        id:carouselRow
                        spacing: 30
                        orientation: ListView.Horizontal
                        anchors.right: parent.right
                        width: parent.width
                        height:parent.height
                        model:carouselModel
                        //remove移动动画
                        remove:Transition {
                            NumberAnimation{
                                property:"x"
                                from: 0
                                to:-500
                                duration: 200
                            }
                        }
                        removeDisplaced:Transition {
                            NumberAnimation{
                                property:"x"
                                duration: 200
                            }
                        }
                        delegate:Rectangle{
                            width: 460
                            height: 250
                            radius:10
                            clip:true
                            color: "transparent"
                            Image{
                                id:carouseImg
                                anchors.fill: parent
                                source:src
                            }
                        }
                    }
                    Timer{ //触发滑动条滚动
                        id:startAni
                        repeat: true
                        running:true
                        interval: 4000
                        onTriggered: {
                            carouselModel.append(carouselModel.get(0)) //将第一个图片移动到尾部
                            carouselModel.remove(0)
                        }
                    }
                }
            }
            // 官方歌单
            Item {
                anchors.left: parent.left
                anchors.right: parent.right
                height: titleLabel.height +singerRect.height+40
                Label{
                    id: titleLabel
                    text:"官方歌单>"
                    font.bold: true
                    color: BasicConfig.firstFontColor
                    font.family:BasicConfig.fontFamily
                    font.pixelSize: 20
                    anchors.left: parent.left
                    anchors.top: parent.top
                    // anchors.topMargin: -20
                    anchors.leftMargin: 36
                }
                Item{
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: titleLabel.bottom
                    anchors.topMargin: 10
                    height:parent.height
                    //左箭头
                    Image {
                        id:leftListImg
                        visible: false
                        width: 20
                        height: 40
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: 0.4
                        source: "qrc:/img/icon/left.png"
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.opacity += 0.3
                            }
                            onExited: {
                                parent.opacity -= 0.3
                            }
                            onClicked: {
                            }
                        }
                    }
                    //右箭头
                    Image {
                        id:rightListImg
                        width: 20
                        height: 40
                        mirror: true
                        visible: false
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        source: "qrc:/img/icon/left.png"
                        opacity: 0.4
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.opacity += 0.3
                            }
                            onExited: {
                                parent.opacity -= 0.3
                            }
                            onClicked: {
                            }
                        }
                    }
                    Item {
                        id:singerRect
                        anchors.left: leftListImg.right
                        anchors.right: rightListImg.left
                        height: ((width-100)/5)*1.25
                        clip: true
                        //歌单图片
                        Row{
                            id:singListRow
                            width:parent.width
                            height:parent.height
                            spacing: 20
                            Repeater{
                                model: ListModel{
                                    id:songListModel
                                    ListElement{src:"qrc:/img/img/selects/4301.png"}
                                    ListElement{src:"qrc:/img/img/selects/4306.png"}
                                    ListElement{src:"qrc:/img/img/selects/4312.png"}
                                    ListElement{src:"qrc:/img/img/selects/4316.png"}
                                    ListElement{src:"qrc:/img/img/selects/4320.png"}
                                }
                                delegate: Rectangle{
                                    width:(parent.width-100)/5
                                    height:width*1.25
                                    radius: 10
                                    Image {
                                        anchors.fill: parent
                                        id:singListImg
                                        source: src
                                    }
                                }
                            }
                        }
                    }
                }
            }
            //最新音乐的数据
            ListModel{
                id:songsModel
                ListElement{title:"故意没接";artist:"Double SR";src:"qrc:/img/img/selects/newSongs/200503.png"}
                ListElement{title:"十里";artist:"加木";src:"qrc:/img/img/selects/newSongs/200509.png"}
                ListElement{title:"锁";artist:"张子墨";src:"qrc:/img/img/selects/newSongs/200514.png"}
                ListElement{title:"山歌王";artist:"功夫胖";src:"qrc:/img/img/selects/newSongs/200521.png"}
                ListElement{title:"春";artist:"陈文非";src:"qrc:/img/img/selects/newSongs/200526.png"}
                ListElement{title:"ブレインロット";artist:"京东真中";src:"qrc:/img/img/selects/newSongs/200529.png"}
                ListElement{title:"无线逼近";artist:"所长sama";src:"qrc:/img/img/selects/newSongs/200541.png"}
                ListElement{title:"我说你呀";artist:"李雨霏_晚饭";src:"qrc:/img/img/selects/newSongs/200545.png"}
                ListElement{title:"痴人说梦";artist:"HOYO-Mix";src:"qrc:/img/img/selects/newSongs/200550.png"}
            }
            //最新音乐
            SingsGrid{
                anchors.left: parent.left
                anchors.right: parent.right
                title:"最新音乐>"
                model:songsModel
            }
        }
    }


}

