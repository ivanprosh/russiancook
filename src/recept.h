#ifndef CURNAMEFORQUERY_H
#define CURNAMEFORQUERY_H

#include <QObject>
#include <QDebug>
#include "compositiontable.h"

class Recept : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString description READ descValue NOTIFY descriptionChanged)
    QString description,comment;
public:
    CompositionTable composition;
    Recept(QObject *parent = 0);
    //для обработки сигналов с ListView
    int curRecID;
    QString curRecName;

signals:
    //void descriptionChanged(QString);
public slots:
    void curRecNameChanged(QString curRecName);
    QString descValue() const  { return description; }
    QString comValue() const  { return comment; }
};

#endif // CURNAMEFORQUERY_H
