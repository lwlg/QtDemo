#include "mainHelper.h"

MainHelper::MainHelper(QObject *parent) : QObject(parent)
{

}


void MainHelper::setQRShowStr(QString showstr)
{
    QRHelper::setQRContent(showstr);
}
