#include "recept.h"

Recept::Recept(QObject *parent) : QObject(parent)
{}

void Recept::setInput(const QString &newQuery)
{
    in = newQuery;
    //this->setQuery(Myquery.arg(input));
    emit inputChanged(in);
    qDebug() << "Input is: " << in;
}

void Recept::curRecNameChanged(QString curRecName)
{
    QSqlQuery query;
    qDebug() << "Current Rec is: " << curRecName;
    QString curID = "SELECT ID_REC FROM Recept "
                    "WHERE Name ='%1'";
    query.exec(curID.arg(curRecName));
    query.next();
    this->composition.setCurQuery(query.value(0).toInt());
}
