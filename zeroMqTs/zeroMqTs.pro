TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

SOURCES += main.cpp

DESTDIR += $$PWD/bin

INCLUDEPATH += $$PWD/include

LIBS += -L$$PWD/bin
LIBS += -lzmq-v120-mt-gd-4_0_4
