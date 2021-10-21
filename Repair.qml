import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15


Window {
    id: repair
    visible: true
    width: 480
    height: 74 + (40 * repairCount) + 32


    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    Flickable {
        anchors.fill: parent
        synchronousDrag: true


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
                            id: mouseArea3
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property variant clickPos: "1,1"
                            onPressed: {
                                clickPos = Qt.point(mouseX, mouseY)
                            }

                            onPositionChanged: {
                                var delta = Qt.point(mouseX - clickPos.x,
                                                     mouseY - clickPos.y)
                                repair.x += delta.x
                                repair.y += delta.y
                            }
                        }
                    }
                    RowLayout {
                        id: rectangle
                        anchors.fill: parent
                        anchors.rightMargin: 5
                        anchors.leftMargin: 5
                        anchors.bottomMargin: 5
                        anchors.topMargin: 5

                        Image {
                            horizontalAlignment: Image.AlignLeft
                            source: "icons/TaskBar.svg"
                            Layout.maximumWidth: 20
                            Layout.maximumHeight: 20
                            Layout.minimumHeight: 20
                            Layout.minimumWidth: 20
                            sourceSize.height: 20
                            sourceSize.width: 20
                        }
                        
                        Text {
                            text: whatYouDo
                            font.pixelSize: 12
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.family: "Roboto Medium"
                            font.weight: Font.Medium
                            color: myWhiteFont
                        }

                    }
                }

                ColumnLayout {
                    id: container
                    spacing: 8
                    Layout.margins: 8
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    }


                RowLayout {
                    spacing: 8
                    Layout.margins: 8
                    Layout.maximumHeight: 42
                    Layout.topMargin: 0
                    Layout.leftMargin: 12
                    Layout.rightMargin: 12
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    

                    Button {
                        id: button
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight:  36
                        Layout.maximumHeight: 36
                        background: Rectangle {
                            implicitHeight: 36 
                            anchors.fill: parent
                            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 1.25) : myBackground)
                            radius: 8
                        }

                        Label{
                            color: myWhiteFont
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            padding: 8
                            font.family: "Roboto Medium"
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: makeCustomAlpha
                            
                        }
                        onClicked: {
                            repair.close()
                            choseAbcTab.currentIndex = 2
                            circleDraw.show()
                            repair.destroy()
                        }
                    }

                    Button {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.minimumHeight:  36
                        Layout.maximumHeight: 36
                        background: Rectangle {
                            implicitHeight: 36 
                            anchors.fill: parent
                            color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 1.25) : myBackground)
                            radius: 8
                        }

                        Label{
                            color: myWhiteFont
                            anchors.verticalCenter: parent.verticalCenter
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            padding: 8
                            font.family: "Roboto Medium"
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: finish
                            
                        }
                        onClicked: {
                            repair.close()
                            activeWindow = true
                            var output = []
                            for (var i = 0; i < repairCount; i++) {
                                output.push([container.children[i].children[0].children[1].currentIndex , container.children[i].children[0].children[2].currentIndex])

                            }
                            myData.repair(output)
                            myData.encode()
                            repair.destroy()
                        }
                    }
                }
            }
        }
    }

    function crComp(){
        var component = Qt.createComponent("RepairWidget.qml")
        for (var i = 0; i < repairCount; i++) {
            var object = component.createObject(container)
            object.myChar = badChar[i]

        }
    }

    Rectangle {
        id: repairGlow
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
        anchors.fill: repairGlow
        radius: 12
        transparentBorder: true
        source: repairGlow
        z: -1
    }
}

