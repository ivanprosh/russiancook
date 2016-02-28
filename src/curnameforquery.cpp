#include "curnameforquery.h"

CurNameForQuery::CurNameForQuery(QObject *parent) : QObject(parent)
{}

void CurNameForQuery::setInput(const QString &newQuery)
{
    in = newQuery;
    //this->setQuery(Myquery.arg(input));
    emit inputChanged(in);
    qDebug() << "Input is: " << in;
}
