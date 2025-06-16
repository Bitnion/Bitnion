# Bitnion-Qt Project File (.pro)
# Qt GUI Wallet Configuration for Bitnion Core
# Replaces bitcoin-qt.pro with bitnion-qt.pro

TEMPLATE = app
TARGET = bitnion-qt

QT += core gui widgets network

CONFIG += c++11
CONFIG -= app_bundle

INCLUDEPATH += ../src \
               ../src/qt \
               ../src/json \
               ../src/leveldb/include \
               ../src/univalue \
               ../src/secp256k1/include

DEPENDPATH += ../src

SOURCES += \
    ../src/qt/bitnion.cpp \
    ../src/qt/bitniongui.cpp \
    ../src/qt/transactiontablemodel.cpp \
    ../src/qt/walletmodel.cpp \
    ../src/init.cpp \
    ../src/chainparams.cpp \
    ../src/pow.cpp \
    ../src/validation.cpp

HEADERS += \
    ../src/qt/bitniongui.h \
    ../src/qt/walletmodel.h \
    ../src/qt/transactiontablemodel.h \
    ../src/chainparams.h \
    ../src/pow.h \
    ../src/validation.h

RESOURCES += \
    ../src/qt/bitnion.qrc

FORMS += \
    ../src/qt/forms/overviewpage.ui \
    ../src/qt/forms/sendcoinsdialog.ui \
    ../src/qt/forms/receivecoinsdialog.ui

DEFINES += QT_GUI QT_STATICPLUGIN ENABLE_WALLET

# Optional: Add ZMQ if needed
unix:!macx: LIBS += -lzmq
