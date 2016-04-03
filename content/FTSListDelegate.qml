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
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
//import "tweetsearch.js" as Helper

Item {
    id: container
    property real hm: 1.0
    property int appear: -1
    property real startRotation: 1

    property alias receptName: name.text
    property alias receptMainProd: mainprod.text
    property alias receptRacion: racion.text
    property alias receptCompos: compos.text
    property alias receptDescription: description.text

    property string fontDescrsize: mainwindow.dp(17)
//    property string fontItemsize: mainwindow.dp(17)
//    property string fontHeadersize: mainwindow.dp(14)
    property color mainTextColor: Qt.darker("#706343")

    Component.onCompleted: {
       //NumberAnimation { property: "hm"; from: 0; to: 1.0; duration: 300; easing.type: Easing.Linear }
       //PropertyAction { property: "appear"; value: 250 }
    }

    onAppearChanged: {
        console.log("AppearChanged");
        container.startRotation = 0.5
        flipBar.animDuration = appear;
        delayedAnim.start();
    }

    SequentialAnimation {
        id: delayedAnim
        PauseAnimation { duration: 50 }
        ScriptAction { script: flipBar.flipDown(startRotation); }
    }

    width: 320
    height: flipBar.height * hm

    FlipBar {
        id: flipBar

        property bool flipped: false
        delta: startRotation

        anchors.bottom: parent.bottom
        width: container.ListView.view ? container.ListView.view.width : 0
        height: front.visible ? 72 : Math.max(72, description.height + 10)

        Behavior on height{
            NumberAnimation  { duration: 500; easing.type: Easing.InOutQuad }
        }

        front: Rectangle {
            width: container.ListView.view ? container.ListView.view.width : 0
            height: 72
            color: "#CCc4b891"

            Rectangle { color: "#33c4b891"; width: parent.width; height: 1 }
            Rectangle { color: Qt.darker("#33c4b891"); width: parent.width; height: 1; anchors.bottom: parent.bottom }

//            Image {
//                id: placeHolder
//                source: "resources/anonymous.png"
//                x: 10; y: 9
//                visible: avatar.status != Image.Ready
//            }

//            Image {
//                id: avatar
//                source: model.userImage
//                anchors.fill: placeHolder
//                MouseArea {
//                    id: mouseArea
//                    anchors.fill: parent
//                    onClicked: {
//                        flipBar.flipUp()
//                        flipBar.flipped = true
//                    }
//                }
//            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: {
                    flipBar.flipUp()
                    flipBar.flipped = true
                }
            }
            RowLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5
                Column {
                    Layout.fillWidth: true
                    Text {
                        id: name
                        text: modeldata
                        //anchors { left: parent.left; leftMargin: 10; top: parent.top; topMargin: -3 }
                        font.pixelSize: 12
                        font.bold: true
                        color: mainTextColor
                        //linkColor: "white"
                    }

                    Text {
                        id: mainprod
                        text: modeldata
                        //anchors { left: avatar.right; leftMargin: 10; top: name.bottom; topMargin: 0; right: parent.right; rightMargin: 10 }
                        wrapMode: Text.WordWrap
                        font.pixelSize: 12
                        font.bold: false
                        color: "black"
                        //linkColor: "white"
                    }
                    Text {
                        id: compos
                        text: modeldata
                        //anchors { left: avatar.right; leftMargin: 10; top: name.bottom; topMargin: 0; right: parent.right; rightMargin: 10 }
                        wrapMode: Text.WordWrap
                        font.pixelSize: 10
                        font.bold: false
                        //color: Qt.lighter(mainTextColor)
                        //linkColor: "white"
                    }
                    Text {
                        id: racion
                        text: modeldata
                        //anchors { left: avatar.right; leftMargin: 10; top: name.bottom; topMargin: 0; right: parent.right; rightMargin: 10 }
                        //wrapMode: Text.WordWrap
                        font.pixelSize: 10
                        font.bold: false
                        color: Qt.lighter(mainTextColor)
                        //linkColor: "white"
                    }
                }
            }
        }

        back: Rectangle {
            width: container.ListView.view ? container.ListView.view.width : 0
            height: Math.max(72, description.height + 10)
            color: "#9b953d"

            Rectangle { color: "#ff6633"; width: parent.width; height: 1 }
            Rectangle { color: "#80341a"; width: parent.width; height: 1; anchors.bottom: parent.bottom }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    flipBar.flipDown()
                    flipBar.flipped = false
                }
            }

            TextArea {
                    id: description
                    readOnly: true
                    backgroundVisible: false
                    frameVisible: false
                    font.pixelSize: fontDescrsize;
                    horizontalAlignment : Text.AlignJustify
                    text: modeldata
                    height: contentHeight

                }

            Text {
                //text: model.source + "<br>" + Helper.formatDate(model.published) + "<br>" + model.uri
                x: 10; anchors { top: description.bottom; topMargin: 0 }
                wrapMode: Text.WordWrap
                font.pixelSize: 12
                font.bold: false
                color: "#ffc2ad"
                linkColor: "white"
            }
        }
    }
}
