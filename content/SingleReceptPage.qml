import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.2
import "scale.js" as MyScale
//import com.mymodels.CurNameForQuery 1.0

ScrollView {
    id: receptview
    width: parent.width
    height: parent.height
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

    ColumnLayout {
        width: stackView.width
        height: children.height
        //состав
        TableView {
            id: composTable
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width*0.8
            Layout.minimumHeight: rowCount*MyScale.dp(80)

            TableViewColumn {
                role: "ProductName"
                title: "Продукт"
                width: composTable.width/2.1
            }
            TableViewColumn {
                role: "Count"
                title: "Кол-во"
                width: composTable.width/4
            }
            TableViewColumn {
                role: "Metric"
                title: "Ед.изм."
                width: composTable.width/4
            }
            model: curReceptComposition

            frameVisible: false
            sortIndicatorVisible: true

            //делегаты
            style: TableViewStyle {

                backgroundColor: "#33dfd097"
                headerDelegate: Rectangle {
                    height: textItem.implicitHeight * 1.3
                    width: textItem.implicitWidth
                    color: "#66796c49"

                    Text {
                        id: textItem
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: styleData.textAlignment
                        anchors.leftMargin: 12
                        text: styleData.value
                        elide: Text.ElideRight
                        color: "#706343"
                        renderType: Text.NativeRendering
                        //font.family: "Helvetica"
                        font.pixelSize: MyScale.dp(22)
                    }
                    Rectangle {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.topMargin: 1
                        width: 1
                        color: "#ccc"
                    }
                }
                itemDelegate:  Item {
                    Text {
                        id:textrow
                        width: parent.width
                        anchors.margins: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        //anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideMiddle
                        text: styleData.value
                        color: styleData.textColor
                        font.pixelSize: MyScale.dp(20)
                    }
                }

                rowDelegate: Rectangle {
                    height: styleData.selected ? composTable.textrow.implicitHeight * 3.0 : 40
                    width: textrow.implicitWidth
                    color: "#05796c49"

                    Behavior on height { NumberAnimation{} }

                }
            }
        }
        //описание
        // Rectangle { color: "red"; width: 50; height: 50 }
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
