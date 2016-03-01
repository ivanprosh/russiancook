#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>

class Database: public QObject
{
private:
    QString name;
public:
    explicit Database(QString Name, QObject *parent = 0):QObject(parent)
                                                        ,name(Name){}
    bool createConnection();
};

#endif // DATABASE_H
