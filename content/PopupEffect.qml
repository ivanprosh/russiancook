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

import QtQuick 2.5

ShaderEffect {

//    function flipUp(start) {
//        effect.visible = true;
//        effect.sourceA = effect.source1
//        effect.sourceB = effect.source2
//        if (start == undefined)
//            start = 1.0;
//        deltaAnim.from = start;
//        deltaAnim.to = 0.0
//        dAnim.start();
//        frontShown = false;
//    }

//    function flipDown(start) {
//        effect.visible = true;
//        effect.sourceA = effect.source1
//        effect.sourceB = effect.source2
//        if (start == undefined)
//            start = 0.0;
//        deltaAnim.from = start;
//        deltaAnim.to = 1.0
//        dAnim.start();
//        frontShown = true;
//    }


        id: effect
        anchors.fill: parent

        mesh: GridMesh { resolution: Qt.size(40,40) }

        property Item effectImage: Item {}
        property real leftheight: height
        property real rightheight: leftheight
        property real amplitude: 0.05
        property bool open: false
        property variant source: effectSource

        Behavior on leftheight {
            SpringAnimation {
                easing.type: Easing.OutElastic;
                velocity: 250; mass: 1.5;
                spring: 0.5; damping: 0.05
            }
        }

        Behavior on rightheight {
            NumberAnimation { duration: 1000 }
        }
        Behavior on height {
            NumberAnimation { duration: 1000 }
        }

        ShaderEffectSource {
            id: effectSource
            sourceItem: effectImage;
            hideSource: true
        }

//        Image {
//            id: effectImage
//            anchors.fill: parent
//            source: "assets/fabric.png"
//            fillMode: Image.Tile
//        }

//        vertexShader: "
//                attribute highp vec4 qt_Vertex;
//                attribute highp vec2 qt_MultiTexCoord0;
//                uniform highp mat4 qt_Matrix;
//                varying highp vec2 qt_TexCoord0;
//                varying lowp float shade;

//                uniform highp float leftheight;
//                uniform highp float rightheight;
//                uniform highp float width;
//                uniform highp float height;
//                uniform highp float amplitude;

//                void main() {
//                    qt_TexCoord0 = qt_MultiTexCoord0;

//                    highp vec4 shift = vec4(0.0, 0.0, 0.0, 0.0);
//                    highp float swing = (leftheight - rightheight) * (qt_Vertex.y / height);
//                    shift.x = qt_Vertex.x * (width - leftheight + swing) / width;

//                    shade = sin(21.9911486 * qt_Vertex.x / width);
//                    shift.y = amplitude * (height - leftheight + swing) * shade;

//                    gl_Position = qt_Matrix * (qt_Vertex - shift);

//                    shade = 0.2 * (2.0 - shade ) * ((width - leftheight + swing) / width);
//                }"
        vertexShader: "
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                uniform highp mat4 qt_Matrix;
                varying highp vec2 qt_TexCoord0;
                varying lowp float shade;

                uniform highp float leftheight;
                uniform highp float rightheight;
                uniform highp float width;
                uniform highp float height;
                uniform highp float amplitude;

                void main() {
                    qt_TexCoord0 = qt_MultiTexCoord0;

                    highp vec4 shift = vec4(0.0, 0.0, 0.0, 0.0);
                    highp float swing = (leftheight - rightheight) * (qt_Vertex.y / height);

                    shade = sin(21.9911486 * qt_Vertex.y / height);
                    shift.y = (height - leftheight + swing);

                    gl_Position = qt_Matrix * (qt_Vertex - shift);

                    shade = 0.2 * (2.0 - shade ) * ((width - leftheight + swing) / width);
                }"

        fragmentShader: "
                uniform sampler2D source;
                varying highp vec2 qt_TexCoord0;
                varying lowp float shade;
                void main() {
                    highp vec4 color = texture2D(source, qt_TexCoord0);
                    color.rgb *= 1.0 - shade;
                    gl_FragColor = color;
                }"


}
