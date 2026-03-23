pragma Singleton //设置单例
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import "qrc:/Basic"
QtObject {
    // property string currentPath :
    signal blankAreaClicked()  //点击空白区域
    signal openLoginPopup()  //打开登录菜单
    property color windowBoderColor :"#75777f"
    property color leftPageColor: "#1a1a20"
    property color rightPageColor: "#13131a"
    property color loginColor: "#1b1b23"
    property color firstFontColor:"white"
    property color secondFontColor: "#a4a4a4"
    property color secondFontColorLight:"#b9b9ba"
    property color popupBackgroudColor: "#2d2d37"
    property color selectorUnderLineColor: "#eb4d44"
    property color boxColor: "#1a1a20"
    property color boxBorderColor: "#28282e"
    property color scrollBarColor:"#393943"
    property string fontFamily:"微软雅黑"

}
// import "qrc:/Basic"
//当前路径

//字体
/*
font.pixelSize: 14
font.bold: true
font.family: BasicConfig.fontFamily
*/
//颜色
// BasicConfig.firstFontColor
// BasicConfig.secondFontColor
// BasicConfig.secondFontColorLight
// BasicConfig.selectorUnderLineColor
// BasicConfig.popupBackgroudColor
// BasicConfig.boxColor
// BasicConfig.boxBorderColor
// BasicConfig.scrollBarColor

// Copy Template
/*
    // 自定义 复选框
    CustomCheckBox{
        id:
        firstText:""
        secondText:""
    }
    CustomCricularCheck{
        id:
        firstText:""
    }

*/
