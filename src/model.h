#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QtSql>

class model : public QSqlQueryModel
{
    Q_OBJECT
    QString Myquery;
    QHash<int,QByteArray> *hash;
public:
    enum Roles {Name = Qt::UserRole};
    explicit model(QString query, QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QString userdata(int row,int role) const;
protected:
    QHash<int,QByteArray> roleNames() const;
signals:

public slots:
    void curNameForQueryChanged(int index);
};

#endif // MODEL_H
