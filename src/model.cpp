#include "model.h"

//explicit model(QObject *parent = 0):QSqlQueryModel(parent) {}
MenuRecModel::MenuRecModel(QStringList headers, QObject *parent):QSqlQueryModel(parent)
{
    hash = new QHash<int,QByteArray>;
    for(int curIndex = 0;curIndex<headers.size();curIndex++)
    {
        //QByteArray arr;
        hash->insert(Qt::UserRole+curIndex, headers.value(curIndex).toUtf8());
        //qDebug() << "Roles role is:" << Qt::UserRole+curIndex << " value:" << arr.append(headers.value(curIndex));
    }
    //Myquery = query;
    //hash->insert(Qt::UserRole + 1,  QByteArray("otherRoleName"));
}

QVariant MenuRecModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole) {
              return QSqlQueryModel::data(index, role);
           }
    return userdata(index.row(),role);
}

QHash<int, QByteArray> MenuRecModel::roleNames() const
{
    //QHash<int,QByteArray> roles;
    //roles[Name] = "Name";
    //return roles;
    return *hash;
}
QString MenuRecModel::userdata(int row,int role) const
{
    //qDebug()<<"role is" << role << "row:" << row << "hash->value(role):" << hash->value(role);
    QSqlRecord r = record(row);
    return r.value(QString(hash->value(role))).toString();
}

void MenuRecModel::CatForCurTypeQuery(int index,QString Nameheader) //clicked item in menu list types
{
    Myquery.prepare("SELECT Distinct :Column "
                    "FROM ReceptType "
                    "WHERE :FilterColumn = :Value; ");
//    qDebug() <<"Filter is:" << Nameheader.toUtf8();
//    qDebug() <<"Role is: " << hash->key(Nameheader.toUtf8());
    Myquery.bindValue(":Column",Nameheader); //Column in table for output
    Myquery.bindValue(":FilterColumn",QString(hash->value(MenuRecModel::Type))); //Column for filter condition
    Myquery.bindValue(":Value",userdata(index,MenuRecModel::Type));//Value for filter(name type of recept)
    qDebug() << "curQuery is:" << Myquery.value(0) << Myquery.value(1) << Myquery.value(2);
    this->setQuery(Myquery);
}
