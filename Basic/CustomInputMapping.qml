import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
// 用于设置里面的按键映射反应

TextField{
    id:key
    readOnly: true // 只读
    cursorVisible: true
    font.pixelSize: 14
    font.bold: true
    font.family: BasicConfig.fontFamily
    color:BasicConfig.secondFontColor
    Keys.onPressed: function(event){
        if(!focus)return
        let str = ""
        if(event.modifiers && Qt.ControlModifier){
            str += "Ctrl + "
        }
        if(event.modifiers && Qt.ShiftModifier){
            str += "Shift + "
        }
        if( event.modifiers && Qt.AltModifier){
            str += "Alt + "
        }
        str += String.fromCharCode(event.key) //转换成字符串
        if(text !== "")
            text = str
        else
            text = "空"
    }
    background: Rectangle{
        color:BasicConfig.boxColor
        border.width: 1
        border.color: BasicConfig.boxBorderColor
        anchors.fill: parent
        radius:height/2
        Rectangle{
            id: focusRect
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 4
            anchors.bottomMargin: 4
            width: 1
            visible: key.focus
            anchors.leftMargin: key.implicitWidth -5 //竖线位置
        }
        //顺序执行动画
        SequentialAnimation{
            id:foucsAnimation
            running: key.focus
            loops:Animation.Infinite // 循环
            PropertyAnimation{
                target: focusRect
                property:"opacity"
                from:1
                to:0
                duration: 500
            }
            PropertyAnimation{
                target: focusRect
                property:"opacity"
                from:0
                to:1
                duration: 500
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                cursorShape = Qt.IBeamCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onPressed: {
                mouse.accepted =false
            }
        }
    }
}
