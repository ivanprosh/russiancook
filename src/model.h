#ifndef MODEL_H
#define MODEL_H

#include <QObject>
#include <QtSql>

class MenuRecModel : public QSqlQueryModel
{
    Q_OBJECT
    QSqlQuery Myquery;
    QHash<int,QByteArray> *hash;
public:
    enum Roles {Type = Qt::UserRole,SubType,Description};
    explicit MenuRecModel(QStringList headers, QObject *parent = 0);
    QVariant data(const QModelIndex &index, int role) const;
    QString userdata(int row,int role) const;
protected:
    QHash<int,QByteArray> roleNames() const;
signals:

public slots:
    void CatForCurTypeQuery(int index,QString Nameheader);
};

#endif // MODEL_H
