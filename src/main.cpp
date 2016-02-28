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
    model* MenuRoot = new model("SELECT Name "
                                "FROM Product "
                                "WHERE Name = '%1';" );

    MenuRoot->setQuery("SELECT Name "
                       "FROM Product ");

    model* MenuCategory = new model("SELECT Name "
                                    "FROM Product "
                                    "WHERE Name = '%1';" );

    qmlRegisterType<CurNameForQuery>("com.mymodels.CurNameForQuery",1,0,"CurNameForQuery");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MenuRootModel", MenuRoot);
    engine.rootContext()->setContextProperty("MenuCategoryModel", MenuCategory);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
