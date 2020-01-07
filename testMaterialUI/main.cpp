#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "mainHelper.h"
#include <QSystemSemaphore>
#include <QSharedMemory>

#include "loginform.h"





int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    ///注册类
    LOGIN_FORM_REGISTE;
    MainHelper_REGISTE;

    ///





    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/MainUI/main.qml")));

    return app.exec();
}

