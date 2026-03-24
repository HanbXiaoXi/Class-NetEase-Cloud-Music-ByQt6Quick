#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "C/dataprovider.h"
#include "C/musicplayer.h"
#include <thread>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    DataProvider dataProvider; //创建json数据传输对象
    DataProvider dirProvider; //创建音乐路径搜索对象
    MusicPlayer musicPlayer; //创建musicPlayer 对象
    //
    // musicPlayer.setFilePath(QUrl("file:///F:/Music/Singles/FantasticYouth - 小喋日和.flac"));
    QQmlApplicationEngine engine;
    // QQuickStyle::setStyle("Material"); //设置风格
    // 数据传输
    engine.rootContext()->setContextProperty("DataProvider", &dataProvider);
    engine.rootContext()->setContextProperty("DirProvider", &dirProvider);
    engine.rootContext()->setContextProperty("MusicPlayer", &musicPlayer);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("CloudMusic", "Main");
    // 添加单例BasicConfig
    qmlRegisterSingletonType(QUrl("qrc:/Basic/BasicConfig.qml"),"BasicConfig",1,0,"BasicConfig");
    return app.exec();
}

