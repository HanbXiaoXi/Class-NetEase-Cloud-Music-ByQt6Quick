import QtQuick 2.15
import QtQuick.Controls
import QtQml.XmlListModel
import QtQuick.Controls.Basic
import "qrc:/Basic"
Popup {
    id:searchPop
    width:  780
    height: 600
    closePolicy:Popup.CloseOnPressOutsideParent
    modal: false
    property real opac: 0.5
    property bool historyExpand: false
    property bool searchPopOpened: false
    property bool maybeLikeExpand :false
    clip:true
    background: Rectangle{
        anchors.fill: parent
        radius:10
        color:BasicConfig.popupBackgroudColor
        Flickable{
            anchors.fill:parent
            // Flickable的大小由contentWidth和contentHeight决定
            contentHeight:1000
            clip:true
            // 添加滚动条
            ScrollBar.vertical: ScrollBar{
                anchors.right: parent.right
                width: 10
                contentItem: Rectangle{
                    color:BasicConfig.scrollBarColor
                }
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
            }
            //搜索历史主题以及回收
            //搜索记录
            Item{
                id:histroyItem
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.top: parent.top
                anchors.topMargin: 15
                anchors.leftMargin: 20
                anchors.rightMargin: 10
                visible: singHistroyModel.count ? true : false
                Label{
                    id:searchLabel
                    color:"white"
                    text:"搜索历史"
                    font.pixelSize: 14
                    font.bold: true
                }
                //清空历史记录
                Image{
                    id:removeIcon
                    anchors.left: searchLabel.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: searchLabel.verticalCenter
                    width: 15
                    height: width
                    source: "qrc:/img/icon/trash.png"
                    opacity:opac
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:{
                            parent.opacity = opac + 0.3
                        }
                        onExited: {
                            parent.opacity = opac
                        }
                        onClicked: {
                            historyExpand = false // 展开设置为关闭状态
                            // 实现删除功能
                            for(var i = 0 ; i < singHistroyRep.count ;i++){

                            }

                            singHistroyModel.clear()
                        }
                    }
                }
                Flow{
                    id:singHistoryFlow
                    anchors.top:histroyItem.bottom
                    anchors.topMargin:  30
                    anchors.left: histroyItem.left
                    anchors.right:  histroyItem.right
                    height:60
                    spacing: 10
                    property int count: 0
                    visible: singHistroyModel.count ? true : false
                    Repeater{
                        id:singHistroyRep
                        anchors.fill: parent
                        model:singHistroyModel
                        property int count: 0
                        delegate: Rectangle{
                            width:singhistroyData.width+20
                            height:30
                            border.width: 1
                            border.color: "#45454e"
                            color:  "#393943"
                            radius:12
                            //实现折叠效果
                            visible: historyExpand ||  y < singHistoryFlow.y + 20
                                     ? true :false
                            Label{
                                id:singhistroyData
                                height: 20
                                width: implicitWidth < 100 ? implicitWidth :100
                                text: content
                                font.pixelSize: 13
                                anchors.centerIn: parent
                                color:"#ddd"
                                elide: Text.ElideRight
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    singhistroyData.color = "white"
                                    parent.color = "#41414C"
                                    cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    singhistroyData.color = "#ddd"
                                    parent.color = "#393943"
                                    cursorShape = Qt.ArrowCursor
                                }
                            }
                        }
                    }
                    Rectangle{
                        id:histroySearchExhibition
                        width:30
                        height:width
                        border.width: 1
                        border.color: "transparent"
                        color: "transparent"
                        radius:12
                        // visible: singHistroyRep.count &
                        //          (!singHistroyRep.itemAt(singHistroyRep.count-1).visible | singHistroyRep.itemAt(singHistroyRep.count-1) > singHistoryFlow.y)
                        //         ? true : false
                        Image {
                            anchors.centerIn: parent
                            width: parent.width - 15
                            height:width
                            id: collapse
                            source: "qrc:/img/icon/down.png"
                            opacity: opac
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.color = "#41414C"
                                parent.border.color="#45454e"
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                parent.color = "transparent"
                                cursorShape = Qt.ArrowCursor
                                parent.border.color= "transparent"

                            }
                            onClicked: {
                                if(historyExpand){
                                    collapse.source= "qrc:/img/icon/down.png"
                                    historyExpand = false
                                }else{
                                    collapse.source= "qrc:/img/icon/up.png"
                                    historyExpand = true
                                }

                            }
                        }
                    }
                }
            }

            //猜你喜欢
            Item{
                id:maybeLikeItem
                anchors.left: parent.left
                anchors.right:parent.right
                y : histroySearchExhibition.visible ? histroySearchExhibition.y +histroySearchExhibition.height+60
                                                    : 30
                anchors.leftMargin: 20
                anchors.rightMargin: 10
                Label{
                    id:maybeLike
                    color:"white"
                    text:"猜你喜欢"
                    font.pixelSize: 14
                    font.bold: true
                }
                //搜索记录
                Flow{
                    id:maybeLikeFlow
                    anchors.top:maybeLikeItem.bottom
                    anchors.topMargin:  30
                    anchors.left: maybeLikeItem.left
                    anchors.right:  maybeLikeItem.right
                    height:60
                    spacing: 10
                    property int count: 0
                    visible: singHistroyModel.count ? true : false
                    Repeater{
                        id:maybeLikeRep
                        anchors.fill: parent
                        model:singHistroyModel
                        property int count: 0
                        delegate: Rectangle{
                            width:maybeLikeData.width+20
                            height:30
                            border.width: 1
                            border.color: "#45454e"
                            color:  "#393943"
                            radius:12
                            //实现折叠效果
                            visible: maybeLikeExpand ||  y < maybeLikeFlow.y+20
                                     ? true :false
                            Label{
                                id:maybeLikeData
                                height: 20
                                width: implicitWidth < 100 ? implicitWidth :100
                                text: content
                                font.pixelSize: 13
                                anchors.centerIn: parent
                                color:"#ddd"
                                elide: Text.ElideRight
                            }
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered: {
                                    maybeLikeData.color = "white"
                                    parent.color = "#41414C"
                                    cursorShape = Qt.PointingHandCursor
                                }
                                onExited: {
                                    maybeLikeData.color = "#ddd"
                                    parent.color = "#393943"
                                    cursorShape = Qt.ArrowCursor
                                }
                            }
                        }
                    }
                    Rectangle{
                        id:maybeLikeExhibition
                        width:30
                        height:width
                        border.width: 1
                        border.color: "transparent"
                        color: "transparent"
                        radius:12
                        Image {
                            anchors.centerIn: parent
                            width: parent.width - 15
                            height:width
                            id: likecollapse
                            source: "qrc:/img/icon/down.png"
                            opacity: opac
                        }
                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                parent.color = "#41414C"
                                parent.border.color="#45454e"
                                cursorShape = Qt.PointingHandCursor
                            }
                            onExited: {
                                parent.color = "transparent"
                                cursorShape = Qt.ArrowCursor
                                parent.border.color= "transparent"

                            }
                            onClicked: {
                                if(maybeLikeExpand){
                                    likecollapse.source= "qrc:/img/icon/down.png"
                                    maybeLikeExpand = false
                                }else{
                                    likecollapse.source= "qrc:/img/icon/up.png"
                                    maybeLikeExpand = true
                                }

                            }
                        }
                    }
                }
            }

            //热搜
            Item{
                id:hotSearch
                y: maybeLikeItem.y +maybeLikeExhibition.y +maybeLikeExhibition.height+50
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 30
                height: 150
                Rectangle{
                    anchors.fill: parent
                    color:"#393943"
                    radius: 20
                    Label{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top:parent.top
                        anchors.topMargin: 10
                        id:hotSearchLabel
                        text: "热搜榜"
                        font.pixelSize: 18
                        font.bold: true
                        color:"#ddd"
                    }
                }
            }
            //播客榜
            Item{
                id:podcastRank
                y: hotSearch.y + 180
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 30
                height: 150
                Rectangle{
                    anchors.fill: parent
                    color:"#393943"
                    radius: 20
                    Label{
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.top:parent.top
                        anchors.topMargin: 10
                        id:podcastRankLabel
                        text: "播客榜"
                        font.pixelSize: 18
                        font.bold: true
                        color:"#ddd"
                    }
                }
            }
            //摇滚榜
            Item{
                id:rockRank
                y: podcastRank.y + 180
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 30
                height: 150
                Rectangle{
                    anchors.fill: parent
                    color:"#393943"
                    radius: 20
                }
            }
            //听书榜
            Item{
                id:listeningRank
                y: rockRank.y + 180
                anchors.left: parent.left
                anchors.right:parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 30
                height: 150
                Rectangle{
                    anchors.fill: parent
                    color:"#393943"
                    radius: 20
                }
            }
        }
    }
    ListModel{
        id:singHistroyModel
    }

    Component.onCompleted: {
        var songList = DataProvider.getData("file:///"+DataProvider.absolutePath+"/rightPage/search/searchTestData.js",["content"])
        for (var i = 0; i < songList.length; ++i) {
            singHistroyModel.append({"content":songList[i].content})
            singHistoryFlow.count++;
        }
    }
}


