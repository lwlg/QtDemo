
QT       -= gui
QT       += core
QT += widgets


TARGET = $$qtLibraryTarget(hhEasyLog)
TEMPLATE = lib

CONFIG += c++11

DEFINES += EASYLOG_LIBRARY

#QMAKE_CXXFLAGS += -Wno-unused-parameter -Wno-unused-variable -Wno-sign-compare -Wno-type-limits

DESTDIR+= $$PWD/../bin
INCLUDEPATH += $$PWD/../header

HEADERS += \



SOURCES += \
    EasyLog.cpp

LIBS    += -L$$PWD/../bin



