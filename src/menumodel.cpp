#include "menumodel.h"

MenuModel::MenuModel(QStringList headers,QString initquery, QObject *parent):Model(headers,initquery,parent)
{
    MyqueryStack.push(QSqlQuery("NULL"));
    //HandleName = "Русская кухня";
    //HandleNameStack.push(HandleName);
}

void MenuModel::CatForCurTypeQuery(int index) //clicked item in menu list types
{
    QSqlRecord rec;
    QSqlQuery query;
    QString MycurQuery = "SELECT Distinct ID_Type,%1 "
                                  "FROM ReceptType "
                                  "WHERE %2 = '%3' ";
    MycurQuery = MycurQuery.arg("SubType")
                           .arg(QString(hash->value(MenuModel::Type)))
                           .arg(userdata(index,MenuModel::Type));
    //запоминаем id текущей пары из словаря Тип-Категория
    query.exec(MycurQuery);
    rec = query.record();
    query.next();
    curTypeid = query.value(rec.indexOf("ID_Type")).toInt();

    this->setQuery(MycurQuery);
}
void MenuModel::RecForCurCatQuery(int index) //clicked item in menu list types
{
    QString MycurQuery = "SELECT Recept.Name, "
                         "Product.Name as MainProd,"
                         "Recept.Racion "
                         "FROM Recept LEFT JOIN Product ON Product.ID_PR = Recept.ID_MainPr "
                         "WHERE Recept.Type = (SELECT ID_Type FROM ReceptType WHERE SubType='%1');";
    MycurQuery = MycurQuery.arg(userdata(index,MenuModel::SubType));
    this->setQuery(MycurQuery);
}
void MenuModel::SingleRecQuery(int index)
{
    QString Racion = userdata(index,MenuModel::RecRacion);
    QString MainProd = userdata(index,MenuModel::RecMainProd);
    curRecName = userdata(index,MenuModel::RecName);
    qDebug() << "Имя: " << curRecName << "Racion: " << Racion << "MainProd: " << MainProd;
    emit curRecNameChanged(curRecName,MainProd,Racion);
}




