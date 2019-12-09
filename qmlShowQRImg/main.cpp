#include <QApplication>
#include <QQmlApplicationEngine>
#include "imageprovider.h"
#include "mainHelper.h"



int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    MainHelper_REGISTE;


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    ImageProvider *myImg = new ImageProvider();
    engine.addImageProvider("ImageProvider", myImg);

    return app.exec();
}

