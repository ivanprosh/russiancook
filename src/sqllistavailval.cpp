#include "sqllistavailval.h"

SqlListAvailVal::SqlListAvailVal(QStringList headers,QString init, QObject *parent):Model(headers,init,parent),initQuery(init)
{
}

void SqlListAvailVal::setList(QString Value)
{
    qDebug() << "In setList " << Value;
}

