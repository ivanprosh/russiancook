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

Item {
    id: receptItem
    width: parent.width
    height: 88

    property alias receptName: elname.text
    property alias receptMainProd: elprod.text
    property alias receptRacion: elrac.text

    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        z:2
        visible: mouse.pressed
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 15
        height: 1
        z:2
        color: "#424246"
    }


    Rectangle{
        anchors.fill: parent
        z:1
        color: "#212126"

        id: recdata
        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5
            Image {
                Layout.minimumWidth: 10
                Layout.minimumHeight: 10
                source: RecImage
                smooth: true
            }
            Column {
                Layout.fillWidth: true
                Text {id: elname; color: "white"; text: modelData; font.pointSize: 12}
                Text {id: elprod; color: "lightblue"; text: modelData; font.pointSize: 10}
                Text {id: elrac; color: "yellow"; text: modelData; font.pointSize: 8}
            }
            Image {
                anchors.right: parent.right
                //anchors.verticalCenter: parent.verticalCenter
                source: "../images/navigation_next_item.png"
            }
        }
    }


    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: receptItem.clicked()

    }
}