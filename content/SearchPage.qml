import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.2
//import com.cook.Recept 1.0
//import "scale.js" as mainwindow

ScrollView {
    id: receptview
    objectName: "search"
    width: parent.width
    height: parent.height
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

    property string fontDescrsize: mainwindow.dp(17)
    property string fontItemsize: mainwindow.dp(17)
    property string fontHeadersize: mainwindow.dp(14)
    property color mainTextColor: Qt.darker("#706343")

    Component.onCompleted:
    {
        console.log("!Search page is loaded...")
        MenuSearch.initQuery();
    }

    ListView {
        id: searchResultsList
        width: stackView.width
        height: children.height
        model: MenuSearch

        delegate: FTSListDelegate {
            receptName: Name
            receptMainProd: MainProd
            receptRacion: Racion
            receptCompos: Compos
            receptDescription: Description
        }
        populate: Transition {
            //NumberAnimation { property: "y"; from: 1000; duration: 500; easing.type: Easing.InOutQuad }
            //NumberAnimation { property: "hm"; from: 0; to: 1.0; duration: 300; easing.type: Easing.Linear }
            NumberAnimation { property: "opacity"; from: 0.3; to: 1.0; duration: 500; easing.type: Easing.InOutQuad }
        }
        onDragEnded: console.log("onDragEnded")

        footer: SearchInitAnimation {}
    }

    style: ScrollViewStyle {
        transientScrollBars: true
        handle: Item {
            implicitWidth: 14
            implicitHeight: 26
            Rectangle {
                color: "#d3c59c"
                anchors.fill: parent
                anchors.topMargin: 6
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.bottomMargin: 6
            }
        }
        scrollBarBackground: Item {
            implicitWidth: 14
            implicitHeight: 26
        }
    }
}
