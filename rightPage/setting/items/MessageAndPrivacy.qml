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
        text:"消息与隐私"
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        anchors.left: parent.left
        color:BasicConfig.firstFontColor
    }
    Label{
        id:itemDiscriptionLabel
        text:"字体选择"
        font.pixelSize: 14
        font.bold: true
        font.family:BasicConfig.fontFamily
        anchors.verticalCenter: itemTitleLabel.verticalCenter
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        color:BasicConfig.firstFontColor
    }
    Label{
        id:itemDiscriptionLabelSecond
        text:"(如果字体显示不清晰,请在控制面板-字体设置中启动系统 Clear Type设置)"
        font.pixelSize: 13
        font.family:BasicConfig.fontFamily
        anchors.verticalCenter: itemDiscriptionLabel.verticalCenter
        anchors.left: itemDiscriptionLabel.right
        anchors.leftMargin: 0
        color:BasicConfig.secondFontColor
    }
    //字体选择
    CustomComboBox{
        id:fontSelectorBox
        model: ["默认", "仿宋","宋体", "微软雅黑", "微软雅黑","新宋体","楷体","等线","等线 Light"]
        anchors.left: itemDiscriptionLabel.left
        anchors.top: itemDiscriptionLabel.bottom
        anchors.topMargin: 20
        onTextRChanged: { //实现设置的功能
        }
    }

    Column{
        id:selects
        height: implicitHeight
        anchors.top: fontSelectorBox.bottom
        anchors.topMargin: 20
        anchors.left: itemTitleLabel.left
        anchors.leftMargin: 150
        anchors.right: parent.right
        spacing:20
        //开机自启动
        CustomCheckBox{
            id:setBootStartup
            firstText:"开机自动运行"
            //startByMinimize
            CustomCricularCheck{
                id:startByMinimize
                anchors.left: parent.right
                anchors.leftMargin: 40
                firstText:"最小化展示"
                canSelected:parent.selected
                onClicked:{
                    if(selected){
                        startByFrontEnd.selected = false
                    }
                }
            }
            CustomCricularCheck{
                id:startByFrontEnd
                firstText:"前台展示"
                anchors.left: startByMinimize.right
                anchors.leftMargin: 40
                canSelected:parent.selected
                onClicked:{
                    if(selected){
                        startByMinimize.selected = false
                    }
                }
            }
        }
        //设置默认播放器
        CustomCheckBox{
            id:setDefaultPlayer
            firstText:"将网易云音乐设为默认播放器"
            secondText:""
        }
        // 开启GPU加速
        CustomCheckBox{
            id:setGpuAcceleration
            firstText:"开启GPU加速"
            secondText:"(若软件黑屏,请关闭GPU加速尝试解决)"
        }
        //禁用动画
        CustomCheckBox{
            id:disableAnimationEffects
            firstText:"开机自动运行"
            secondText:"(减少部分资源占用)"
        }
        //禁用系统缩放比例
        CustomCheckBox{
            id:disableSystemScaling
            firstText:"禁用系统缩放比例"
            secondText:"(减少部分资源占用)"
            thirdText:"*高清屏适配,禁用后,建议重启软件"
        }
    }
    CustomCutLine{//下划线
        id: cutLine
        anchors.top: selects.bottom
        anchors.topMargin: 45
    }
}


