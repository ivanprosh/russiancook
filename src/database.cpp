#include <QtSql>
#include <QFile>
#include <QDebug>
#include "database.h"

bool Database::createСonnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    //QString path ="RussianCook.sqlite";
    db.setDatabaseName(name);

    if (!QFile(name).exists() || !db.open()) {
        qDebug() << "Cannot open database:" << db.lastError();
        return false;
    }
    QStringList tables = db.tables();
    foreach (QString str, tables) {
        qDebug() << "Table is: " << str;
    }
    return true;
}
