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

FocusScope {
    id: container
    //enabled: activeFocus

    //property bool open: false
    property alias source: popupview.source

    Behavior on height {
        NumberAnimation{
            easing.amplitude: 0.8
            easing.period: 0.5
            duration: 500
            easing.type: Easing.OutElastic
        }
    }

    ListModel {
        id: popupMenuModel

        ListElement {
            title: "Поиск"
            sourceimage: "../images/search.svg"
            page: "SearchPage.qml"
        }
        ListElement {
            title: "Корзина"
            sourceimage: "../images/shopping_basket.svg"
            page: ""
        }

    }

    BorderImage {
        id: popupview
        visible: container.activeFocus
        verticalTileMode: BorderImage.Round
        horizontalTileMode : BorderImage.Round
        border {left: 15; top: 0; right: 0; bottom: 20}
        anchors.fill: parent

        ListView {
            id: listpopup
            focus: container.activeFocus
            model: popupMenuModel
            anchors.fill: parent

            delegate: PopupMenuDelegate {
                text: title
                image: sourceimage
                onClicked:{
                    console.log("Debug popup, visible",listpopup.visible," height", listpopup.height)
                    stackView.push(Qt.resolvedUrl(page));
                    stackView.levelpopup++;
                    stackView.focus = true;
                    console.log("curr index",listpopup.currentIndex)
                    // if(listpopup.currentIndex == 0) maintoolbar.searchpage = true;
                    maintoolbar.text = title;
                }

            }
        }
    }
    PopupEffect {
        id: slide
        anchors.fill: parent
        effectImage: popupview
        open: container.activeFocus
        height: container.height
    }

}

//}


