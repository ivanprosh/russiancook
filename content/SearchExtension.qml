/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.2
import Qt.labs.controls 1.0

ColumnLayout {
    id: sostav
    width: parent.width
    height: childrenRect.height
    z: 2

    property int fontItemsize: 22
    property int rowheight: fontItemsize * 2.0
    property int maxrow: 10
//    property int fontHeadersize: 14
    property color mainTextColor: Qt.darker("#706343")
    Connections {
        target: wordSearch
        onOk: {
            if(searchReceptComposition.get(0).product !== "")
            {
                var i;
                console.log("List not empty: ");
                for(i=0;i<searchReceptComposition.count;i++){
                    console.log(searchReceptComposition.get(i).product);
                    MenuSearch.fillCompos(searchReceptComposition.get(i).product,0,searchReceptComposition.get(i).product);
                }
            }
        }
    }
    ListModel
    {
        id:searchReceptComposition
        //Repeater {
        //      model: 5
        ListElement {product:"";count:"";metric:""}
       // }
    }
    Text{
       Layout.alignment: Qt.AlignHCenter
       font.pixelSize: fontItemsize
       style: Text.Sunken
       styleColor: "#827256"
       font.weight: Font.DemiBold
       text: "Дополнительные параметры поиска. <br> Что в холодильнике?"
       horizontalAlignment : Text.AlignHCenter
    }
    RowLayout{
       //anchors.horizontalCenter: parent.horizontalCenter
       Layout.preferredWidth: parent.width
       Layout.alignment: Qt.AlignHCenter


       spacing: 2
        Rectangle{
            color:"transparent"
            height: 1.1*maxrow*rowheight
            width: addrow.width
            Image {
                id: addrow

                y: usercomposTable.rowCount * rowheight - rowheight/2
                source: "../images/add.svg"
                fillMode: Image.Pad
                MouseArea {
                    anchors { fill: parent }
                    onClicked: if(usercomposTable.model.count < maxrow) {
                                   usercomposTable.model.append({product:"",count:"",metric:""})
                               }
                }
            }
        }
        //состав
        TableView {
            id: usercomposTable

            property var availmetrics:[ListVal1,ListVal2,ListVal3,ListVal4,ListVal5,ListVal6,ListVal7,ListVal8,ListVal9,ListVal10];
            //width: parent.width*0.8
            Layout.fillWidth : true
            Layout.alignment: Qt.AlignTop
            Layout.preferredHeight: 1.1*maxrow*rowheight

            TableViewColumn {
                role: "product"
                title: "Продукт"
                width: usercomposTable.width*0.4
                elideMode: Text.ElideMiddle
                delegate: CookComboBox{
                    displayText: isInit ? currentText : "Продукт"
                    font.pixelSize: fontItemsize
                    anchors.margins: 5
                    model: ListProd
                    textRole: Value
                    onActivated: {
                        usercomposTable.model.setProperty(usercomposTable.currentRow,"product", currentText);
                        usercomposTable.availmetrics[styleData.row].setList("SELECT Metric as Value FROM Product WHERE Name='" + currentText + "';");
                        //usercomposTable.model.test();
                    }
                }
            }
            TableViewColumn {
                role: "count"
                title: "Кол-во"
                width: usercomposTable.width*0.2
                delegate: SpinBox{
                    id: countprod
                    from: 0
                    to: 1000
                    font.pixelSize: fontItemsize
                    height: rowheight*0.9
                    validator: DoubleValidator {
                        //locale: control.locale.name
                        decimals: 2
                        notation : DoubleValidator.StandardNotation
                        bottom: Math.min(countprod.from, countprod.to)
                        top: Math.max(countprod.from, countprod.to)
                    }
                    background: Rectangle{
                        implicitWidth: mainwindow.dp(40)
                        //anchors.fill: parent
                        //border.color: "#70603f"
                        color: "transparent"
                    }

                    down.indicator: Rectangle {
                        x: 5
                        height: parent.height
                        implicitWidth: 40
                        implicitHeight: 40
                        color: down.pressed ? "#92865c" : "#7a6a48"
                        border.color: countprod.enabled ? Qt.darker("#CC706343") : "#bdbebf"

                        Rectangle {
                            x: (parent.width - width) / 2
                            y: (parent.height - height) / 2
                            width: parent.width / 3
                            height: 2
                            color: countprod.enabled ? "#353637" : "#bdbebf"
                        }
                    }

                    up.indicator: Rectangle {
                        x: parent.width - width - 5
                        height: parent.height
                        implicitWidth: 40
                        implicitHeight: 40
                        color: up.pressed ? "#92865c" : "#7a6a48"
                        border.color: countprod.enabled ? Qt.darker("#CC706343") : "#bdbebf"

                        Rectangle {
                            x: (parent.width - width) / 2
                            y: (parent.height - height) / 2
                            width: parent.width / 3
                            height: 2
                            color: countprod.enabled ? "#353637" : "#bdbebf"
                        }
                        Rectangle {
                            x: (parent.width - width) / 2
                            y: (parent.height - height) / 2
                            width: 2
                            height: parent.width / 3
                            color: countprod.enabled ? "#353637" : "#bdbebf"
                        }
                    }
                }
            }
            TableViewColumn {
                id: metric
                role: "metric"
                title: "Ед.изм."
                width: usercomposTable.width*0.4

                delegate: CookComboBox{

                    displayText: (count>0) ? currentText : "Метрика"
                    implicitHeight: rowheight*0.8
                    font.pixelSize: fontItemsize
                    //model: ListVal
                    textRole: Value
                    Component.onCompleted: {setModel();}
                    onCountChanged: currentIndex = 0;
                    function setModel(){
                        console.log("Model index is",styleData.row);
                        model = usercomposTable.availmetrics[styleData.row];
                    }


                }
                function test(){
                    console.log("TEST");
                }

            }

            model: searchReceptComposition

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
                //            itemDelegate:  Item {
                //                Text {
                //                    id:textrow
                //                    width: parent.width
                //                    anchors.margins: 4
                //                    anchors.horizontalCenter: parent.horizontalCenter
                //                    horizontalAlignment: styleData.textAlignment
                //                    verticalAlignment: Text.AlignVCenter
                //                    anchors.leftMargin: 12
                //                    anchors.topMargin: 5
                //                    elide: Text.ElideMiddle
                //                    text: styleData.value
                //                    color: styleData.textColor
                //                    font.pixelSize: fontItemsize

                //                    Behavior on font.pixelSize { NumberAnimation{} }
                //                }
                //            }

                rowDelegate: Rectangle {
                    id: rowdel
                    height: fontItemsize * 2.0
                    //width: textrow.implicitWidth
                    color: styleData.selected ? "#11ffffff":"transparent"
                    Behavior on height { NumberAnimation{} }

                }

            }
        }
        Rectangle{
            color:"transparent"
            height: 1.1*maxrow*rowheight
            width: removeic.width
            Image {
                id: removeic
                y: usercomposTable.rowCount * rowheight - rowheight/2
                source: "../images/remove.svg"
                fillMode: Image.Pad
                MouseArea {
                    anchors { fill: parent }
                    onClicked: if(searchReceptComposition.count > 1) {
                                   searchReceptComposition.remove(searchReceptComposition.count-1)
                               }
                }
                //onYChanged: console.log("y is",y,"table height is",usercomposTable.height)
                Behavior on y {
                    NumberAnimation { duration: 300 }
                }
            }
        }
    }
}


