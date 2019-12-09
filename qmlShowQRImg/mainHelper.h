#ifndef MAINHELPER_H
#define MAINHELPER_H

#include <QObject>
#include <QtQml>
#include "qrhelper.h"

#define MainHelper_REGISTE   \
{ \
    qmlRegisterType<MainHelper>("MainHelper",1,0,"MainHelperQml"); \
}


class MainHelper : public QObject
{
    Q_OBJECT
public:
    explicit MainHelper(QObject *parent = 0);

signals:

public slots:
    void setQRShowStr(QString showstr); //生成二维码图片显示

};

#endif // MAINHELPER_H
