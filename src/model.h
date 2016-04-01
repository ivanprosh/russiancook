#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QtSql>

class Model : public QSqlQueryModel
{
    Q_OBJECT
    //QStack<QSqlQuery> MyqueryStack;
    //QStack<QString> HandleNameStack;

    //int curTypeid;
    //QString HandleName;
public:
//    enum Roles  {Type = Qt::UserRole,SubType,Description,
//                 RecName,RecMainProd,RecDescription,RecComment,RecRacion};
    explicit Model(QStringList headers,QString initquery, QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QString userdata(int row,int role) const;
    //QString curRecName;
protected:
    QHash<int,QByteArray> *hash;
    QHash<int,QByteArray> roleNames() const;
signals:
    //void curRecNameChanged(QString curRecName,QString MainProd,QString Racion);
public slots:
    //void CatForCurTypeQuery(int index);
    //void RecForCurCatQuery(int index);
    //void SingleRecQuery(int index);
    //QString curHandleName() const { return HandleName;}
    //int StackQuerySize() {return MyqueryStack.size();}
};

#endif // MODEL_H
