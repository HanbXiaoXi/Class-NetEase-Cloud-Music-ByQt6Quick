import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
Item{
    height: 26
    width:row.implicitWidth
    property bool selected: false //设置复选框
    property bool canSelected : false //是否可选
    property alias firstText :firstLabel.text
    property alias  firstTextColor: firstLabel.color
    signal clicked()
    onSelectedChanged: {
        if(selected){
            rect.border.color = BasicConfig.selectorUnderLineColor
        }else{
            rect.border.color = BasicConfig.secondFontColor
        }
    }
    onCanSelectedChanged: {
        if(canSelected){
            rect.border.color = BasicConfig.secondFontColor
        }
        else{
            rect.border.color = BasicConfig.boxBorderColor
        }
    }
    MouseArea{
        id:mouseArea
        anchors.fill: parent
        hoverEnabled: true
        visible: canSelected
        onEntered: {
            rect.border.color = BasicConfig.secondFontColorLight
            cursorShape = Qt.PointingHandCursor
        }
        onExited: {
            rect.border.color = BasicConfig.secondFontColor
            cursorShape = Qt.ArrowCursor
        }
        onClicked: {
            selected = !selected //取消勾选
            parent.clicked() //传递信号
        }
    }
    Row{
        id:row
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        //勾选框
        Rectangle{
            id:rect
            width:16
            height: width
            radius: 8
            color:"transparent"
            border.width: 1
            border.color: BasicConfig.boxBorderColor
            Rectangle{
                id:selectedRect
                color:BasicConfig.selectorUnderLineColor
                width: 8
                height: width
                radius: 4
                visible: canSelected && selected
                anchors.centerIn: parent
            }
        }
        //文字设置
        Label{
            id:firstLabel
            font.pixelSize: 13
            font.family: BasicConfig.fontFamily
            anchors.verticalCenter: rect.verticalCenter
            color:BasicConfig.secondFontColor
        }
    }

}
