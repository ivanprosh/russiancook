#include "searchmodel.h"

SearchModel::SearchModel(QStringList headers,QString initquery, QObject *parent):Model(headers,initquery,parent)
{
}

void SearchModel::initQuery()
{

    QSqlQuery SQLquery;
    //Сначала создаем виртуальную таблицу и добавляем в нее нужные поля для поиска
    QString Createquery = " CREATE VIRTUAL TABLE IF NOT EXISTS ftstest10 USING fts4 		"
                            " (Name,                                                        "
                            "  MainProd,                                                    "
                            "  Racion,                                                      "
                            "  Description,                                                 "
                            "  Type,                                                        "
                            "  Subtype,                                                     "
                            "  Compos,                                                      "
                            "  tokenize=unicodesn \"stemmer=russian\");                     ";
     QString Insertquery =  " INSERT INTO ftstest10                                         "
                            " SELECT R.Name,                                                "
                            "         (SELECT Name                                          "
                            "         FROM Product                                          "
                            "         WHERE Product.ID_PR = R.ID_MainPR) as MainProd,       "
                            "        R.Racion,                                              "
                            "        R.Description,                                         "
                            "        ReceptType.Type,                                       "
                            "        ReceptType.SubType,                                    "
                            "        group_concat(Product.Name)                             "
                            " FROM Recept AS R                                              "
                            "     INNER JOIN Composition ON Composition.ID_REC = R.ID_REC   "
                            "     INNER JOIN Product ON Product.ID_PR = Composition.ID_PR   "
                            "     LEFT JOIN ReceptType ON ReceptType.ID_Type = R.Type       "
                            " WHERE NOT EXISTS (SELECT * FROM ftstest10)                    "
                            " GROUP BY R.Name;                                              ";
    if(SQLquery.exec(Createquery))
    {
        qDebug() << "FTS created!";
        if(SQLquery.exec(Insertquery))
            qDebug() << "FTS updated!";
        else
            qDebug() << "FTS not updated!" << SQLquery.lastError();
    }
    else
        qDebug() << "FTS not created!" << SQLquery.lastError();
}

void SearchModel::selectWord(QString Word)
{
    this->clear();
    qDebug() << "In slot selectWord" << Word;
    //QSqlQuery SQLq;
    QString query =   " SELECT snippet(ftstest10,'<b>', '</b>','...',0) AS Name,			"
                      "        snippet(ftstest10,'<b>', '</b>','...',1) AS MainProd,      "
                      " 	   snippet(ftstest10,'<b>', '</b>','...',6) AS Compos,          "
                      "        snippet(ftstest10,'<b>', '</b>','...',4) AS Type,          "
                      "        snippet(ftstest10,'<b>', '</b>','...',5) AS SubType,       "
                      "        snippet(ftstest10,'<b>', '</b>','...',2) AS Racion,        "
                      "        snippet(ftstest10,'<b>', '</b>','...',3) AS Description    "
                      " FROM ftstest10 WHERE ftstest10 MATCH '%1';                        ";
    query = query.arg(Word);
    //if(SQLq.exec())
    this->setQuery(query);
}

