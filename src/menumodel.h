#ifndef MENURECMODEL_H
#define MENURECMODEL_H

//#include <QObject>
//#include <QtSql>
#include "model.h"

class MenuModel : public Model
{
    Q_OBJECT
public:
    QStack<QSqlQuery> MyqueryStack;
    QStack<QString> HandleNameStack;
    int curTypeid;
    QString HandleName, curRecName;

    enum Roles  {Type = Qt::UserRole,SubType,Description,
                 RecName,RecMainProd,RecDescription,RecComment,RecRacion};
    explicit MenuModel(QStringList headers,QString initquery, QObject *parent = 0);

signals:
    void curRecNameChanged(QString curRecName);

public slots:
    void CatForCurTypeQuery(int index);
    void RecForCurCatQuery(int index);
    //void SingleRecQuery(QString name);
    QString curHandleName() const { return HandleName;}
    void LevelUp()
    {
        this->setQuery(MyqueryStack.pop());
        qDebug()<<"Size of stack: "<<MyqueryStack.size();
        HandleName = popMenuTitleName();
        qDebug()<<"curHandleName: " << HandleName;
    }
    void LevelDown(QString HandleName)
    {
        MyqueryStack.push(this->query());
        pushMenuTitleName(HandleName);
        qDebug()<<"Size of stack: "<<MyqueryStack.size() << " " << HandleNameStack.size();
    }
    QString popMenuTitleName(){return HandleNameStack.pop();}
    void pushMenuTitleName(QString name){HandleNameStack.push(name);}
    int StackQuerySize() {return MyqueryStack.size();}
};

#endif // MENURECMODEL_H
