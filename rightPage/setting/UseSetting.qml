import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"
Item {
    Item{
        id:mainId
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.topMargin: 25

        // ["accountSetting","routine","systemSetting","playerSetting",
        //     "messageAndPrivacy" ,"shortcutKey","qualityAndDownload",
        //     "desktopAndLyrics","tool","aboutSoftware"]
        property var flickList: [] //设定可以跳跃的item
        Component.onCompleted: {
            flickList.push(accountSetting)
            flickList.push(routine)
            flickList.push(systemSetting)
            flickList.push(playerSetting)
            flickList.push(messageAndPrivacy)
            flickList.push(shortcutKey)
            flickList.push(qualityAndDownload)
            // flickList.push(desktopAndLyrics)
            // flickList.push(tool)
            // flickList.push(aboutSoftware)
        }
        // 点击跳跃到指定位置
        function jumpTo(index) {
            var y = flickList[index].y
            // console.log(y)
            settingFlick.contentY = Math.max(0, Math.min(y+10, settingFlick.contentHeight - settingFlick.height))
        }
        //检测移动区域并更改Flow滑块名称与区域对应
        function changeTitleFlow(){
            if(settingFlick.contentY >= flickList[flickList.length-1].y){
                selectorPep.selectedIndex = flickList.length-1
                return 1;
            }
            for(var i = 1 ; i < flickList.length ;++i ){
                if(settingFlick.contentY >= flickList[i-1].y && settingFlick.contentY < flickList[i].y){
                    selectorPep.selectedIndex = i -1
                    return 1;
                }
            }
        }
        Label{
            id:setingMainTitle
            color:BasicConfig.firstFontColor
            text:"设置"
            font.bold: true
            font.pixelSize: 25
            font.family: BasicConfig.fontFamily
            anchors.left: parent.left
            anchors.top :parent.top
        }
        Flow{
            id:settingTitleFlow
            anchors.left: setingMainTitle.left
            anchors.top :setingMainTitle.bottom
            anchors.topMargin: 20
            height: 25
            spacing: 25
            Repeater{
                id:selectorPep
                anchors.fill: parent
                property int selectedIndex: 0
                model:["账号","常规","系统","播放","消息与隐私","快捷键","音质与下载","桌面歌词","工具","关于类网易云音乐"]
                delegate:
                    Item{
                    height:20
                    width:selectorLabel.implicitWidth
                    Label{
                        id:selectorLabel
                        text:modelData
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
                            mainId.jumpTo(index)
                        }
                    }
                }

            }//Repeater

        }//Flow
        Rectangle{
            id:cutline1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: settingTitleFlow.bottom
            anchors.topMargin: 10
            anchors.rightMargin: parent.width*0.05
            height:1
            color:BasicConfig.secondFontColor
            opacity: 0.1
        }

        // Setting列表
        Flickable{
            id:settingFlick
            anchors.left: parent.left
            anchors.right :parent.right
            anchors.top: cutline1.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            clip:true
            contentHeight: settingColumn.implicitHeight + 1000
            acceptedButtons: Qt.NoButton

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
            // onMovingChanged: {
            //     console.log(playerSetting.y)
            // }

            Column{
                id:settingColumn
                anchors.fill: parent
                anchors.topMargin: 30
                spacing:30
                AccountSetting{
                    id:accountSetting
                }
                Routine{
                    id:routine
                }
                SystemSetting{
                    id:systemSetting
                }
                PlayerSetting{
                    id:playerSetting
                }
                MessageAndPrivacy{
                    id:messageAndPrivacy
                }
                ShortcutKey{
                    id:shortcutKey
                }
                QualityAndDownload{
                    id:qualityAndDownload
                }
            }
            onContentYChanged: {
                mainId.changeTitleFlow()
            }
            onMovingChanged: {
            }
        }

    }
}

