#include <QApplication>
#include <QtQml>
#include "database.h"
#include "model.h"
#include "curnameforquery.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //Create connect to db
    Database cook("RussianCook.sqlite");

    if (!cook.createСonnection()) {
            return -1;
        }
    //Ok, then create example of SQLmodel
    QStringList RecTypeheaders;
    RecTypeheaders << "Type" << "SubType" << "Description";
//    QString initQuery = "SELECT '%1' "
//                        "FROM '%2' "
//                        "WHERE '%3' = '%4';";
    MenuRecModel* MenuRec = new MenuRecModel(RecTypeheaders);
    //инициализационный запрос
    MenuRec->setQuery("SELECT Distinct Type "
                        "FROM ReceptType ");

    //qmlRegisterType<CurNameForQuery>("com.mymodels.CurNameForQuery",1,0,"CurNameForQuery");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MenuRec", MenuRec);
    //engine.rootContext()->setContextProperty("MenuCategoryModel", MenuCategory);
    engine.load(QUrl(QStringLiteral("qrc:/content/Main.qml")));

    return app.exec();
}
