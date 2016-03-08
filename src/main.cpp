#include <QApplication>
#include <QtQml>
#include "database.h"
#include "model.h"
#include "recept.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //Create connect to db
    Database cook("RussianCook.sqlite");

    if (!cook.createConnection()) {
            return -1;
        }
    //Ok, then create example of SQLmodel
    QStringList ModelHeaders;

    ModelHeaders << "Type" << "SubType" << "Description";
    ModelHeaders << "Name" << "MainProd" << "Racion" << "Description" << "Comment" ; //Таблица Рецептов


    QString initQuery = "SELECT Distinct Type "
                        "FROM ReceptType ";
    MenuRecModel* MenuRec = new MenuRecModel(ModelHeaders,initQuery);
    Recept curRecept;

    //Подключаем сигналы между моделью и экземпляром рецепта
    QObject::connect(MenuRec,SIGNAL(curRecNameChanged(QString)),&curRecept,SLOT(curRecNameChanged(QString)));

    //qmlRegisterType<CurNameForQuery>("com.mymodels.CurNameForQuery",1,0,"CurNameForQuery");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MenuRec", MenuRec);
    engine.rootContext()->setContextProperty("curRecept", &curRecept);
    engine.load(QUrl(QStringLiteral("qrc:/content/Main.qml")));

    return app.exec();
}
