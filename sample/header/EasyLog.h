#ifndef EASYLOG_H
#define EASYLOG_H
 
#include <QFile>
#include <QMutex>
#include <QDateTime>
#include <QTextStream>
#include <stdio.h>
#include <QMap>

#if defined(EASYLOG_LIBRARY)
#  define EASYLOG_LIBRARY_EXPORT Q_DECL_EXPORT
#else
#  define EASYLOG_LIBRARY_EXPORT Q_DECL_IMPORT
#endif


 
#define LOG_INFO        0
#define LOG_WARNING     1
#define LOG_ERROR       2
 
 
#define DETAIL_INFO  QString::fromLocal8Bit("File:%1 ,Line:%2 ,Func:%3 >>").arg(__FILE__).arg(__LINE__).arg(__FUNCTION__)
 
#define LOG_IDENTIFIER ".log"
 
#define LOGERROR(_log)   EasyLOG->writeLog(_log, DETAIL_INFO, LOG_ERROR)
#define LOGINFO(_log)    EasyLOG->writeLog(_log, DETAIL_INFO, LOG_INFO)
#define LOGWRANING(_log) EasyLOG->writeLog(_log, DETAIL_INFO, LOG_WARNING)
 
//==============================================================================
#define EasyLOG EasyLog::getInstance("AppTrace")
 
//#define SSTLOG  EasyLog::getInstance("SSTrace")
//==============================================================================
 
 
class EASYLOG_LIBRARY_EXPORT EasyLog
{
public:
    static EasyLog *getInstance(QString logPrefix);
 
    void out2File(QString format, ...);//增强型输出类似printf

    void writeLog(QString _log, QString _details = DETAIL_INFO, int _flag = LOG_INFO);
 
    void InitLog();
 
    void DelLogFile(QDate begin,QDate end,QString path);
    
private:
    EasyLog(QString prefix);
 
    ~EasyLog();
 
    void openLog();
private:
    static EasyLog      instance;
    QString             m_fileDate;
    QFile               m_log;
    QMutex              m_mutex;
    QTextStream         m_stream;
    QMap<QString,EasyLog*> m_mapLog;
    QString             m_logPrefix;
 
    QString             m_logPath;
 
};
#endif // EASYLOG_H
