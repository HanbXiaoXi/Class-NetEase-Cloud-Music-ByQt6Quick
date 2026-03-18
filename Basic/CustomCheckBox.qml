import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
//CheckBox
Item{
    height: 26
    width:row.implicitWidth
    property bool selected: false //设置复选框
    property alias firstText :firstLabel.text
    property alias secondText : secondLabel.text
    property alias thirdText :thirdLabel.text
    signal clicked()
    onSelectedChanged: {
        if(selected){
            rect.color = BasicConfig.selectorUnderLineColor
            rect.border.color = BasicConfig.selectorUnderLineColor
        }else{
            rect.color ="transparent"
            rect.border.color = BasicConfig.secondFontColor
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            cursorShape = Qt.PointingHandCursor
        }
        onExited: {
            cursorShape = Qt.ArrowCursor
        }
        onClicked: {
            selected = !selected
            parent.clicked()
        }
    }

    Row{
        id:row
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 10
        Rectangle{ //勾选框
            id:rect
            width:16
            height: width
            radius: 2
            color:"transparent"
            border.width: 1
            border.color: BasicConfig.secondFontColor
            Label{
                id:selectedLabel
                visible: selected
                font.bold:true
                text:"√"
                color: BasicConfig.firstFontColor
                font.family: "黑体"
                font.pixelSize: 18
                anchors.centerIn: parent
            }
        }
        Label{
            id:firstLabel
            font.pixelSize: 14
            font.family: BasicConfig.fontFamily
            anchors.verticalCenter: rect.verticalCenter
            color:BasicConfig.firstFontColor
            Label{
                id:secondLabel
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                anchors.left:parent.right
                anchors.verticalCenter: parent.verticalCenter
                color:BasicConfig.secondFontColor
            }
            Label{
                id:thirdLabel
                font.pixelSize: 13
                font.family: BasicConfig.fontFamily
                anchors.top: parent.bottom
                anchors.topMargin: 4
                color:BasicConfig.secondFontColor
            }
        }

    }
}
