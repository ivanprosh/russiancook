#ifndef CURNAMEFORQUERY_H
#define CURNAMEFORQUERY_H

#include <QObject>
#include <QDebug>

class CurNameForQuery : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString input READ input WRITE setInput NOTIFY inputChanged)
    QString in;
public:

    CurNameForQuery(QObject *parent = 0);
    //для обработки сигналов с ListView
    QString input() const {return in;}
    void setInput(const QString&);
signals:
    void inputChanged(QString);
public slots:
};

#endif // CURNAMEFORQUERY_H
