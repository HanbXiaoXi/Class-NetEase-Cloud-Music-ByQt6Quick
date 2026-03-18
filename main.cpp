#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "C/dataprovider.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    DataProvider provider; //创建json数据传输对象
    provider.setabsolutePath("D:/Code/QT_CPP/CloudMusic");
    QQmlApplicationEngine engine;
    // QQuickStyle::setStyle("Material"); //设置风格
    // 数据传输
    engine.rootContext()->setContextProperty("DataProvider", &provider);
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
