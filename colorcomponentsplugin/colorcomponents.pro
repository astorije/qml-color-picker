TEMPLATE = lib
CONFIG += qt plugin
QT += declarative

TARGET  = colorcomponentsplugin

DESTDIR = ../plugin
OBJECTS_DIR = tmp
MOC_DIR = tmp

HEADERS += colorcomponents.h \
        colorcomponentsplugin.h

SOURCES += colorcomponents.cpp \
        colorcomponentsplugin.cpp

symbian {
 include($$QT_SOURCE_TREE/examples/symbianpkgrules.pri)
 TARGET.EPOCALLOWDLLDATA = 1
}