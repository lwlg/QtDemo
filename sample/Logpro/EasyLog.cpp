#include "EasyLog.h"
#include <QDir>
#include <QDirIterator>
#include <QSettings>
#include <QDebug>
#include <QThread>
#include <QApplication>
 
EasyLog EasyLog::instance("");
 
EasyLog::EasyLog(QString prefix)
{
    this->m_logPrefix = prefix;
 
    if (prefix != "") {
 
        InitLog();
    }
 
}
 
EasyLog::~EasyLog()
{
    if (!m_mapLog.empty()) {
 
        QMapIterator<QString, EasyLog*> iter(m_mapLog);
 
        while (iter.hasNext()) {
            iter.next();
            EasyLog* elog = iter.value();
            if (elog != NULL) {
                delete elog;
                elog = NULL;
            }
        }
        this->m_mapLog.clear();
    }
}
 
EasyLog *EasyLog::getInstance(QString logPrefix)
{
    if (instance.m_mapLog[logPrefix] == NULL) {
        EasyLog* log = new EasyLog(logPrefix);
        instance.m_mapLog[logPrefix] = log;
    }
 
    return instance.m_mapLog[logPrefix];
}

void EasyLog::out2File(QString format,...)
{
    // 数据体
    va_list args;
    char    buffer[3000];

    va_start( args, format );
    vsprintf(buffer, (format.toStdString().data()), args);
    QString sData = buffer;
    va_end(args);

    this->writeLog(sData);
}
 
void EasyLog::InitLog()
{
    //[1] 进入日志路径
    QDir _applicationDir(QApplication::applicationDirPath());
 
    if (!_applicationDir.exists(_applicationDir.path() + "/log"))
    {
        _applicationDir.mkpath(_applicationDir.path() + "/log");
    }
    _applicationDir.cd("log");
    this->m_logPath = _applicationDir.path();
 
    qDebug()<<"logpath:"<<this->m_logPath << this->m_logPrefix;
 
 
    //[2] 删除前30天的日志
    QDate delDate = QDate::currentDate().addDays(-30);
    DelLogFile(delDate,QDate::currentDate(),m_logPath +"/");
 
    //[3] 打开文件
    this->openLog();
}
 
void EasyLog::DelLogFile(QDate begintime, QDate endtime, QString path)
{
    QDir dir(path);
    QStringList nameFilters;
    nameFilters << "*.log";
    QStringList files = dir.entryList(nameFilters, QDir::Files|QDir::Readable, QDir::Name);
 
    if(dir.count() == 0)
    {
        return;
    }
 
    for (int var = 0; var < files.count(); var++)
    {
        QString fname = files[var];
 
 
        QStringList tmpFnamelst = fname.split("_");
 
        QString aname = tmpFnamelst.at(1);
 
        QDate tmpDate = QDate::fromString(aname.left(10), "yyyy-MM-dd");
 
 
        if ( tmpDate.isValid() && tmpDate > begintime && tmpDate <= endtime) {
 
            qDebug()<<fname<<" save.";
 
        }else{
            dir.remove(files[var]);
            qDebug()<<"@del file name:"<<fname<<"   "<<",del succ";
        }
    }
 
}
 
void EasyLog::openLog()
{
    if (m_logPrefix == "") {
        return;
    }
 
    QString date  = QDate::currentDate().toString("yyyy-MM-dd");
    QString fileNamelog;
    fileNamelog += this->m_logPrefix;
    fileNamelog += "_";
    fileNamelog += date;
    fileNamelog += LOG_IDENTIFIER;
    m_log.setFileName(m_logPath + "/" + fileNamelog);
 
    // 进行日期对比；查看是否要新建一个日志
    QString sDate = QDateTime::currentDateTime().toString("yyyy_MM_dd");
    if (m_fileDate != sDate)
    {
        this->m_fileDate = sDate;
 
        if (m_log.open(QIODevice::ReadWrite | QIODevice::Text | QFile::Append))
        {
            m_stream.setDevice(&m_log);
            QString _logTitle = QString::asprintf("//initial log success\n\n");
            m_stream << _logTitle;
        }
        else
        {
            QString _err = m_log.errorString();
        }
    }
}
 
void EasyLog::writeLog(QString _log, QString _details, int _flag)
{
    if (this->m_logPrefix == "") {
        return;
    }
 
    QDateTime dtime = QDateTime::currentDateTime();
    QLocale locale = QLocale::English;//指定显示
 
    QString stemp;
    stemp.sprintf("%s.%03d threadId %d,",
                                      (locale.toString(dtime,"yyyy-MM-dd hh:mm:ss").toStdString().c_str()),
                                      dtime.time().msec(),
                                      (int)QThread::currentThreadId());
 
    m_mutex.lock();
    if (_flag == LOG_INFO)
    {
       m_stream <<"[INFO] " << stemp << " " <<  _details<< _log<< "\n";
    }
    else  if (_flag == LOG_WARNING)
    {
       m_stream << "[WARN] " <<  stemp << " " << _details << _log<< "\n";
    }
    else if (_flag == LOG_ERROR)
    {
       m_stream << "[ERR] " << stemp << " " << _details << _log<< "\n";
    }
    m_stream.flush();
    m_log.flush();
 
    m_mutex.unlock();
}
