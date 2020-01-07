TEMPLATE = app

QT += qml quick network serialport sql

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

TARGET = TestMaterialUI


SOURCES += main.cpp \
    loginform.cpp \
    mainHelper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

include( $$PWD/MaterialUI/MaterialUI.pri )

DESTDIR = $$PWD/../bin

#add include folder

HEADERS += \
    loginform.h \
    mainHelper.h \


LIBS    += -L$$PWD/../bin




