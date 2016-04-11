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
import QtQuick.Window 2.2
//import Material 0.2
//import "scale.js" as MyScale

ApplicationWindow {
    id: mainwindow
    visible: true
    //anchors { top: parent.top; bottom: parent.bottom; left:parent.left; right:parent.right  }
    property int dpi: Screen.pixelDensity * 25.4
    property int rightmarginborder: 69

    width: dp(720)
    height: if(Qt.platform.os == "windows") dp(640)
            else dp(1280)

    function dp(x){
        if(dpi < 120) {
            //console.log("In dp(x),x:",x ,"dpi is", dpi ," x*(dpi/160) is", (x*(dpi/160)));
            return x; // Для обычного монитора компьютера
        } else {
            return x*(dpi/160);
        }
    }

    function showrecept(name){
        console.log("in showrecept, name is",name)
        MenuRec.curRecNameChanged(name);
        MenuRec.LevelDown(maintoolbar.text);
        stackView.push(Qt.resolvedUrl("SingleReceptPage.qml"));
        maintoolbar.text = name;
    }

    BorderImage {
        id: mainborder
        verticalTileMode: BorderImage.Round
        horizontalTileMode : BorderImage.Round
        border.left: 67; border.top: 1; border.right: mainwindow.rightmarginborder; border.bottom: 190
        anchors { top: parent.top; bottom: parent.bottom; left:parent.left; right:parent.right  }
        source: "../images/mushrooms.png"
       // z:2
    }

    toolBar: BorderImage {
        id: maintoolbar
        verticalTileMode: BorderImage.Round
        horizontalTileMode : BorderImage.Round
        border {left: 67; top: 100; right: mainwindow.rightmarginborder; bottom: 10}
        source: "../images/toolbar.png"
        width: parent.width
        height: 150
        property alias text: handletext.text
        property bool searchpage: stackView.currentItem.objectName == "search"


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
                    if(!popupMenu.activeFocus && stackView.depth > 1){
                        console.log("Area width:",width)
                        stackView.pop();
                        if(stackView.levelpopup == 0) {
                            MenuRec.LevelUp();
                            maintoolbar.text = MenuRec.curHandleName();
                            console.log("Not popup", stackView.levelpopup);
                        } else {
                            stackView.levelpopup--;
                            maintoolbar.text = MenuRec.popMenuTitleName(maintoolbar.text);
                            console.log("Level popup is",stackView.levelpopup);
                        }
                    }
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
            visible: !maintoolbar.searchpage
        }

        SearchDelegate {
            id: wordSearch
            anchors.top:parent.top
            anchors.topMargin: parent.border.top*0.66
            anchors.left: backButton.right
            anchors.right: parent.right
            anchors.rightMargin: 20+parent.border.right
            label: "Search word..."
            placeHolder: "Яйцо варить"
            onHasOpened: {
//                tagSearch.close()
//                userSearch.close()

            }
            onOk: {
                  console.log("Word completed: ",searchText);
                  MenuSearch.selectWord(searchText);
//                searchResultsList.positionViewAtBeginning();
//                mainListView.clear()
//                tweetsModel.from = ""
//                tweetsModel.phrase = searchText
            }
            visible: maintoolbar.searchpage
        }

        Rectangle {
            id: popupButton
            width: 60
            anchors.top:parent.top
            anchors.topMargin: parent.border.top*0.66
            anchors.right: parent.right
            anchors.rightMargin: 20+parent.border.right
            //opacity: stackView.depth > 1 ? 1 : 0
            antialiasing: true
            height: 60
            radius: 4
            color: popupmouse.pressed ? Qt.lighter("#55BDB76B") : "transparent"
            //Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/navigation_popup.png"
            }
            MouseArea {
                id: popupmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {
                     if(popupMenu.activeFocus) {
                         stackView.focus = true
                        // popupMenu.open = false
                     } else popupMenu.focus = true
                }
                enabled: !maintoolbar.searchpage
            }
            visible: !maintoolbar.searchpage
        }
    }
    Rectangle {
        id: shade
        anchors.fill: parent
        color: Qt.darker("#706343")
        opacity: 0
        MouseArea
        {
            enabled: false
            id: shademouse
            anchors.fill: parent;
            onClicked:
            {
                console.log("in shademouse");
                stackView.focus = true;
                enabled = false
            }
        }
        z:10
    }

    MyPopupMenu {
        id: popupMenu;
        anchors {right:parent.right; top:parent.top}
        anchors.rightMargin: mainwindow.rightmarginborder;
        source: "../images/popupback.png"
        width: parent.width/2;
        z:11
    }

    Rectangle{
        anchors.fill: parent
        color: "transparent"

        states: State {
            name: "PopupMenuOpen"
            //when: !(stackView.activeFocus || wordSearch.activeFocus)
            when: popupMenu.activeFocus
            PropertyChanges { target: popupMenu; height: 260 }
            PropertyChanges { target: shade; opacity: 0.25 }
            PropertyChanges { target: shademouse; enabled: true }
        }

        transitions: Transition {
            NumberAnimation { properties: "x,opacity"; duration: 600; easing.type: Easing.OutQuint }
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
        ListElement {
            title: "Тест"
            page: "PopupMenu.qml"
        }

    }

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.leftMargin: mainborder.border.left
        anchors.rightMargin: mainborder.border.right
        anchors.bottomMargin: 120

        property int levelpopup: 0;
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
                        console.log(stackView.currentItem.objectName," and ",Qt.resolvedUrl("ReceptTypePage.qml"));
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


