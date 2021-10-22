import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15

Window {
    id: circleDraw
    visible: true
    width: 400
    height: 200

    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    Flickable {
        anchors.fill: parent

        Rectangle {
            color: myBackground2
            radius: 8
            border.color: myUpperBar
            border.width: 4
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12

            GridLayout {
                anchors.fill: parent
                rowSpacing: 0
                columns: 1
                columnSpacing: 2

                Rectangle {
                    id: upperBar2
                    width: 200
                    height: 200
                    color: myUpperBar
                    radius: 8
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.maximumHeight: 30
                    Layout.minimumHeight: 30
                    Layout.fillWidth: true

                    Rectangle {
                        width: 200
                        height: 8
                        color: myUpperBar
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                    }

                    RowLayout {
                        anchors.fill: parent

                        MouseArea {
                            id: mouseArea2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                clickPos = Qt.point(mouseX, mouseY)
                            }

                            onPositionChanged: {
                                var delta = Qt.point(mouseX - clickPos.x,
                                                     mouseY - clickPos.y)
                                circleDraw.x += delta.x
                                circleDraw.y += delta.y
                            }
                        }

                        RowLayout {
                            width: 52
                            Layout.rightMargin: 6
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true
                            spacing: 6

                            Button {
                                id: myClose2
                                width: 20
                                height: 20
                                flat: true
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle {
                                    color: myClose2.pressed ? Qt.darker(myCloseBtn, 1.5) : 
                                            (myClose2.hovered ? myCloseBtn : myUpperBar)
                                    radius: 4
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: myClose2.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: myClose2.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                }
                                onClicked: {
                                    circleDraw.close()
                                    circleDraw.width = 400
                                    circleDraw.height = 200
                                    warning.visible = false
                                    alphabetInput.text = ""
                                    keySens.checked = false
                                    activeWindow = true


                                }
                            }
                        }
                    }

                    Text {
                        y: 7
                        text: makeCircle
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 30
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                        color: myWhiteFont
                    }

                    Image {
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Image.AlignLeft
                        source: "icons/TaskBar.svg"
                        anchors.leftMargin: 5
                        anchors.topMargin: 5
                        anchors.bottomMargin: 5
                        sourceSize.height: 20
                        sourceSize.width: 20
                    }
                }

                ColumnLayout {
                    width: 100
                    height: 100
                    Layout.bottomMargin: 12
                    Layout.topMargin: 8
                    spacing: 8
                    Layout.margins: 16
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Flickable {
                        
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        TextArea.flickable: TextArea {
                            id: alphabetInput
                            selectByMouse: true
                            visible: true
                            color: myWhiteFont
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.WrapAnywhere
                            font.capitalization: keySens.checked ? Font.MixedCase : Font.AllUppercase
                            textFormat: Text.AutoText
                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                            font.family: "Roboto Medium"
                            font.hintingPreference: Font.PreferFullHinting
                            placeholderText: alphabetHere
                            background: Rectangle {
                                color: myBackground
                                radius: 8
                            }
                        }

                        ScrollBar.vertical: ScrollBar {}
                    }

                    Label { 
                        id: warning
                        visible: false
                        color: myCloseBtn
                        text: abcWar
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        font.family: "Poppins Medium"
                    }

                    RowLayout {
                        id: rowLayout
                        width: 100
                        height: 100

                        CheckBox {
                            id: keySens
                            text: textKeySensitive
                            checked: keySensitive
                            tristate: false
                            Layout.fillWidth: true
                            indicator: Rectangle {
                                implicitWidth: 26
                                implicitHeight: 26
                                x: keySens.x
                                y: parent.height / 2 - height / 2
                                radius: 8
                                color: keySens.down ? myHighLighht  : (keySens.hovered ? Qt.lighter(myBackground, 2) : myBackground)

                                Rectangle {
                                    width: 14
                                    height: 14
                                    x: 6
                                    y: 6
                                    radius: 4
                                    color: keySens.down ? Qt.lighter(myHighLighht, 2) : (keySens.hovered ? Qt.lighter(myHighLighht, 1.25) : myHighLighht)
                                    visible: keySens.checked
                                }
                            }
                            
                        }

                        Button {
                            id: makeAlpha
                            Layout.minimumWidth: 150
                            Layout.minimumHeight: 32
                            Layout.fillWidth: true
                            onClicked: {
                                var charRepeats = function(str) {
                                    for (var i=0; i < str.length; i++) {
                                        if ( str.indexOf(str[i]) !== str.lastIndexOf(str[i]) ) {
                                            return false; // repeats
                                        }
                                    }
                                return true;
                                }

                                var str = alphabetInput.text
                                str = str.replace(" ", "")
                                if(str.length > 8) {
                                    if(!keySens.checked){str = str.toUpperCase()}
                                    if (charRepeats(str)) {
                                        if (keySens.checked) {
                                            keySensitive = true
                                        } else {
                                            keySensitive = false
                                        }
                                        customAlpha = str
                                        myDrawCircle.isUpper(keySens.checked)
                                        myDrawCircle.myAlpha(alphabetInput.text)
                                        circleDraw.close()
                                        if(str.indexOf("\n")==-1){
                                            customMaxShift = str.length -1
                                        }else{
                                            customMaxShift = str.length -2
                                        }
                                        circleDraw.width = 400
                                        circleDraw.height = 200
                                        warning.visible = false
                                        activeWindow = true
                                        customCircle.source = ""
                                        customCircleBig.source = ""
                                        customCircle.source = "icons/CustomSmallCircle.png"
                                        customCircleBig.source = "icons/CustomBigCircle.png"
                                    } else {
                                        warning.visible = true
                                        warning.text = abcWar
                                        circleDraw.width = 400
                                        circleDraw.height = 222
                                    }
                                } else {
                                    warning.visible = true
                                    warning.text = abcWar2
                                    circleDraw.width = 400
                                    circleDraw.height = 222
                                }
                            }
                            background: Rectangle {
                                anchors.fill: parent
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                radius: 8
                                Label{
                                    text: makeAbc
                                    anchors.fill: parent
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Roboto Medium"
                                    color: makeAlpha.down ? myUpperBar : (makeAlpha.hovered ? Qt.darker(myWhiteFont, 1.25) :myWhiteFont)
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: circleDrawGlow
            color: "#cf018500"
            radius: 8
            anchors.fill: parent
            anchors.rightMargin: 12
            anchors.leftMargin: 12
            anchors.bottomMargin: 12
            anchors.topMargin: 12
            z: -1
        }
        FastBlur {
            anchors.fill: circleDrawGlow
            radius: 12
            transparentBorder: true
            source: circleDrawGlow
            z: -1
        }
    }
}
