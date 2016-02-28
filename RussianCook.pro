TEMPLATE = app

QT += qml quick sql
TARGET = RusCook
!no_desktop: QT += widgets

CONFIG += c++11

include(src/src.pri)

OTHER_FILES += \
    main.qml \
    content/AndroidDelegate.qml \
    content/ReceptsTypePage.qml \
    content/ReceptCategoryPage.qml

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

