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
import QtQuick.Window 2.0
import "scale.js" as MyScale

ApplicationWindow {
    id: mainwindow
    visible: true
    width: MyScale.dp(720)
    height: MyScale.dp(1280)

    //signal stackPush(int page)
    //OnStackPush: stackView.push(Qt.resolvedUrl(page))


    BorderImage {
        id: mainborder
        verticalTileMode: BorderImage.Round
        horizontalTileMode : BorderImage.Round
        border.left: MyScale.dp(67); border.top: MyScale.dp(1); border.right: MyScale.dp(69); border.bottom: MyScale.dp(190)
        anchors { top: parent.top; bottom: parent.bottom; left:parent.left; right:parent.right  }
        source: "../images/mushrooms.png"
    }
    toolBar: BorderImage {
        id: maintoolbar
        verticalTileMode: BorderImage.Round
        horizontalTileMode : BorderImage.Round
        border {left: MyScale.dp(67); top: MyScale.dp(100); right: MyScale.dp(69); bottom: MyScale.dp(10)}
        source: "../images/toolbar.png"
        width: parent.width
        height: 150
        property alias text: handletext.text

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.top:parent.top
            anchors.topMargin: parent.border.top*0.66
            anchors.left: parent.left
            anchors.leftMargin: 20+parent.border.left
            opacity: stackView.depth > 1 ? 1 : 0

            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#55BDB76B" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                    stackView.pop();
                    MenuRec.LevelUp();
                    maintoolbar.text = MenuRec.curHandleName();
                }
            }
        }

        Text {
            id: handletext
            anchors.verticalCenter: backButton.verticalCenter
            font.pixelSize: 38
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            color: Qt.darker("#706343")
            text: "Русская кухня"
        }
    }

    ListModel {
        id: pageModel

        ListElement {
            title: "Рецепты"
            page: "ReceptsTypePage.qml"
        }
        ListElement {
            title: "Календарь"
            page: "CalendarPage.qml"
        }

    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.leftMargin: mainborder.border.left
        anchors.rightMargin: mainborder.border.right
        anchors.bottomMargin: mainborder.border.bottom
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                            }

        initialItem: Item {
            width: parent.width
            height: parent.height
            ListView {
                model: pageModel
                anchors.fill: parent
                delegate: AndroidDelegate {
                    text: title
                    onClicked:{
                        stackView.push(Qt.resolvedUrl(page));
                        MenuRec.LevelDown(maintoolbar.text);
                        maintoolbar.text = "Рецепт"
                    }

                }
            }
        }
        delegate: StackViewDelegate
        {
        pushTransition:StackViewTransition {
            PropertyAnimation {
                target: enterItem
                property: "opacity"
                from: 0
                to: 1
            }

            NumberAnimation {
                target: enterItem
                property: "x"
                from: 500
                duration: 500
                to: 0
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                target: exitItem
                property: "opacity"
                from: 1
                to: 0
            }
        }
    }

}

}

