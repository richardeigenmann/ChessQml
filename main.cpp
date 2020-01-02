#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "bindobj.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    BindObj my_bindObj;
    auto root_context = engine.rootContext();
    root_context->setContextProperty( "bindObject", &my_bindObj);

    engine.load(url);

    return app.exec();
}
