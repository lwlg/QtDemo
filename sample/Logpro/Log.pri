
LOG_ROOT = $$PWD/../bin
win32:CONFIG(release, debug|release): LIBS += -L$${LOG_ROOT} -lhhEasyLog
else:win32:CONFIG(debug, debug|release): LIBS += -L$${LOG_ROOT} -lhhEasyLogd
