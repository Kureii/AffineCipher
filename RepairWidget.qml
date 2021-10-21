import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQml 2.15


Item {
property string myChar: ""
id: wtIndx
Layout.fillWidth: true
Layout.fillHeight: true
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 6

        Label {
            text: whatDoTxt1 + myChar + whatDoTxt2
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            Layout.minimumHeight: 32
            Layout.maximumHeight: 32
            Layout.fillWidth: true
            anchors.leftMargin: 14
        }

        ComboBox {
            id: wD
            Layout.minimumHeight: 32
            Layout.maximumHeight: 32
            Layout.maximumWidth: 120
            Layout.fillWidth: true
            currentIndex: 1
            font.family: "Poppins Medium"
            model: whatDo
            
            delegate: ItemDelegate {
                width: wD.width
                contentItem: Text { //combobox menu 
                    text: modelData
                    color: myWhiteFont
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Roboto Medium"
                }
                highlighted: wD.highlightedIndex === index
                Component.onCompleted: background.color =  myBackground
                Binding {
                    target: background
                    property: "color"
                    value: highlighted ? myHighLighht : myBackground
                }                                    
            }

            indicator: Image {
                anchors.verticalCenter: wD.verticalCenter
                anchors.right: wD.right
                source: "icons/UpDown.svg"
                anchors.rightMargin: 6
                sourceSize.height: 10
                sourceSize.width: 10
                fillMode: Image.Pad                                        
                    
            }

            contentItem: Text {                                             
                text: wD.displayText
                font: wD.font
                color: wD.pressed ? myBackground : myUpperBar
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: wD.horizontalCenter
                elide: Text.ElideRight
                anchors.verticalCenter: wD.verticalCenter
                
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                border.color: wD.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                border.width: wD.visualFocus ? 2 : 1
                radius: 4
                color: myBackground2
            }

            popup: Popup {
                y: wD.height - 1
                width: wD.width
                implicitHeight: contentItem.implicitHeight
                padding: 1
                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: wD.popup.visible ? wD.delegateModel : null
                    currentIndex: wD.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator { }
                }                                        

                background: Rectangle {
                    border.color: Qt.darker(myBackground2, 1.1)
                    radius: 4
                    color: myBackground2
                }
            }
        }

        ComboBox {
            id: chCh
            visible: wD.currentIndex == 2 ? true : false
            Layout.minimumHeight: 32
            Layout.maximumHeight: 32
            Layout.maximumWidth: 40
            Layout.fillWidth: true
            currentIndex: 0
            font.family: "Poppins Medium"
            model: abcList
            
            delegate: ItemDelegate {
                width: chCh.width
                contentItem: Text { //combobox menu 
                    text: modelData
                    color: myWhiteFont
                    font.family: "Roboto Medium"
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: chCh.highlightedIndex === index
                Component.onCompleted: background.color =  myBackground
                Binding {
                    target: background
                    property: "color"
                    value: highlighted ? myHighLighht : myBackground
                }
                
            }

            indicator: Image {
                anchors.verticalCenter: chCh.verticalCenter
                anchors.right: chCh.right
                source: "icons/UpDown.svg"
                anchors.rightMargin: 6
                sourceSize.height: 10
                sourceSize.width: 10
                fillMode: Image.Pad                                                                        
            }

            contentItem: Text {                                     
                text: chCh.displayText
                font: chCh.font
                color: chCh.pressed ? myBackground : myUpperBar
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: chCh.horizontalCenter
                elide: Text.ElideRight
                anchors.verticalCenter: chCh.verticalCenter                                        
            }

            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 25
                border.color: chCh.pressed ? myBackground2 : Qt.darker(myBackground2, 1.1)
                border.width: chCh.visualFocus ? 2 : 1
                radius: 4
                color: myBackground2
            }

            popup: Popup {
                y: chCh.height - 1
                width: chCh.width
                implicitHeight: contentItem.implicitHeight
                padding: 1

                contentItem: ListView {
                    clip: true
                    implicitHeight: contentHeight
                    model: chCh.popup.visible ? chCh.delegateModel : null
                    currentIndex: chCh.highlightedIndex
                    ScrollIndicator.vertical: ScrollIndicator {active: true}
                }
                    
                background: Rectangle {
                    border.color: Qt.darker(myBackground2, 1.1)
                    radius: 4
                    color: myBackground2
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
