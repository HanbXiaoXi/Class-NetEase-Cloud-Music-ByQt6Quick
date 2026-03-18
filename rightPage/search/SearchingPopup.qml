import QtQuick 2.15
import QtQuick.Controls
import QtQml.XmlListModel
import QtQuick.Controls.Basic
import "qrc:/Basic"
Popup {
    id:searchPop
    width:  500
    height: 300
    closePolicy:Popup.CloseOnPressOutsideParent
    modal: false
    property real opac: 0.5
    property bool historyExpand: false
    property bool searchPopOpened: false
    property bool maybeLikeExpand :false
    clip:true
    background: Rectangle{
        anchors.fill: parent
        radius:10
        color:BasicConfig.popupBackgroudColor
    }
    ListModel{
        id:searchHintModel
    }

    Component.onCompleted: {
        var songList = DataProvider.getData("file:///"+DataProvider.absolutePath+"/rightPage/search/searchTestData.js",["content"])
        for (var i = 0; i < 10; ++i) {
            searchHintModel.append({"content":songList[i].content})
        }
    }
}
