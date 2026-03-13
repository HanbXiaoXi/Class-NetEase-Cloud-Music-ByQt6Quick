import QtQuick 2.15
import QtQuick.Controls
import "qrc:/title"
Rectangle{
    id:rightRect
    Rectangle{ //任务栏
        height:60
        anchors.left: parent.left
        anchors.top:  parent.top
        anchors.right:  parent.right
        color:parent.color
        //MinAndMax
        MinAndMax{
            id:minAndMax
            height: parent.height
            anchors.right: parent.right
            anchors.rightMargin: 20
        }

    }
}
