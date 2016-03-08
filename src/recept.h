#ifndef CURNAMEFORQUERY_H
#define CURNAMEFORQUERY_H

#include <QObject>
#include <QDebug>
#include "compositiontable.h"

class Recept : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString input READ input WRITE setInput NOTIFY inputChanged)
    QString in;
public:
    CompositionTable composition;
    Recept(QObject *parent = 0);
    //для обработки сигналов с ListView
    QString input() const {return in;}
    void setInput(const QString&);
    QString curRecName;
signals:
    void inputChanged(QString);
public slots:
    void curRecNameChanged(QString curRecName);
};

#endif // CURNAMEFORQUERY_H
