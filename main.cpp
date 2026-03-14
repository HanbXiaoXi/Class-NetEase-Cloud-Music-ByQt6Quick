#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    // QQuickStyle::setStyle("Material"); //设置风格
    engine.addImportPath("qrc:/leftPage/LeftPage.qml");
    engine.addImportPath("qrc:/rightPage/RightPage.qml");
    engine.addImportPath("qrc:/playMusic/PlayMusic.qml");
    engine.addImportPath("qrc:/commonUI/CloudWindow.qml");
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("CloudMusic", "Main");

    return app.exec();
}
