#include "model.h"

//explicit model(QObject *parent = 0):QSqlQueryModel(parent) {}
model::model(QString query, QObject *parent):QSqlQueryModel(parent)
{
    hash = new QHash<int,QByteArray>;
    hash->insert(Qt::UserRole, QByteArray("Name"));
    Myquery = query;
    //hash->insert(Qt::UserRole + 1,  QByteArray("otherRoleName"));
}

QVariant model::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole) {
              return QSqlQueryModel::data(index, role);
           }
           QSqlRecord r = record(index.row());
           return r.value(QString(hash->value(role))).toString();
}

QHash<int, QByteArray> model::roleNames() const
{
    //QHash<int,QByteArray> roles;
    //roles[Name] = "Name";
    //return roles;
    return *hash;
}
