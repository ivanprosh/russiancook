import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.2

ScrollView {
    id: idsearchpage
    objectName: "search"
    width: parent.width
    height: parent.height
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

    property string fontDescrsize: mainwindow.dp(17)
    property string fontItemsize: mainwindow.dp(17)
    property string fontHeadersize: mainwindow.dp(14)
    property color mainTextColor: Qt.darker("#706343")

    signal forceLayout
    onForceLayout: searchResultsList.forceLayout()

    Component.onCompleted:
    {
        console.log("!Search page is loaded...")
        MenuSearch.initQuery();
    }

    ListView {
        id: searchResultsList
        anchors.fill: parent
        model: MenuSearch

        delegate: FTSListDelegate {
            receptName: Name
            //receptMainProd: MainProd
            receptRacion: Racion
            receptCompos: Compos
            receptDescription: Description
            onClicked: {
                console.log("Name",receptName.toString())
                mainwindow.showrecept(receptName.toString())
            }
        }
        populate: Transition {
            //NumberAnimation { property: "y"; from: 1000; duration: 500; easing.type: Easing.InOutQuad }
            //NumberAnimation { property: "hm"; from: 0; to: 1.0; duration: 300; easing.type: Easing.Linear }
            NumberAnimation { property: "opacity"; from: 0.3; to: 1.0; duration: 500; easing.type: Easing.InOutQuad }
        }

        footer: SearchExtension {}
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
