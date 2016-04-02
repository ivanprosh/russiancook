#include "model.h"

//explicit model(QObject *parent = 0):QSqlQueryModel(parent) {}
Model::Model(QStringList headers,QString initquery, QObject *parent):QSqlQueryModel(parent)
{
    hash = new QHash<int,QByteArray>;
    for(int curIndex = 0;curIndex<headers.size();curIndex++)
    {
        hash->insert(Qt::UserRole+curIndex, headers.value(curIndex).toUtf8());
    }

    if(!initquery.isEmpty()) this->setQuery(initquery);
    //MyqueryStack.push(QSqlQuery("NULL"));
    //HandleName = "Русская кухня";
    //HandleNameStack.push(HandleName);
}

QVariant Model::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole) {
              return QSqlQueryModel::data(index, role);
           }
    return userdata(index.row(),role);
}

QHash<int, QByteArray> Model::roleNames() const
{
    return *hash;
}
QString Model::userdata(int row,int role) const
{
    QSqlRecord r = record(row);
    return r.value(QString(hash->value(role))).toString();
}

//void Model::CatForCurTypeQuery(int index) //clicked item in menu list types
//{
//    QSqlRecord rec;
//    QSqlQuery query;
//    QString MycurQuery = "SELECT Distinct ID_Type,%1 "
//                                  "FROM ReceptType "
//                                  "WHERE %2 = '%3' ";
//    MycurQuery = MycurQuery.arg("SubType")
//                           .arg(QString(hash->value(Model::Type)))
//                           .arg(userdata(index,Model::Type));
//    //запоминаем id текущей пары из словаря Тип-Категория
//    query.exec(MycurQuery);
//    rec = query.record();
//    query.next();
//    curTypeid = query.value(rec.indexOf("ID_Type")).toInt();

//    this->setQuery(MycurQuery);
//}
//void Model::RecForCurCatQuery(int index) //clicked item in menu list types
//{
//    QString MycurQuery = "SELECT Recept.Name, "
//                         "Product.Name as MainProd,"
//                         "Recept.Racion "
//                         "FROM Recept LEFT JOIN Product ON Product.ID_PR = Recept.ID_MainPr "
//                         "WHERE Recept.Type = (SELECT ID_Type FROM ReceptType WHERE SubType='%1');";
//    MycurQuery = MycurQuery.arg(userdata(index,Model::SubType));
//    this->setQuery(MycurQuery);
//}
//void Model::SingleRecQuery(int index)
//{
//    QString Racion = userdata(index,Model::RecRacion);
//    QString MainProd = userdata(index,Model::RecMainProd);
//    curRecName = userdata(index,Model::RecName);
//    qDebug() << "Имя: " << curRecName << "Racion: " << Racion << "MainProd: " << MainProd;
//    emit curRecNameChanged(curRecName,MainProd,Racion);
//}

