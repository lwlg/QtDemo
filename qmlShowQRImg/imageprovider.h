/*
    说 明: 用于qml中显示自动生成的图片

    [1] CPP文件:
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    ImageProvider *myImg = new ImageProvider();
    engine.addImageProvider("ImageProvider", myImg);

    [2] qml文件:
    Image {
        id:img_preview
        cache: false;  //取消缓存
        anchors.centerIn: parent
        source: ""
        }
*/

#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QPainter>
#include "qrhelper.h"


class ImageProvider : public QQuickImageProvider
{
public:
    ImageProvider();

    ~ImageProvider();

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
private:

};

#endif // IMAGEPROVIDER_H
