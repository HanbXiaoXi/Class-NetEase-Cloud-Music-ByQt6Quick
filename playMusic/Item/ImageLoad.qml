import QtQuick
import QtMultimedia
import "qrc:/Basic"
import "qrc:/rightPage/setting/items"
import QtQuick.Dialogs

MediaPlayer{
    id: mediaplayer
    source: musicLoadPathDialog.currentFolder+"/"+filename
    onMetaDataChanged: {
        console.log(mediaplayer.metaData.keys()) //keys返回整数值
        var keys = mediaplayer.metaData.keys()
        for(var i = 0 ; i < keys.length ;i++){
            var keyEnum = keys[i]
            // 将枚举键转换为字符串
            var keyName =  metaData.metaDataKeyToString(keyEnum)
            // 获取键对应的值 (返回 variant 类型)
            var value = metaData.value(keyEnum)
            // 输出key value信息
            console.log("序列:"+ keyEnum +", 键名: " + keyName + ", 值: " + value)
        }
        songArtist.text = metaData.value(20)
        songTitle.text = metaData.value(0)
        var seconds = metaData.value(10)/1000  // 获取歌曲秒数
        songDuration.text = seconds/60
    }
}
