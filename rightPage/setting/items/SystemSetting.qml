import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"

Item{
    anchors.left: parent.left
    anchors.right: parent.right
    height: cutLine.y -itemTitleLabel.y
    Label{
        id:itemTitleLabel
        text:"系统"
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: parent.left
        color:BasicConfig.firstFontColor
    }

    // //字体选择
    // CustomComboBox{
    //     id:fontSelectorBox
    //     model: ["默认", "仿宋","宋体", "微软雅黑", "微软雅黑","新宋体","楷体","等线","等线 Light"]
    //     anchors.left: itemDiscriptionLabel.left
    //     anchors.top: itemDiscriptionLabel.bottom
    //     anchors.topMargin: 20
    //     onTextRChanged: { //实现设置的功能
    //     }
    // }

    Column{
        id:selects
        height: implicitHeight
        anchors.topMargin: 20
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        anchors.right: parent.right
        spacing:15
        //开启定时软件
        CustomCheckBox{
            id:setTimer
            firstText:"开启定时软件"
            //startByMinimize
            }
        Row{
            spacing: 10
            Label{
                id : timerLabel
                text:'剩余关闭时间'
                font.pixelSize: 16
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
            CustomComboBox{
                id:minuteSelectorBox
                height: 30
                model: 24
                anchors.verticalCenter: timerLabel.verticalCenter
                onTextRChanged: { //实现设置的功能
                }
            }
            Label{
                text:'分'
                font.pixelSize: 16
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
            CustomComboBox{
                id:secondSelectorBox
                height: 30
                model: 60
                anchors.verticalCenter: timerLabel.verticalCenter
                onTextRChanged: { //实现设置的功能
                }
            }
            Label{
                text:'分'
                font.pixelSize: 16
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
            }
        }
        //关闭主面板时的选择
        Row{
            spacing: 40
            Label{
                id : closeMainPanelLabel
                text:'关闭主面板'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            CustomCricularCheck{
                id:closeSetMinimize
                firstText:"最小化到系统托盘"
                canSelected:true
                anchors.verticalCenter: parent.verticalCenter
                onClicked:{
                    if(selected){
                        closeSetExit.selected = false
                    }
                }
            }
            CustomCricularCheck{
                id:closeSetExit
                firstText:"退出云音乐"
                canSelected:true
                anchors.verticalCenter: parent.verticalCenter
                onClicked:{
                    if(selected){
                        closeSetMinimize.selected = false
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


