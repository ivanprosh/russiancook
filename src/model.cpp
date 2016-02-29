#include "model.h"

//explicit model(QObject *parent = 0):QSqlQueryModel(parent) {}
MenuRecModel::MenuRecModel(QStringList headers,QString initquery, QObject *parent):QSqlQueryModel(parent)
{
    hash = new QHash<int,QByteArray>;
    for(int curIndex = 0;curIndex<headers.size();curIndex++)
    {
        hash->insert(Qt::UserRole+curIndex, headers.value(curIndex).toUtf8());
    }

    this->setQuery(initquery);
    MyqueryStack.push(QSqlQuery("NULL"));
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
    return *hash;
}
QString MenuRecModel::userdata(int row,int role) const
{
    QSqlRecord r = record(row);
    return r.value(QString(hash->value(role))).toString();
}

void MenuRecModel::CatForCurTypeQuery(int index,QString Nameheader) //clicked item in menu list types
{
    QString MycurQuery = "SELECT Distinct %1 "
                                  "FROM ReceptType "
                                  "WHERE %2 = '%3' ";
    MycurQuery = MycurQuery.arg(Nameheader)
                                       .arg(QString(hash->value(MenuRecModel::Type)))
                                       .arg(userdata(index,MenuRecModel::Type));
    this->setQuery(MycurQuery);
}
