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
        text:"播放"
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
        spacing:20
        CustomCheckBox{
            id:playWhenStart
            firstText:"程序启动时自动播放"
            secondText:""
        }
        CustomCheckBox{
            id:crossEndContinuation
            firstText:"跨端续播"
            secondText:"(无缝切换到电脑端播放歌曲)"
        }
        CustomCheckBox{
            id:playWhenPodcast
            firstText:"首次进入播客页时自动播放"
            secondText:"(不播歌时)"
        }
        CustomCheckBox{
            id:rememberTheProgress
            firstText:"程序启动时记住上一次播放进度"
            secondText:""
        }
        CustomCheckBox{
            id:musicFadeOnDirectSound
            firstText:"开启音乐淡入淡出"
            secondText:"(仅输出设备为 DirectSound时可启用)"
        }
        CustomCheckBox{
            id:volumeBalance
            firstText:"平衡不同音频内容之间的音量大小"
            secondText:""
        }
        // 输出设备开关
        Label{
            text:'输出设备'
            font.pixelSize: 16
            font.bold: true
            font.family: BasicConfig.fontFamily
            color:BasicConfig.firstFontColor
        }
        CustomComboBox{
            id:outputDevice
            height: 30
            width:200
            model: ["DirectSound:主声音驱动程序" ,"Wave Out:Mircosoft 声音映射器","Wasapi:默认输出设备"]
            onTextRChanged: { //实现设置的功能
            }
        }
        // 系统音量
        Row{
            spacing: 40
            Label{
                text:'系统音量'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            Label{
                text:"100" + "%" //输入系统音量
                font.pixelSize: 12
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:4
                Label{
                    text:"(低于30%可能影响收听体验)"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 11
                    font.bold: false
                    color:BasicConfig.secondFontColor
                }
            }
        }
        // 系统空间音效
        Row{
            spacing: 40
            Label{
                text:'系统空间音效'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            Label{
                text: "已关闭" //输入系统音量
                font.pixelSize: 12
                font.family: BasicConfig.fontFamily
                color:BasicConfig.secondFontColor
                y:5
                Label{
                    text:"(推荐保持关闭)"
                    anchors.left: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 12
                    font.bold: false
                    color:BasicConfig.secondFontColor
                }
            }
        }
        // 系统音频增强
        Row{
            spacing: 40
            Label{
                text:'系统音频增强'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            CustomCricularCheck{
                id:audioEnhancementOn
                firstText:"开启(可能影响声音效果)"
                canSelected:true
                anchors.verticalCenter: parent.verticalCenter
                onClicked:{
                    if(selected){
                        audioEnhancementOff.selected = false
                    }
                }
            }
            CustomCricularCheck{
                id:audioEnhancementOff
                firstText:"关闭"
                canSelected:true
                anchors.verticalCenter: parent.verticalCenter
                onClicked:{
                    if(selected){
                        audioEnhancementOn.selected = false
                    }
                }
            }
        }
        // 音乐黑名单
        Row{
            spacing: 40
            Label{
                text:'音乐黑名单'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            Label{
                text: "音乐人/单曲/风格黑名单" //输入系统音量
                font.pixelSize: 12
                font.family: BasicConfig.fontFamily
                color:BasicConfig.secondFontColor
                y:4
            }
        }
        // 播放列表
        Column{
            spacing: 5
            Label{
                text:'播放列表'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3
                // verticalAlignment: Qt.AlignVCenter
            }
            //双击情况
            CustomCricularCheck{
                id:replaceThePlaylist
                firstText:"双击播放单曲时,用当前单曲所在的歌曲列表替换播放列表"
                firstTextColor:BasicConfig.firstFontColor
                canSelected:true
                onClicked:{
                    if(selected){
                        replaceTheSingle.selected = false
                    }
                }
            }
            CustomCricularCheck{
                id:replaceTheSingle
                firstText:"双击播放单曲时,仅把当前单曲添加到播放列表"
                firstTextColor:BasicConfig.firstFontColor
                canSelected:true
                onClicked:{
                    if(selected){
                        replaceThePlaylist.selected = false
                    }
                }
            }
        }
        // 最近播放记录
        Column{
            spacing: 5
            Label{
                text:'最近播放记录'
                font.pixelSize: 14
                font.bold: true
                font.family: BasicConfig.fontFamily
                color:BasicConfig.firstFontColor
                y:3

            }
            CustomCheckBox{
                id:syncRecording
                firstText:"开启后,同步当前账号在各设备的最近播放记录"
                secondText:""
            }
        }
    }
    CustomCutLine{//下划线
        id: cutLine
        anchors.top: selects.bottom
        anchors.topMargin: 45
    }

}
