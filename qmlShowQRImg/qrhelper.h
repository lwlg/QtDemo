/*
    https://fukuchi.org/works/qrencode/manual/index.html
*/

#ifndef QRHELPER_H
#define QRHELPER_H

#include <QObject>
#include <QPixmap>

class QRHelper : public QObject
{
    Q_OBJECT
public:
    explicit QRHelper(QObject *parent = 0);

    static QPixmap generateQR(QString strContent, int width = 300, int height = 300);

    static void setQRContent(QString strContent);

    static QString getQRContent();

signals:

public slots:

private:
    static QString m_strtxt;
};

#endif // QRHELPER_H
