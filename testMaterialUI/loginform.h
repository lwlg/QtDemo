#ifndef LOGINFORM_H
#define LOGINFORM_H

#include <QObject>
#include <QtQml>
#define LOGIN_FORM_REGISTE   \
{ \
    qmlRegisterType<LoginForm>("LoginForm",1,0,"LoginQml"); \
}


class LoginForm : public QObject
{
    Q_OBJECT
public:
    explicit LoginForm(QObject *parent = 0);

    Q_INVOKABLE void MemFunc();

    Q_INVOKABLE void checkPWD(QVariant username , QVariant pwd);

signals:

public slots:
    void shutdown();

//    QString restart();
    QMap<QString,QString> restart();

    QJsonObject restart11();
};

#endif // LOGINFORM_H
