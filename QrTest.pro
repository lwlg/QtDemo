#-------------------------------------------------
#
# Project created by QtCreator 2019-12-06T13:36:15
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = QrTest
TEMPLATE = app

include(qrencode.pri)


SOURCES += main.cpp\
        mainwindow.cpp \
    qrhelper.cpp



HEADERS  += mainwindow.h \
    qrhelper.h



FORMS    += mainwindow.ui
