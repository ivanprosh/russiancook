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
public slots:
    void initQuery();
    void selectWord(QString Word);
};

#endif // SEARCHMODEL_H
