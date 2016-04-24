#ifndef SQLLISTAVAILVAL_H
#define SQLLISTAVAILVAL_H

#include "model.h"

class SqlListAvailVal : public Model
{
    Q_OBJECT
private:
    QString initQuery;
public:
    enum Roles  {Value = Qt::UserRole};
    //SearchModelHeaders << "Name" << "MainProd" << "Compos" << "Type" << "SubType" << "Racion" << "Description" << "Comment";
    explicit SqlListAvailVal(QStringList headers,QString initquery, QObject *parent = 0);
public slots:
    void setList(QString Value);
};

#endif // SQLLISTAVAILVAL_H
