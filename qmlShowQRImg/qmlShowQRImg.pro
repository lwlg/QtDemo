TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    imageprovider.cpp \
    qrhelper.cpp \
    mainHelper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    imageprovider.h \
    qrhelper.h \
    mainHelper.h

include(qrencode.pri)

