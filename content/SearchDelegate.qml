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
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2

FocusScope {
    id: searchdelegate
    property string label: ""
    property string placeHolder: ""
    property alias searchText: lineInput.text
    property alias prefix: lineInput.prefix
    property bool opened: false
    signal ok
    signal hasOpened

    function open() {
        searchdelegate.opened = true
        lineInput.forceActiveFocus()
        searchdelegate.hasOpened()
    }

    function close() {
        if (opened) {
            searchdelegate.opened = false
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (!searchdelegate.opened)
                open()
            else if (!lineInput.activeFocus)
                lineInput.forceActiveFocus()
        }
    }

    Loader {
        id:loader
        anchors.centerIn: parent
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"

        LineInput {
            id: lineInput
            hint: searchdelegate.placeHolder
            focus: searchdelegate.opened
            anchors { fill: parent; margins: 0 }
            onAccepted: {
                if (Qt.inputMethod.visible)
                    Qt.inputMethod.hide()
                searchdelegate.ok()
            }
            onOpenext: {
                console.log("ext!")
                if (Qt.inputMethod.visible) Qt.inputMethod.hide()
                loader.source = "ExtensSearchPage.qml"
                loader.item.open()
            }

        }
    }
}


