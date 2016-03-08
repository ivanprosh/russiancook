#include "compositiontable.h"

CompositionTable::CompositionTable(QObject *parent) : QSqlQueryModel(parent)
{
    hash = new QHash<int,QByteArray>;

    hash->insert(ProductName, "ProductName");
    hash->insert(ProductCount, "Count");
    hash->insert(ProductMetrics, "Metric");
}

QVariant CompositionTable::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole) {
              return QSqlQueryModel::data(index, role);
           }
    return userdata(index.row(),role);
}

QHash<int, QByteArray> CompositionTable::roleNames() const
{
    return *hash;
}
QString CompositionTable::userdata(int row,int role) const
{
    QSqlRecord r = record(row);
    return r.value(QString(hash->value(role))).toString();
}

void CompositionTable::setCurQuery(int RecID)
{
    QString CurComposTableQ = "SELECT Product.Name as ProductName, "
                              "Composition.Count,"
                              "Product.Metric as Metric "
                              "FROM Composition LEFT JOIN Product ON Product.ID_PR = Composition.ID_PR "
                              "LEFT JOIN Recept ON Recept.ID_REC = Composition.ID_REC "
                              "WHERE Composition.ID_REC='%1';";
    this->setQuery(CurComposTableQ.arg(RecID));
    qDebug()<<"In composition setCurQuery";
}


