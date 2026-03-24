#include "dataprovider.h"
#include "json.hpp"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include <regex>
#include <QAudioOutput>
#include <QMediaPlayer>
#include <QMediaMetaData>

#include "libzplay.h"
#pragma comment(lib,"libzplay")
using namespace libZPlay;
using std::filesystem::current_path;
using json = nlohmann::json;

DataProvider::DataProvider(QObject *parent):
    QObject(parent) {
    qDebug() << "DataProvider Created";
    std::string  cPath = current_path().string(); //path类型转换为string类型
    cPath = std::regex_replace(cPath,std::regex("\\\\"),"/");
    cPath = std::regex_replace(cPath,std::regex("CloudMusic.*"),"CloudMusic");
    m_absolutePath = QString::fromStdString(cPath);
    qDebug() << m_absolutePath;
}

QVariantList DataProvider::getData(QUrl url, QVariantList searchList){
    std::ifstream  jsonfile;
    QVariantList list;
    qDebug() << url;
    if (url.isLocalFile()) {
        QString local = url.toLocalFile();
        qDebug() << "Local file path:" << local;
        jsonfile.open(local.toStdString(),std::ios::in); //传入地址
    }

    if (!jsonfile.is_open())
    {
        qDebug() << "Error opening file\n";
        return list;
    }
    json j;
    jsonfile >> j;
    //json不是队列的情况
    if (!j.is_array()) {
        qDebug() << "JSON is not an array\n";
        return list;
    }
    std::vector<std::string> searchs;

    //将需要的键名添加
    for(const auto& it : searchList){
        searchs.push_back(it.toString().toStdString());
    }
    for(const auto& item: j){
        if (!item.is_object()) {
            std::cerr << "Item is not an object, skipping\n";
            continue;
        }
        {
            QVariantMap map;
            for(std::string& it : searchs){
                if(item.contains(it)){
                    // qDebug() << item[it];
                    map[QString::fromStdString(it)] = QString::fromStdString(item[it]);
                }
            }
            qDebug() <<map;
            //添加对象
            list.push_back(map);
        }
    }
    return list;
}

// //用于快速map一首歌的信息
// QVariantMap songInfo(QUrl sourceFile,ZPlay* zplay,TID3InfoEx& id3_info){
//     QVariantMap map;
//     if(zplay->LoadFileID3Ex(sourceFile.toString().mid(8).toStdString().c_str(), sfAutodetect, &id3_info, 1)) //加载file的ID3v2标签信息
//     {
//         QVariant titleVar = QString::fromStdString(std::string(id3_info.Title));
//         QVariant artistVar = QString::fromStdString(std::string(id3_info.Artist));
//         QVariant albumVar = QString::fromStdString(std::string(id3_info.Album));
//         qDebug() << titleVar;
//         map["title"] = titleVar;
//         map["artist"] = artistVar;
//         map["album"] = albumVar;
//         map["filepath"] = sourceFile;
//         return map;
//     }
//     return map;
// }

// //  map一首歌歌名和文件位置
// //快速读取文件夹中存在的音乐文件
// QVariantList DataProvider::getDir(QUrl source)
// {
//     QVariantList list;
//     QString url = source.toString().mid(8);
//     // 创建类实例
//     ZPlay* zplay = CreateZPlay();;
//     // 创建ID3v2标签信息
//     TID3InfoEx id3_info;
//     QDir dir(url);
//     if(dir.exists() == false){ //检测文件夹是否存在
//         return list;
//     }
//     QFileInfoList fileList = dir.entryInfoList(QDir::Files);
//     for(const auto& element: fileList ){
//         QVariantMap map;
//         if(element.suffix() == "mp3"){
//             qDebug() << url+"/"+element.baseName()+"."+element.suffix();
//             list.append(songInfo(source,zplay,id3_info));
//         }else if(element.suffix() == "flac"){
//             qDebug() << url+"/"+element.baseName()+"."+element.suffix();
//             list.append(songInfo(source,zplay,id3_info));
//         }
//     }
//     return list;
// }

QVariantList DataProvider::getDir(QUrl source)
{
    QVariantList list;
    QString url = source.toString().mid(8);
    QDir dir(url);
    if(dir.exists() == false){ //检测文件夹是否存在
        return list;
    }
    QFileInfoList fileList = dir.entryInfoList(QDir::Files);
    for(qsizetype i = 0; i < fileList .size(); ++i){
        auto& element = fileList[i];
        QVariantMap map;
        if(element.suffix() == "mp3"){
            qDebug() << url+"/"+element.baseName()+"."+element.suffix();
            map["title"] =  element.baseName();
            map["filename"] = element.fileName();
            list.append(map);
        }else if(element.suffix() == "flac"){
            qDebug() << url+"/"+element.baseName()+"."+element.suffix();
            map["title"] =  element.baseName();
            map["filename"] = element.fileName();
            list.append(map);
        }
    }
    return list;
}

QString DataProvider::absolutePath() const
{
    return m_absolutePath;
}

void DataProvider::setabsolutePath(const QString &newAbsolutePath)
{
    if (m_absolutePath == newAbsolutePath)
        return;
    m_absolutePath = newAbsolutePath;
    emit absolutePathChanged();
}
