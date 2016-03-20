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

        //описание
        TextArea {
                //id: textdescription
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
