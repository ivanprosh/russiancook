import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.2
//import com.cook.Recept 1.0
//import "scale.js" as mainwindow

ScrollView {
    id: receptview
    width: parent.width
    height: parent.height
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff

    property string fontDescrsize: mainwindow.dp(17)
    property string fontItemsize: mainwindow.dp(17)
    property string fontHeadersize: mainwindow.dp(14)
    property color mainTextColor: Qt.darker("#706343")

    ColumnLayout {
        width: stackView.width
        height: children.height

        Component.onCompleted: {
            initTimer.running = true
        }
        Timer{
            id: initTimer
            interval: 0
            repeat: false
            onTriggered:
            {
                if(SingleRecModel.comValue()!== '')
                    textdescription.text = SingleRecModel.descValue() + "\n" +
                                       SingleRecModel.comValue()
                else
                    textdescription.text = SingleRecModel.descValue()

            }
        }
        //состав
        TableView {
            id: composTable
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.width*0.8
            Layout.minimumHeight: rowCount*mainwindow.dp(40)

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

                backgroundColor: "transparent"
                headerDelegate: Rectangle {

                    height: textItem.implicitHeight * 1.3
                    width: textItem.implicitWidth
                    //color: "#33796c49"
                    color: "transparent"
                    Text {
                        id: textItem
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: styleData.textAlignment
                        //anchors.leftMargin: 12
                        text: styleData.value
                        elide: Text.ElideRight
                        color: mainTextColor
                        renderType: Text.NativeRendering
                        font.pixelSize: fontHeadersize
                    }

                }
                itemDelegate:  Item {
                    Text {
                        id:textrow
                        width: parent.width
                        anchors.margins: 4
                        anchors.horizontalCenter: parent.horizontalCenter
                        horizontalAlignment: styleData.textAlignment
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 12
                        anchors.topMargin: 5
                        elide: Text.ElideMiddle
                        text: styleData.value
                        color: styleData.textColor
                        font.pixelSize: fontItemsize

                        Behavior on font.pixelSize { NumberAnimation{} }
                    }
                }

                rowDelegate: Rectangle {
                    height: fontItemsize * 2.0
                    //width: textrow.implicitWidth
                    color: styleData.selected ? "#11ffffff":"transparent"
                    Behavior on height { NumberAnimation{} }

                }
            }
        }
        //описание
        TextArea {
                id: textdescription
                backgroundVisible: false
                frameVisible: false
                //ScrollView:
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.preferredWidth: parent.width-Layout.leftMargin-Layout.rightMargin
                Layout.leftMargin: mainwindow.dp(10)
                Layout.rightMargin: mainwindow.dp(10)
                font.pixelSize: fontDescrsize;
                horizontalAlignment : Text.AlignJustify

                style: TextAreaStyle {
                          textColor: mainTextColor
                          selectionColor: Qt.lighter("#91884d")
                          selectedTextColor: "#6f6242"
                          backgroundColor: "transparent"
                          renderType: Text.NativeRendering
                }

                onTextChanged:
                {Layout.preferredHeight = contentHeight
                 console.log("Text changed! height:",contentHeight)}
            }

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
