#ifndef SEARCHMODEL_H
#define SEARCHMODEL_H
#include "model.h"

class SearchModel : public Model
{
    Q_OBJECT
public:
    enum Roles  {RecName = Qt::UserRole,RecMainProd,RecComposition,RecType,RecCategory,RecRacion,RecDescription,RecComment};
    //SearchModelHeaders << "Name" << "MainProd" << "Compos" << "Type" << "SubType" << "Racion" << "Description" << "Comment";
    explicit SearchModel(QStringList headers,QString initquery, QObject *parent = 0);
    struct ComposeLine {QString Name; int count; QString Metrics;};
    QVector<ComposeLine> TableCompos;
public slots:
    void initQuery();
    void selectWord(QString Word);
    void fillCompos(QString ProdName, int ProdCount, QString ProdMetrics);//Добавляем строку в вектор с таблицей состава
};

#endif // SEARCHMODEL_H
