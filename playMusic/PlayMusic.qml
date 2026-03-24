import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic
import QtMultimedia
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"
import "./Item"
import QtQuick.Dialogs

Rectangle{
    id:palyMusicMainId
    height:100
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    color:BasicConfig.popupBackgroudColor
    property int songIndex: 0
    property var playStack: [] //存放播放顺序
    property int playOrder: 1 // 1为顺序播放 ， 2为随机播放

    property int startIndex: 0 //用于检测列表可视区域头index
    property int endIndex:10 //用于检测列表可视区域尾index
    property bool songLoadMutex :false
    //播放条
    Slider {
        id:durationTimeSlider
        height: 8
        // 锚定滑块进度条位置
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin:-4
        // 定义值
        value : MusicPlayer.progress
        from:0
        to:1000
        visible:MusicPlayer.title === "" ? false : true //没有歌曲时不显示
        onValueChanged:{  //歌曲结尾时
            if(value === to){
                //由next按键提供
                nextMouseArea.clicked(MouseEvent)
            }
        }

        // 设置进度条的背景样式
        background: Rectangle{
            x: durationTimeSlider.leftPadding
            y: durationTimeSlider.topPadding + durationTimeSlider.availableHeight / 2 - height / 2
            width: durationTimeSlider.availableWidth
            height: parent.height/2
            radius: 2
            color: BasicConfig.secondFontColor    // 进度条背景颜色
            // 视频已经播放的区域
            Rectangle{
                width: durationTimeSlider.visualPosition * parent.width
                height: parent.height
                color: BasicConfig.firstFontColor    // 进度条已经走完的颜色
                radius: 2
            }
            //改变鼠标形状
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onPressed:mouse=> {
                              // parent.index = parent.visualPosition*1000
                              mouse.accepted = false
                          }
                onClicked: mouse=> {
                               mouse.accepted = false
                           }
                onReleased:mouse=>  {
                               mouse.accepted = false
                           }

                onEntered:{
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    cursorShape = Qt.ArrowCursor
                }
            }

        }
        // 滑块样式
        handle: Rectangle{
            antialiasing: true
            x: durationTimeSlider.leftPadding + durationTimeSlider.visualPosition
               * (durationTimeSlider.availableWidth - width)
            y: durationTimeSlider.topPadding + durationTimeSlider.availableHeight / 2 - height / 2
            width: 15
            height: 15
            radius: 10
            border.color: BasicConfig.boxColor    // 滑块边框颜色
            // 判断滑块按压状态，设置不同的颜色
            color: durationTimeSlider.pressed ? BasicConfig.firstFontColor : BasicConfig.secondFontColor
            // 滑块中心的区域，设置了透明
            Rectangle{
                width: 4
                height: 4
                radius: 2
                color: "transparent"
                anchors.centerIn: parent
            }
        }
        property real index: 0
        property bool changed: false
        // 滑块移动时，将 index 设置为滑块当前位置
        onMoved: {
            if(pressed){
                index = visualPosition*1000  // visualPosition 范围为（0~1000)
            }
        }
        // 改变按压状态时，判断按压状态，将播放进度设置为进度条的进度，保持进度条和视频播放进度一致
        onPressedChanged: {
            if(pressed === true){
                index = visualPosition*1000
                changed = true
            }else if (changed === true){
                MusicPlayer.changeProgress(index)
                // value = Qt.binding(function(){return MusicPlayer.progress }) //重新将index和MusicPlayer中的Progress绑定
                changed = false
            }
        }

    }


    //正在播放的音乐的图片
    Image {
        width: parent.height*0.8
        height: width
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.height*0.1
        source: MusicPlayer.image
    }
    Label{
        width: 200
        id:title
        text:MusicPlayer.title
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 110
        font.pixelSize: 16
        font.bold: true
        font.family: BasicConfig.fontFamily
        color:BasicConfig.firstFontColor
    }
    Label{
        width: 200
        id:artist
        text:MusicPlayer.artist
        anchors.top :title.bottom
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 110
        font.pixelSize: 14
        font.bold: true
        font.family: BasicConfig.fontFamily
        color:BasicConfig.secondFontColor
    }
    //显示时间数据
    Label{
        id:timeDisplay
        text:MusicPlayer.timeDisplay
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        font.pixelSize: 14
        font.bold: true
        font.family: BasicConfig.fontFamily
        color:BasicConfig.secondFontColor
    }
    //上一首
    Rectangle{
        id:previousMouseArea
        width:25
        height:width
        color:"transparent"
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: 45
        anchors.verticalCenter: parent.verticalCenter
        opacity:0.8
        Image {
            width:parent.width
            height:width
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/img/icon/previous.png"
            opacity: 1
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.opacity = 1
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                parent.opacity = 0.8
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                if(playOrder === 1){
                    if(songIndex > 0){  //index不为0时还可以递减
                        songIndex -= 1 //当前index值-1
                        let filename = songListModel.get(songIndex).filename
                        console.log(musicLoadPathDialog.currentFolder+"/"+filename)
                        MusicPlayer.setFilePath(musicLoadPathDialog.currentFolder+"/"+filename)


                    }else{
                        songIndex = songListModel.count-1
                        let filename = songListModel.get(songIndex).filename
                        console.log(musicLoadPathDialog.currentFolder+"/"+filename)
                        MusicPlayer.setFilePath(musicLoadPathDialog.currentFolder+"/"+filename)

                    }

                }

            }
        }
    }
    // 播放
    Rectangle{
        id:playRect
        width:40
        height:width
        color:BasicConfig.selectorUnderLineColor
        radius: width /2
        anchors.centerIn: parent
        opacity:1
        Image {
            id:playIcon
            anchors.centerIn: parent
            width:parent.width*0.4
            height:width
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/img/icon/paly.png"
            opacity: 1
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.width = 43
                parent.opacity = 0.8
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                parent.width = 40
                parent.opacity = 1
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                //防止没有文件的时候触发
                if(MusicPlayer.title != ""){
                    MusicPlayer.play()
                }
            }
        }
    }
    // 下一首
    Rectangle{
        width:25
        height:width
        color:"transparent"
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 45
        opacity:0.8
        anchors.verticalCenter: parent.verticalCenter
        Image {
            width:parent.width
            height:width
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/img/icon/next.png"
            opacity: 1
        }
        MouseArea{

            id:nextMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.opacity = 1
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                parent.opacity = 0.8
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                if(playOrder === 1){
                    if(songIndex < songListModel.count-1){
                        songIndex += 1 //当前index值+1
                        let filename = songListModel.get(songIndex).filename
                        console.log(musicLoadPathDialog.currentFolder+"/"+filename)
                        MusicPlayer.setFilePath(musicLoadPathDialog.currentFolder+"/"+filename)
                    }else{  //超过歌曲数时从0开始
                        songIndex = 0
                        let filename = songListModel.get(songIndex).filename
                        console.log(musicLoadPathDialog.currentFolder+"/"+filename)
                        MusicPlayer.setFilePath(musicLoadPathDialog.currentFolder+"/"+filename)
                    }
                }
            }

        }
    }
    //打开播放列表
    Rectangle{
        width:25
        height:width
        color:"transparent"
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: 90
        opacity:0.8
        anchors.verticalCenter: parent.verticalCenter
        Image {
            width:parent.width
            height:width
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/img/icon/list.png"
            opacity: 1
        }
        MouseArea{
            id:playListArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.opacity = 1
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                parent.opacity = 0.8
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                playerDrawer.open()
            }
        }
    }

    //查找目录
    FolderDialog{
        id:musicLoadPathDialog
        onAccepted: {
            songListModel.clear()
            let s = String(currentFolder)
            console.log(s)
            // downloadPath.text =s.slice(8,) //截取
            var songList = DirProvider.getDir(s) //获取音乐列表
            for (var i = 0; i < songList.length; ++i) {
                console.log(songList[i].filename)
                songListModel.append({"title":songList[i].title,"filename":songList[i].filename})
            }
        }
    }


    //音量按钮
    Rectangle{
        width:25
        height:width
        color:"transparent"
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.verticalCenter: parent.verticalCenter
        Image {
            anchors.fill: parent
            id: laoclIcon
            source: "qrc:/img/icon/volume.png"
            opacity: 0.5
            MouseArea{
                property int  volumeTemp:0
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    volumeTimer.stop()
                    volumeRect.visible = true
                    parent.opacity+=0.3
                }
                onExited: {
                    volumeTimer.start() //离开后0.3秒关闭音量调节区
                    parent.opacity-=0.3
                }
                onClicked: {
                    if(MusicPlayer.volume !== 0){
                        volumeTemp = MusicPlayer.volume
                        MusicPlayer.volume = 0
                    }else{
                        MusicPlayer.volume = volumeTemp
                    }
                }
            }
            Timer{
                id:volumeTimer
                interval:300
                triggeredOnStart: false
                onTriggered: {
                    volumeRect.visible = false
                }
            }
        }
        Rectangle{
            id:volumeRect
            height: 120
            width:30
            visible: false
            color:BasicConfig.boxColor
            anchors.bottom: parent.top
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    volumeTimer.stop()//进入调节区域后就可以不用计时器了
                    parent.visible = true
                }
                onExited: {
                    parent.visible = false
                    volumeTimer.start() //离开后0.5秒关闭音量调节区
                }
                onClicked: {
                }
            }
        }
    }
    //打开文件夹
    Rectangle{
        width:25
        height:width
        color:"transparent"
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        Image {
            anchors.fill: parent
            id: localIcon
            source: "qrc:/img/icon/local.png"
            opacity: 0.5
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity+=0.3
                }
                onExited: {
                    parent.opacity-=0.3
                }
                onClicked: {

                    musicLoadPathDialog.open()
                }
            }
        }
    }
    //播放目录
    Drawer{
        id: playerDrawer
        topMargin:80
        width: 400
        height: rightRect.height - 100

        background: Rectangle{
            anchors.fill: parent
            color: BasicConfig.popupBackgroudColor
            radius: 10
            clip: true
        }
        edge: Qt.RightEdge
        interactive:true
        dragMargin:0 //防止滑动
        closePolicy: Popup.CloseOnReleaseOutside
        modal: false
        onOpenedChanged:  {
            if(opened){
                playListArea.visible = false
            }else{
                playListArea.visible = true
            }
        }
        Rectangle{
            id:playerListTitle
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 100
            color: "transparent"
            Label{
                text: "播放列表(" + songListModel.count +")"
                color:BasicConfig.firstFontColor
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 15
                anchors.leftMargin: 20
                font.pixelSize: 18
                font.bold: true
                font.family: BasicConfig.fontFamily
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                height: 1
                width: parent.width
                color:BasicConfig.secondFontColor
                opacity: 0.2
            }
            Rectangle{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                height: 1
                width: parent.width
                color:BasicConfig.secondFontColor
                opacity: 0.2
            }
        }
        //播放ListView
        ListView{
            id:songListView
            model: songListModel
            delegate: songListDelegate
            clip: true
            //提高平滑度
            cacheBuffer:0
            anchors.top:playerListTitle.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            ScrollBar.vertical: ScrollBar{
                anchors.right: parent.right
                width: 10
                //滚轮颜色
                contentItem: Rectangle{
                    color:BasicConfig.secondFontColor
                }
                background: Rectangle{
                    anchors.fill: parent
                    color: "transparent"
                }
            }

            // 每次滚动时输出当前可见范围
            onContentYChanged: {
                startIndex = Math.floor(visibleArea.yPosition * count);
                endIndex = Math.min(count - 1,
                                    Math.ceil((visibleArea.yPosition + visibleArea.heightRatio) * count) - 1);
                // console.log("当前可见项索引范围:", startIndex, "到", endIndex);
            }

        }
    }
    //歌曲列表模型和委托
    ListModel{
        id:songListModel
    }
    Component{
        id:songListDelegate
        Rectangle{
            width: playerDrawer.width
            height: 80
            // radius: 10
            color:BasicConfig.popupBackgroudColor

            //歌名
            Label {
                id:songTitle
                // text:title
                width:250
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: parent.height
                font.pixelSize: 16
                elide: Text.ElideRight
                color:BasicConfig.firstFontColor
            }
            //艺术家
            Label {
                id:songArtist
                width:200
                anchors.top: songTitle.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: parent.height
                font.pixelSize: 14
                elide: Text.ElideRight
                color:BasicConfig.secondFontColor
            }
            //总时长
            Label{
                id:songDuration
                width:implicitWidth
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color:BasicConfig.secondFontColor
            }

            //用于读取数据
            Loader{
                id:songInfoLoader
                property var modelfilename: filename
                // function show(){ //需要显示时使用这个
                //     sourceComponent = index && index <= endIndex ? mediaplayer : Rectangle
                // }
                // function hide(){ //需要消除mediaPlayer时使用这个
                //     sourceComponent = index && index <= endIndex ? mediaplayer : Rectangle
                // }
                sourceComponent: startIndex  <= index && index <= endIndex ? mediaplayer : Item
            }

            Component{
                id: mediaplayer
                Item{
                    //封面
                    Image {
                        id:imageId
                        x:10
                        y:10
                        width: 60
                        height: width
                        source: ""
                    }
                    MediaPlayer{
                        // id: mediaplayer
                        source: musicLoadPathDialog.currentFolder+"/"+filename
                        //元数据获得时
                        onMetaDataChanged: {
                                // 查看音乐相关信息
                                // console.log(metaData.keys()) //keys返回整数值
                                // var keys = metaData.keys()
                                // for(var i = 0 ; i < keys.length ;i++){
                                //     var keyEnum = keys[i]
                                //     // 将枚举键转换为字符串
                                //     var keyName =  metaData.metaDataKeyToString(keyEnum)
                                //     // 获取键对应的值 (返回 variant 类型)
                                //     var value = metaData.value(keyEnum)
                                //     // 输出key value信息
                                //     console.log("序列:"+ keyEnum +", 键名: " + keyName + ", 值: " + value)
                                // }
                                imageId.source = MusicPlayer.returnImageUrl(metaData.value(24)) //获取封面
                                songTitle.text = metaData.value(0) //获取歌名
                                console.log("歌名: "+songTitle.text)
                                songArtist.text = metaData.value(20)[0]  //获取歌手 metadata中存储的是数组
                                console.log("歌手: "+songArtist.text)
                                var seconds = metaData.value(10)/1000  // 获取歌曲秒数
                                songDuration.text = (seconds/60/10).toFixed(0).toString() +(seconds/60).toFixed(0) + ":"+(seconds%60/10).toFixed(0)+(seconds%10).toFixed(0) //时间显示
                                console.log("歌曲时长:"+songDuration.text)
                        }
                    }
                }
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.color = BasicConfig.secondFontColor
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    parent.color = BasicConfig.popupBackgroudColor
                    cursorShape = Qt.ArrowCursor
                }
                onClicked: {
                    songIndex = index
                    console.log(musicLoadPathDialog.currentFolder+"/"+filename)
                    MusicPlayer.setFilePath(musicLoadPathDialog.currentFolder+"/"+filename)
                }
            }
        }
        //test
    }
    Component.onCompleted: {
        MusicPlayer.start.connect(function(){
            playIcon.source = "qrc:/img/icon/pause.png"
        })
        MusicPlayer.stop.connect(function(){
            playIcon.source = "qrc:/img/icon/paly.png"
        })
        //链接音量相关设置
        MusicPlayer.volumeChanged.connect(function(){
            if(MusicPlayer.volume === 0){
                //音量按钮设置为静音
            }else{

            }
        })
        var songList = DirProvider.getDir("file:///F:/Music/Singles") //获取音乐列表
        musicLoadPathDialog.currentFolder="file:///F:/Music/Singles"
        for (var i = 0; i < songList.length; ++i) {
            songListModel.append({"title":songList[i].title,"filename":songList[i].filename})
        }
    }

}

/*
MediaPlayer.metaData中 keys和键名的对应关系
Index:13, 键名: Audio bit rate, 值: 0
Index:18, 键名: Album title, 值: daydream
Index:5, 键名: Date, 值: Invalid Date
Index:21, 键名: Track number, 值: 7
Index:20, 键名: Contributing artist, 值: Aimer
Index:14, 键名: Audio codec, 值: 4
Index:24, 键名: Thumbnail image, 值: QVariant(QImage, QImage(QSize(1400, 1400),format=QImage::Format_RGB32,depth=32,devicePixelRatio=1,bytesPerLine=5600,sizeInBytes=7840000))
Index:10, 键名: Duration, 值: 207934
Index:0, 键名: Title, 值: カタオモイ
*/
