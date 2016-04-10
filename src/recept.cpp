#include "recept.h"

Recept::Recept(QObject *parent) : QObject(parent)
{}

void Recept::curRecNameChanged(QString curRecName)
{
    QSqlQuery query;
    QSqlRecord rec;
    qDebug() << "Current Rec is: " << curRecName;
    QString curID = "SELECT * FROM Recept "
                    "WHERE Name ='%1'";
    query.exec(curID.arg(curRecName));
    query.next();
    rec=query.record();

    curRecID = query.value(rec.indexOf("ID_REC")).toInt();
    description = query.value(rec.indexOf("Description")).toString();
    comment = query.value(rec.indexOf("Comment")).toString();

    qDebug() << "Description is: " << description;
    //формируем модель рецптов:
    this->composition.setCurQuery(curRecID);
}
