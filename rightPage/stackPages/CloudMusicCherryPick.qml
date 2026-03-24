import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"
import "qrc:/rightPage/stackPages/items"
Item {
    Item{
        id:mainId
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.topMargin: 25
        // 标题界面
        Flow{
            id:settingTitleFlow
            anchors.left: parent.left
            anchors.top : parent.top
            anchors.topMargin: 20
            height: 25
            spacing: 25
            Repeater{
                id:selectorPep
                anchors.fill: parent
                property int selectedIndex: 0
                model:[{title:"精选",pageUrl:"./items/Selected.qml"},{title:"精选",pageUrl:"./items/SongsSquare.qml"},{title:"排行榜",pageUrl:""},{title:"歌手",pageUrl:""}] //更改页面路径
                delegate:
                    Item{
                    height:20
                    width:selectorLabel.implicitWidth
                    Label{
                        id:selectorLabel
                        text:modelData.title
                        color:selectorPep.selectedIndex === index ? BasicConfig.firstFontColor :  BasicConfig.secondFontColor
                        font.pixelSize: 16
                        font.bold: true
                        font.family: BasicConfig.fontFamily
                        anchors.centerIn:parent
                    }
                    Rectangle{
                        visible: selectorPep.selectedIndex === index
                        height:3
                        radius:1
                        color:BasicConfig.selectorUnderLineColor
                        anchors.left: selectorLabel.left
                        anchors.right: selectorLabel.right
                        anchors.top: selectorLabel.bottom
                        anchors.topMargin: 3
                        anchors.leftMargin: selectorLabel.implicitWidth * 0.15
                        anchors.rightMargin: selectorLabel.implicitWidth * 0.15
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            cursorShape = Qt.PointingHandCursor
                            if(selectorPep.selectedIndex != index){
                                selectorLabel.color= Qt.binding(function(){ //重新绑定
                                    return(selectorPep.selectedIndex ===
                                           index ? BasicConfig.firstFontColor :  BasicConfig.secondFontColorLight)
                                })
                            }
                        }
                        onExited: {
                            cursorShape = Qt.ArrowCursor
                            if(selectorPep.selectedIndex != index){
                                selectorLabel.color= Qt.binding(function(){ //重新绑定
                                    return(selectorPep.selectedIndex ===
                                           index ? BasicConfig.firstFontColor :  BasicConfig.secondFontColor)
                                })
                            }
                        }
                        onClicked: {
                            selectorPep.selectedIndex = index
                            selectorLabel.color= Qt.binding(function(){ //重新绑定
                                return(selectorPep.selectedIndex ===
                                       index ? BasicConfig.firstFontColor :  BasicConfig.secondFontColor)
                            })
                            coloudMusicCherryPickStackVeiw.push(modelData.pageUrl)
                            BasicConfig.gobalStack.push(()=>{coloudMusicCherryPickStackVeiw.pop()}) //全局页面栈添加
                            // mainId.jumpTo(index)
                        }
                    }
                }

            }//Repeater
        }//Flow
        StackView{
            id:coloudMusicCherryPickStackVeiw
            anchors.top:settingTitleFlow.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 20
            initialItem: "./items/Selected.qml"
        }
        Component.onCompleted: {
            BasicConfig.gobalStack.push(()=>{coloudMusicCherryPickStackVeiw.pop()}) //全局页面栈
        }
    }
}

