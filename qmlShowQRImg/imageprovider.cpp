#include "imageprovider.h"


ImageProvider::ImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}

ImageProvider::~ImageProvider()
{

}


QPixmap ImageProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    QPixmap imgpix = QRHelper::generateQR(QRHelper::getQRContent());

    return imgpix;
}
