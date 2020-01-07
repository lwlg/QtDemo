/*
  说 明:硬件自检QML接口
  修 改:
*/
#ifndef SELFCHECK_H
#define SELFCHECK_H

#include <QObject>
#include <QtQml>


#define SELFCHECK_REGISTE    {qmlRegisterType<SelfCheck>("com.hhkj.SelfCheck",1,0,"SelfCheckQml");}



class SelfCheck : public QObject
{
    Q_OBJECT

public:
    explicit SelfCheck(QObject *parent = 0);



signals:

public slots:


private:

};

#endif // SELFCHECK_H
