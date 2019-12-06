#include "qrhelper.h"
#include <QPainter>


extern "C"{
    #include "qrencode.h"
}


QRHelper::QRHelper(QObject *parent) : QObject(parent)
{

}

QPixmap QRHelper::generateQR(QString strContent ,int width,int height)
{
    //[1]
    QPixmap GenQRPixmap;
    QRcode *qrcode; //二维码数据
    qrcode  = QRcode_encodeString(strContent.toStdString().c_str(),2,QR_ECLEVEL_Q,QR_MODE_8,1);

    qint32 qrcode_width = qrcode->width > 0 ? qrcode->width : 1;

    //[2]
    double scale_x = (double)width / (double)qrcode_width; //二维码图片的缩放比例
    double scale_y =(double) height /(double) qrcode_width;
    QImage qrImg = QImage(width, height, QImage::Format_ARGB32);

    QPainter painter(&qrImg);
    QColor background(Qt::white);
    painter.setBrush(background);
    painter.setPen(Qt::NoPen);
    painter.drawRect(0, 0, width, height);
    QColor foreground(Qt::black);
    painter.setBrush(foreground);

    for( qint32 y = 0; y < qrcode_width; y ++)
    {
        for(qint32 x = 0; x < qrcode_width; x++)
        {
            unsigned char b = qrcode->data[y * qrcode_width + x];
            if(b & 0x01)
            {
                QRectF r(x * scale_x, y * scale_y, scale_x, scale_y);
                painter.drawRects(&r, 1);
            }
        }
    }

    //[3]
    GenQRPixmap = QPixmap::fromImage(qrImg);

    return GenQRPixmap;
}

