#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QtSql>

class MenuRecModel : public QSqlQueryModel
{
    Q_OBJECT
    QStack<QSqlQuery> MyqueryStack;
    QHash<int,QByteArray> *hash;
public:
    enum Roles  {Type = Qt::UserRole,SubType,Description};
    explicit MenuRecModel(QStringList headers,QString initquery, QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QString userdata(int row,int role) const;
protected:
    QHash<int,QByteArray> roleNames() const;
signals:

public slots:
    void CatForCurTypeQuery(int index,QString Nameheader);
    void LevelUp()  {this->setQuery(MyqueryStack.pop());
                     qDebug()<<"Size of stack: "<<MyqueryStack.size();}
    void LevelDown() {MyqueryStack.push(this->query());
                      qDebug()<<"Size of stack: "<<MyqueryStack.size();}
    int StackQuerySize() {return MyqueryStack.size();}
};

#endif // MODEL_H
