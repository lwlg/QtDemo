#ifndef MAINHELPER_H
#define MAINHELPER_H

#include <QObject>
#include <QtQml>
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
    bool getIsPayAera(); //读取配置文件是否付费区or非付费区
};

#endif // MAINHELPER_H
