import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"

//文字长度过长自动换行
ComboBox{
    id:cbx
    width:120
    height:26
    property int indicatorRotation: 90  // 箭头方向
    property string textR: currentText
    background: Rectangle{
        anchors.fill: parent
        radius:parent.height/2
        border.width: 1
        border.color: BasicConfig.boxBorderColor
        color:BasicConfig.boxColor
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                // console.log("Pressed")
                parent.color = BasicConfig.boxBorderColor
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                parent.color = BasicConfig.boxColor
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                // console.log("Clicked")
                cbx.popup.open()

            }
        }
    }
    indicator: Label{
        text:">"
        font.pixelSize: 22
        font.bold: true
        font.family: "黑体"
        color:BasicConfig.secondFontColorLight
        anchors.right:parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        rotation: parent.indicatorRotation
    }
    contentItem: Text{
        text:parent.textR
        color:BasicConfig.firstFontColor
        font.pixelSize: 14
        font.family: BasicConfig.fontFamily
        width: parent.width
        elide: Text.ElideRight  //只有设置了明确宽度的才有用
        anchors.left: parent.left
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
        rightPadding: 20
        // elide: Text.ElideRight
    }
    popup: Popup{
        id:popup
        y:parent.height+5
        width: parent.width
        height: popupView.count < 7 ? popupView.count * 30  : 210
        background: Rectangle{
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom:  parent.bottom
            // contentHeight: popupView.count * 30
            color:BasicConfig.boxBorderColor
            radius: 10
            clip:true
            ListView{
                id:popupView
                anchors.fill: parent
                model:cbx.model
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

                delegate: Rectangle{
                    height: 30 < text.implicitHeight ? text.implicitHeight+10 :30
                    width: cbx.width-10
                    color:BasicConfig.boxColor
                    Text{
                        id:text
                        width:parent.width
                        text:modelData
                        color:BasicConfig.secondFontColorLight
                        wrapMode: Text.WordWrap
                        font.pixelSize: 14
                        font.family: BasicConfig.fontFamily
                        anchors.verticalCenter: parent.verticalCenter
                        leftPadding: 10
                    }
                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            // console.log("Pressed")
                            parent.color = BasicConfig.boxBorderColor
                            cursorShape = Qt.PointingHandCursor
                        }
                        onExited: {
                            parent.color = BasicConfig.boxColor
                            cursorShape = Qt.ArrowCursor
                        }
                        onClicked: {
                            // console.log("Clicked")
                            cbx.textR = modelData
                            popup.close()
                        }
                    }
                    //如果文字过长可能两行
                    //在两行甚至多行 且 对象数量不大于7的情况展开列表高度不足
                    Component.onCompleted: {
                        if(index < 7){
                            popup.height = popup.height +height <210 ? popup.height +height : 210
                        }
                    }
                }
            }
        }
        onOpened: { //点开时转换箭头方向
            parent.indicatorRotation = -90
        }
        onClosed: {
            parent.indicatorRotation = 90
        }
    }
}
