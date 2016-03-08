#ifndef COMPOSITIONTABLE_H
#define COMPOSITIONTABLE_H

#include <QObject>
#include <QtSql>

class CompositionTable : public QSqlQueryModel
{
    Q_OBJECT
    QHash<int,QByteArray> *hash;
public:
    enum Roles  {ProductName = Qt::UserRole,ProductCount,ProductMetrics,
                 };
    explicit CompositionTable(QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QString userdata(int row,int role) const;
    void setCurQuery(int RecID);
protected:
    QHash<int,QByteArray> roleNames() const;
signals:

public slots:
};

#endif // COMPOSITIONTABLE_H
