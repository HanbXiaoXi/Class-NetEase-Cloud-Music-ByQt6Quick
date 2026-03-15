import QtQuick 2.15
import QtQuick.Controls
import QtQml.XmlListModel


Popup {
    id:searchPop
    width:  780
    height: 600
    closePolicy:Popup.CloseOnPressOutsideParent
    modal: false
    property real opac: 0.5
    property bool historyExpand: false
    property bool searchPopOpened: false


    background: Rectangle{
        anchors.fill: parent
        radius:10
        color:"#2d2d37"
        //搜索历史主题以及回收
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
                        // 实现删除功能
                        singHistroyModel.clear()
                        historyExpand = false // 展开设置为关闭状态
                    }
                }
            }

        }
        //搜索记录
        Flow{
            id:singHistoryFlow
            anchors.top:histroyItem.bottom
            anchors.topMargin:  30
            anchors.left: histroyItem.left
            anchors.right:  histroyItem.right
            height:60
            spacing: 10
            visible: singHistroyModel.count ? true : false
            Repeater{
                id:singhistroyRep
                anchors.fill: parent
                model:singHistroyModel
                delegate: Rectangle{
                    width:singhistroyData.width+20
                    height:30
                    border.width: 1
                    border.color: "#45454e"
                    color:  "#393943"
                    radius:12
                    //实现折叠效果
                    visible: singhistroyRep.count && singhistroyRep.itemAt(index).y < singHistoryFlow.y || historyExpand
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
            //删除按钮
            Rectangle{
                width:30
                height:width
                border.width: 1
                border.color: "transparent"
                color: "transparent"
                radius:12
                // visible: singhistroyRep.count &
                //          (!singhistroyRep.itemAt(singhistroyRep.count-1).visible | singhistroyRep.itemAt(singhistroyRep.count-1) > singHistoryFlow.y)
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

    ListModel{
        id:singHistroyModel
    }

    Component.onCompleted: {
        var songList = DataProvider.getData("file:///"+DataProvider.absolutePath+"/rightPage/search/searchTestData.js",["content"])
        for (var i = 0; i < songList.length; ++i) {
                singHistroyModel.append({"content":songList[i].content})
        }
    }
}


