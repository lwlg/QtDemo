#include "loginform.h"

LoginForm::LoginForm(QObject *parent) : QObject(parent)
{

}

void LoginForm::MemFunc()
{
    qDebug("This is C++ member function");
}

void LoginForm::checkPWD(QVariant username,QVariant pwd)
{
     QString strinfo = "username:" + username.toString()+"\t pwd:" + pwd.toString();
     qDebug()<<strinfo;
}

void LoginForm::shutdown()
{
    qDebug("shut down c++");

    exit(0);
}

QMap<QString,QString> LoginForm::restart()
{
    QMap<QString,QString> retMap;

    retMap["usrname"]="100333";
    retMap["pwd"]="100333";
    return retMap;
}

QJsonObject LoginForm::restart11()
{
    QJsonObject json;
    json.insert("usrname","100334");
    json.insert("pwd","000000");
    return json;
}

