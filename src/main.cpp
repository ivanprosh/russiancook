#include <QApplication>
#include <QtQml>
#include "database.h"
#include "model.h"
#include "menumodel.h"
#include "searchmodel.h"
#include "recept.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //Create connect to db
    #ifdef ANDROID
        qDebug() << "Debug: In Android connect DB";
        QFile dfile("assets:/RussianCook.sqlite");

        if (dfile.exists())
        {
             qDebug() << "Debug: In Android connect DB dfile.exists()";
             dfile.copy("./RussianCook.sqlite");
             QFile::setPermissions("./RussianCook.sqlite",QFile::WriteOwner | QFile::ReadOwner);
        }
    #endif
    Database cook("RussianCook.sqlite");

    if (!cook.createConnection()) {
            return -1;
        }

    QStringList MenuModelHeaders,SearchModelHeaders;

    MenuModelHeaders << "Type" << "SubType" << "Description";
    MenuModelHeaders << "Name" << "MainProd" << "Racion" << "Description" << "Comment" ; //Таблица Рецептов

    SearchModelHeaders << "Name" << "MainProd" << "Compos" << "Type" << "SubType" << "Racion" << "Description" << "Comment";

    QString initQuery = "SELECT Distinct Type "
                        "FROM ReceptType ";
    MenuModel* MenuRec = new MenuModel(MenuModelHeaders,initQuery);
    SearchModel* MenuSearch = new SearchModel(SearchModelHeaders,"");
    //Model* SearchLists = new Model(ModelHeaders,initQuery);
    Recept curRecept;

    //Подключаем сигналы между моделью и экземпляром рецепта
    QObject::connect(MenuRec,SIGNAL(curRecNameChanged(QString)),&curRecept,SLOT(curRecNameChanged(QString)));

    //qmlRegisterType<CurNameForQuery>("com.mymodels.CurNameForQuery",1,0,"CurNameForQuery");
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("MenuRec", MenuRec);
    engine.rootContext()->setContextProperty("MenuSearch", MenuSearch);
    engine.rootContext()->setContextProperty("curReceptComposition", &(curRecept.composition));
    engine.rootContext()->setContextProperty("SingleRecModel", &curRecept);

    #ifdef ANDROID
        engine.load(QUrl(QStringLiteral("assets:/content/Main.qml")));
    #else
        engine.load(QUrl(QStringLiteral("qrc:/content/Main.qml")));
    #endif

    return app.exec();
}
