#include "dataprovider.h"
#include "json.hpp"
#include <filesystem>
#include <fstream>
#include <iostream>
#include <vector>
#include <regex>
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
        jsonfile.open(local.toStdString(),std::ios::in);
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
            list.push_back(QVariant::fromValue(map));
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
