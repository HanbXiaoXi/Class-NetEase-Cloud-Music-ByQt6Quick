import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
Rectangle{
    id:cutline1
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.topMargin: 10
    anchors.rightMargin: parent.width*0.05
    height:1
    color:BasicConfig.secondFontColor
    opacity: 0.1
}
