import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
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
        anchors.left: parent.left
        anchors.leftMargin: 10
        verticalAlignment: Text.AlignVCenter
        // elide: Text.ElideRight
    }
    popup: Popup{
        id:popup
        y:parent.height+5
        width: parent.width
        height: popupView.count < 8 ? popupView.count * 30 : 210
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
                    width: cbx.width-10
                    height:30
                    color:BasicConfig.boxColor
                    Text{
                        color:BasicConfig.secondFontColorLight
                        text:modelData
                        font.pixelSize: 14
                        anchors.left: parent.left
                        leftPadding: 10
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        font.family: BasicConfig.fontFamily
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
