import QtQuick 2.0
//import QtQuick.Controls 1.4
//import QtQuick.Controls.Styles 1.1
//import QtQuick.Layouts 1.2
import Qt.labs.controls 1.0

ComboBox{
    id: control

    property bool isInit;
    property real spacefactor: 1.0

    Connections {
        target: control
        onActivated: {
            isInit = true;
        }
    }
    //displayText: "Продукт"
    //font.pixelSize: fontItemsize
    //model: ListProd
    //textRole: Value
    background: Item {
        implicitWidth: 120
        implicitHeight: 35

        Rectangle {
            width: parent.width*spacefactor
            height: parent.height
            opacity: control.enabled ? 1.0 : 0.2
            color: control.pressed || popup.visible ? mainwindow.controlpress : mainwindow.control
        }

        Image {
            x: parent.width*spacefactor - width - control.rightPadding
            y: (parent.height - height) / 2
            source: "qrc:/images/drop-indicator.png"
        }
    }
    popup: Popup{
        y: control.height - 1
        implicitWidth: control.width*spacefactor
        implicitHeight: Math.min(7*listview.contentItem.children[0].height, listview.contentHeight)
        topMargin: 6
        bottomMargin: 6

        contentItem: ListView {
            id: listview
            clip: true
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            Rectangle {
                z: 10
                parent: listview
                width: listview.width
                height: listview.height
                border.color: "transparent"
                color: "transparent"
            }

            //ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle { opacity: 1.0; color: "#f0e6bd" }
    }
    delegate: ItemDelegate {
          width: control.width
          text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
          checkable: true
          font.pointSize: control.font.pointSize * 0.67
          autoExclusive: true
          checked: control.currentIndex === index
          highlighted: control.highlightedIndex === index
          pressed: highlighted && control.pressed
      }
    //Rectangle { anchors.left: ;color:"transparent"; height: control.height; width:5}



}
