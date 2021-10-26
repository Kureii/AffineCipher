import QtQuick
import QtQuick.Controls
import QtQuick.Layouts 6.0
import QtQml.Models 2.2
import Qt5Compat.GraphicalEffects
import QtQuick.Dialogs 

Window {
    id: mainWindow
    visible: true
    width: 800
    height: naiveModernTab.currentIndex == 0 ? 626 : 460
    color: "transparent"

    flags: Qt.Window | Qt.WindowMinimizeButtonHint | Qt.FramelessWindowHint

    property string windowTitle: "Tittle"
    property string typeTitle: "Type"
    property string naive: "Naive"
    property string modern: "Modern"
    property string choseAbc: "Chose alphabet"
    property string basicAbc: "Basic"
    property string extAbc: "Extendet"
    property string customAbc: "Custom"
    property string textHere: "write text here"
    property string textChoseFile: "File unchosed"
    property string buttonChoseFile: "Browse files"
    property string textFile: "Text"
    property string fileText: "File"
    property string textShift: "Shift: "
    property string textSpaces: "Replace spaces by: "
    property string repSpc: "Without spaces"
    property string textOutSpaces: "Divide encode text by: "
    property string textOutSpaces2: "space/s"
    property string textEncode: "Encode"
    property string textDecode: "Decode"
    property string makeCircle: "Create custom alphabet"
    property string alphabetHere: "Alphabet here (whitout end of line and spaces)"
    property string textKeySensitive: "Key sensitive"
    property string makeAbc:"Create alphabet"
    property string abcWar: "Alphabet mustn't include duplicate chars."
    property string abcWar2: "Alphabet must be longer than 9 chars"
    property string opTextErr: "Imput error"
    property string noFileErr: "Error: Input file missing." 
    property string noTextErr: "Error: Input text missing."
    property string decodeErr: "Error: Unexpected char in input"
    property string errRepeatChars: "Error: space chars are in input text."
    property string errSpc: "Overlaying"
    property string alphaErr: "Alphabet overflow"
    property string noCharErr: "Char for spaces isn't includet in alphabet."
    property string makeCustomAlpha: "Back to make custom alphabet"
    property string finish: "Finish"
    property string whatYouDo: "What will you do?"
    property string whatDoTxt1: 'Char "'
    property string whatDoTxt2: '" is not includet in alphabet.'
    property string titleSolution: "Solution"
    property string alphabetText: "Alphabet:"
    property string shiftText: "Shift:"
    property string spcRepText: "Spaces replaced by:"
    property string opText: "Open text:"
    property string enText: "Encoded text:"
    property string openText: ""
    property string encodedText: ""
    property string saveText: "Save"

    property int repairCount: 0
    property int a: shifterA.value
    property int b: shifterB.value

    property double basicMaxShift: 25.0
    property double extMaxShift: 35.0
    property double customMaxShift: 25.0
    property double mySpaces: 5.0

    property var abcList: ["a", "b"]
    property var whatDo: ["Remove", "Add char", "Repace"]
    property var badChar: ["@", "&"]

    property bool activeWindow: true
    property bool keySensitive: false
    property bool inputErr: false
    property bool spaceErr: false
    property bool repErr: false
    property bool inDecErr: false

    readonly property color myUpperBar: "#1a1512"
    readonly property color myBackground: "#201e1b"
    readonly property color myWhiteFont: "#e4f8ff"
    readonly property color myBackground2: "#acb1aa"
    readonly property color myHighLighht: "#3fa108"
    readonly property color myCloseImg: "#fcf8fe"
    readonly property color myCloseImgUnA: "#878589"
    readonly property color myCloseBtn: "#de2f05"

    readonly property string basicAlpha: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    readonly property string extAlpha: "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    property string customAlpha: ""

    property url inputFile: ""

    Flickable {
        anchors.fill: parent

        Rectangle {
            id: window
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
                id: windowLayout
                anchors.fill: parent
                rowSpacing: 0
                columns: 2
                columnSpacing: 2

                // upper-bar
                Rectangle {
                    color: myUpperBar
                    radius: 8
                    Layout.columnSpan: 2
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
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            property var clickPos: "1,1"
                            onPressed: {
                                if (activeWindow) {
                                    clickPos = Qt.point(mouseX, mouseY)
                                }
                            }

                            onPositionChanged: {
                                if (activeWindow) {
                                    var delta = Qt.point(mouseX - clickPos.x,
                                                         mouseY - clickPos.y)
                                    mainWindow.x += delta.x
                                    mainWindow.y += delta.y
                                }
                            }
                        }

                        RowLayout {
                            width: 56
                            Layout.rightMargin: 6
                            layoutDirection: Qt.LeftToRight
                            Layout.columnSpan: 2
                            Layout.fillWidth: false
                            Layout.fillHeight: true

                            Button {
                                id: minimalise
                                width: 20
                                height: 20
                                flat: false
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                background: Rectangle {
                                    id: rectangle
                                    color: minimalise.pressed
                                           && activeWindow ? Qt.tint(Qt.lighter(myUpperBar, 2.5), "#100c03FF") : 
                                           (minimalise.hovered && activeWindow ? Qt.tint(Qt.lighter(myUpperBar, 3), "#100c03FF") : myUpperBar)
                                    radius: 4
                                    Rectangle {
                                        width: 12
                                        height: 2
                                        color: minimalise.pressed
                                               && activeWindow ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                        anchors.bottom: parent.bottom
                                        anchors.bottomMargin: 4
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        radius: 1
                                    }
                                }
                                onClicked: {
                                    if (activeWindow) {
                                        mainWindow.showMinimized()
                                    }
                                }
                            }

                            Button {
                                id: myClose
                                width: 20
                                height: 20
                                flat: true
                                enabled: activeWindow
                                Layout.minimumWidth: 20
                                Layout.minimumHeight: 20
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                background: Rectangle {
                                    color: myClose.pressed ? Qt.darker(myCloseBtn, 1.5) 
                                            : (myClose.hovered && activeWindow ? myCloseBtn : myUpperBar)
                                    radius: 4
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: 45
                                        color: myClose.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                    Rectangle {
                                        width: 16
                                        height: 2
                                        radius: 1
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        rotation: -45
                                        color: myClose.pressed ? Qt.darker(myCloseImg, 1.5) : myCloseImg
                                    }
                                }
                                onClicked: {
                                    if (activeWindow) {
                                        mainWindow.close()
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        y: 7
                        text: windowTitle
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

                // typeTitle
                Rectangle {
                    height: 30
                    color: myBackground
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.rowSpan: 1
                    Layout.columnSpan: 2
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillHeight: false
                    Layout.fillWidth: true

                    Text {
                        color: myWhiteFont
                        text: typeTitle
                        anchors.fill: parent
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Roboto Medium"
                        font.weight: Font.Medium
                    }
                }

                // type Chose
                TabBar {
                    id: naiveModernTab
                    width: 240
                    height: 35
                    enabled: activeWindow
                    position: TabBar.Footer
                    Layout.columnSpan: 2
                    font.family: "Roboto Medium"
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true

                    TabButton {
                        id: naiveButton
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: naiveButton.hovered && activeWindow ? Qt.lighter( myBackground, 2) : myBackground
                                anchors.fill: parent
                            Label {
                                text: naive
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: naiveModernTab.currentIndex == 0 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: naiveButton.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                            }

                            Rectangle {
                                height: 4
                                color: naiveModernTab.currentIndex
                                       == 0 ? myHighLighht : (naiveButton.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                    }

                    TabButton {
                        id: modernButton
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: modernButton.hovered && activeWindow ? Qt.lighter(myBackground,2) : myBackground
                                anchors.fill: parent
                            Label {
                                text: modern
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.verticalCenterOffset: naiveModernTab.currentIndex == 1 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: modernButton.hovered && activeWindow ? Qt.lighter(myWhiteFont, 2) : myWhiteFont
                            }

                            Rectangle {
                                height: 4
                                color: naiveModernTab.currentIndex == 1 ? myHighLighht : (modernButton.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                    }
                }

                // abc title
                Label {
                    text: choseAbc
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.columnSpan: 2
                    padding: 8
                    Layout.fillWidth: true
                    font.weight: Font.Medium
                    font.family: "Poppins Medium"
                    color: myUpperBar
                }

                // abc chose
                TabBar {
                    id: choseAbcTab
                    width: 240
                    height: 35
                    enabled: activeWindow
                    position: TabBar.Footer
                    Layout.columnSpan: 2
                    font.family: "Roboto Medium"
                    Layout.rightMargin: 4
                    Layout.leftMargin: 4
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.fillWidth: true

                    TabButton {
                        id: basicAbcButtno
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: basicAbcButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                anchors.fill: parent
                            Label {
                                text: basicAbc
                                anchors.verticalCenter: parent.verticalCenter
                                font.weight: Font.Medium
                                font.family: "Poppins Medium"
                                anchors.verticalCenterOffset: choseAbcTab.currentIndex == 0 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: basicAbcButtno.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                            }

                            Rectangle {
                                height: 4
                                color: choseAbcTab.currentIndex == 0 ? myHighLighht : 
                                        (basicAbcButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                    }

                    TabButton {
                        id: extAbcButton
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom

                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: extAbcButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                            anchors.fill: parent
                            Label {
                                text: extAbc
                                anchors.verticalCenter: parent.verticalCenter
                                font.weight: Font.Medium
                                font.family: "Poppins Medium"
                                anchors.verticalCenterOffset: choseAbcTab.currentIndex == 1 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: extAbcButton.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                            }

                            Rectangle {
                                height: 4
                                color: choseAbcTab.currentIndex == 1 ? myHighLighht : (extAbcButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                    }

                    TabButton {
                        id: customAbcButtno
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        bottomPadding: 18
                        padding: 8
                        background: Rectangle {
                            color: customAbcButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                            anchors.fill: parent
                            Label {
                                text: customAbc
                                anchors.verticalCenter: parent.verticalCenter
                                font.weight: Font.Medium
                                font.family: "Poppins Medium"
                                anchors.verticalCenterOffset: choseAbcTab.currentIndex == 2 ? -2 : 0
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: customAbcButtno.hovered && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                            }

                            Rectangle {
                                height: 4
                                color: choseAbcTab.currentIndex == 2 ? myHighLighht : (customAbcButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2)
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.bottomMargin: 0
                            }
                        }
                    }
                }                

                // live abce
                Label {
                    text: choseAbcTab.currentIndex == 1 ? abcRot(extAlpha, shifter.value) :
                        (choseAbcTab.currentIndex == 2 && customAlpha != "" ? abcRot(customAlpha, shifter.value) : abcRot(basicAlpha, shifter.value))
                    font.letterSpacing: 5
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    font.family: "Poppins Medium"
                    Layout.columnSpan: 2
                    Layout.topMargin: 8
                    Layout.bottomMargin: 8

                    function abcRot (abc, i) {
                        if (naiveModernTab.currentIndex == 0){
                            return abc.substring(abc.length - i) + abc.substring(0, abc.length-i)
                        } else {
                            var str = ""
                            var index = 0
                            var myLength = abc.length
                            for (var j = 0; j < myLength; j++) {
                                index = (a * j + b) % myLength
                                str += abc.substring(index, index + 1)
                            }
                            return str
                        }
                    }
                }

                // left column
                StackLayout {
                    Layout.leftMargin: 14
                    Layout.topMargin: -6
                    currentIndex: naiveModernTab.currentIndex
                    Layout.bottomMargin: 12
                    Layout.minimumWidth: 250
                    Layout.fillHeight: true
                    Layout.fillWidth: false

                    // naive brench
                    StackLayout {
                        Layout.leftMargin: 14
                        Layout.topMargin: -6
                        currentIndex: choseAbcTab.currentIndex
                        visible: naiveModernTab.currentIndex == 0? true : false
                        Layout.bottomMargin: 12
                        Layout.minimumWidth: 250
                        Layout.fillHeight: true
                        Layout.fillWidth: false

                        Rectangle {
                            width: 400
                            height: 200
                            color: "transparent"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.minimumWidth: 250

                            Image {
                                anchors.fill: parent
                                source: "icons/BasicBigCircle.png"
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit

                                Image {
                                    id: basicCircle
                                    width: 300
                                    height: 300
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icons/BasicSmallCircle.png"
                                    antialiasing: true
                                    rotation: (360 / (basicMaxShift + 1) * shifter.value - 2)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    sourceSize.height: 300
                                    sourceSize.width: 300
                                    fillMode: Image.Pad
                                }
                            }
                        }

                        Rectangle {
                            width: 400
                            height: 200
                            color: "transparent"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.minimumWidth: 250

                            Image {
                                anchors.fill: parent
                                source: "icons/ExtBigCircle.png"
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit

                                Image {
                                    id: extCircle
                                    width: 300
                                    height: 300
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icons/ExtSmallCircle.png"
                                    antialiasing: true
                                    rotation: (360 / (extMaxShift + 1) * shifter.value - 2)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    sourceSize.height: 300
                                    sourceSize.width: 300
                                    fillMode: Image.Pad
                                }
                            }
                        }

                        Rectangle {
                            width: 400
                            height: 200
                            color: "transparent"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.minimumWidth: 250

                            Image {
                                id: customCircleBig
                                cache: false
                                asynchronous:true
                                anchors.fill: parent
                                source: "icons/BasicBigCircle.png"
                                antialiasing: true
                                fillMode: Image.PreserveAspectFit

                                Button {
                                    width: 150
                                    height: 150
                                    enabled: activeWindow
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    z: 2
                                    onClicked: {
                                        activeWindow = false
                                        circleDraw.show()
                                    }
                                    background: Rectangle {
                                        color: parent.down ? myHighLighht : (parent.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                        radius: parent.width / 2
                                    }

                                    Label {
                                        text: makeCircle
                                        anchors.fill: parent
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                        font.weight: Font.Medium
                                        color: parent.down ? myUpperBar : myWhiteFont
                                        padding: 8
                                    }
                                }

                                Image {
                                    id: customCircle
                                    width: 300
                                    height: 300
                                    cache: false
                                    asynchronous:true
                                    anchors.verticalCenter: parent.verticalCenter
                                    source: "icons/BasicSmallCircle.png"
                                    antialiasing: true
                                    rotation: (360 / (customMaxShift + 1) * shifter.value - 2)
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    sourceSize.height: 300
                                    sourceSize.width: 300
                                    fillMode: Image.Pad
                                }
                            }
                        }

                        CircleDraw {
                            id: circleDraw
                            visible: false
                        }
                    }        

                    // modern brench
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            color:  "transparent"
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.topMargin: 6
                            Layout.maximumHeight: choseAbcTab.currentIndex < 2 ? 242 : 198
                            Layout.minimumHeight: choseAbcTab.currentIndex < 2 ? 242 : 198


                            ColumnLayout {
                                height: choseAbcTab.currentIndex < 2 ? 140 : 120
                                visible: true
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: -15
                                anchors.leftMargin: -15
                                anchors.topMargin: 0
                                
                                spacing: 0

                                Label {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.bottomMargin: -22
                                    Layout.topMargin: 10
                                    text: "A: " + shifterA.value
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                Slider {
                                    id: shifterA
                                    touchDragThreshold: 0
                                    from: 1
                                    to: choseAbcTab.currentIndex == 0 ? basicMaxShift : (choseAbcTab.currentIndex == 1 ? extMaxShift : customMaxShift)
                                    stepSize: stpSize()
                                    enabled: activeWindow
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.leftMargin: 20
                                    Layout.rightMargin: 20
                                    value: 1
                                    onValueChanged: {
                                        var abcLen = 26
                                        if (choseAbcTab.currentIndex == 0 || choseAbcTab.currentIndex == 2 && customAlpha == "") {
                                            abcLen = basicAlpha.length
                                        } else if (choseAbcTab. currentIndex == 1) {
                                            abcLen = extAlpha.lenght
                                        } else {
                                            abcLen = customAlpha.length
                                        }
                                        if (abcLen % shifterA.value == 0 && shifterA.value != 1) {
                                            if (shifterA.stepSize == 1) {
                                                shifterA.value += 1
                                            } else {
                                                shifterA.value += 2
                                            }
                                        }
                                    }
                                    function stpSize() {
                                        var abcLen = 26
                                        if (choseAbcTab.currentIndex == 0 || choseAbcTab.currentIndex == 2 && customAlpha == "") {
                                            abcLen = basicAlpha.length
                                        } else if (choseAbcTab. currentIndex == 1) {
                                            abcLen = extAlpha.lenght
                                        } else {
                                            abcLen = customAlpha.length + 1
                                        }
                                        if (abcLen % 2) {
                                            return 1
                                        } else {
                                            return 2
                                        }
                                    }

                                    background: Rectangle {
                                        x: shifterA.leftPadding
                                        y: shifterA.topPadding
                                            + shifterA.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 6
                                        width: shifterA.availableWidth
                                        height: implicitHeight
                                        radius: 3
                                        color: myBackground

                                        Rectangle {
                                            width: shifterA.visualPosition * parent.width
                                            height: parent.height
                                            color: myUpperBar
                                            radius: 3
                                        }
                                    }

                                    handle: Rectangle {
                                        x: shifterA.leftPadding + shifterA.visualPosition
                                            * (shifterA.availableWidth - width)
                                        y: shifter.topPadding
                                            + shifterA.availableHeight / 2 - height / 2
                                        implicitWidth: 20
                                        implicitHeight: 12
                                        radius: 4
                                        color: shifterA.pressed ? myHighLighht : (shifterA.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                    }
                                }

                                Label {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.bottomMargin: -16
                                    text: "B: " + shifterB.value
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                Slider {
                                    id: shifterB
                                    touchDragThreshold: 0
                                    from: 1
                                    to: choseAbcTab.currentIndex == 0 ? basicMaxShift : (choseAbcTab.currentIndex == 1 ? extMaxShift : customMaxShift)
                                    stepSize: 1
                                    enabled: activeWindow
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.leftMargin: 20
                                    Layout.rightMargin: 20
                                    value: 1

                                    background: Rectangle {
                                        x: shifterB.leftPadding
                                        y: shifterB.topPadding
                                            + shifterB.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 6
                                        width: shifterB.availableWidth
                                        height: implicitHeight
                                        radius: 3
                                        color: myBackground

                                        Rectangle {
                                            width: shifterB.visualPosition * parent.width
                                            height: parent.height
                                            color: myUpperBar
                                            radius: 3
                                        }
                                    }

                                    handle: Rectangle {
                                        x: shifterB.leftPadding + shifterB.visualPosition
                                            * (shifterB.availableWidth - width)
                                        y: shifterB.topPadding
                                            + shifterB.availableHeight / 2 - height / 2
                                        implicitWidth: 20
                                        implicitHeight: 12
                                        radius: 4
                                        color: shifterB.pressed ? myHighLighht : (shifterB.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                    }
                                }

                            }
                            RowLayout {
                                visible: true
                                anchors.top: parent.top
                                anchors.horizontalCenterOffset: 20
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.topMargin: choseAbcTab.currentIndex < 2 ? 146 :120

                                Label {
                                    text: textSpaces
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                TextField {
                                    id: repSpaces2
                                    selectByMouse: true
                                    color: myUpperBar
                                    enabled: activeWindow
                                    horizontalAlignment: Text.AlignHCenter
                                    font.capitalization: choseAbcTab.currentIndex == 2 && keySensitive ? Font.MixedCase : Font.AllUppercase
                                    font.family: "Poppins Medium"
                                    placeholderTextColor: Qt.lighter(myUpperBar, 2)
                                    placeholderText: repSpc
                                    Layout.rightMargin: 40
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 24
                                    Layout.minimumWidth: 40
                                    Layout.maximumWidth: 120
                                    background: Rectangle {
                                        color: myBackground2
                                        border.width: 1
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        radius: 8
                                    }
                                    onEditingFinished: {
                                        repSpaces.text = repSpaces2.text
                                    }
                                }
                            }

                            RowLayout {
                                visible: true
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.topMargin: choseAbcTab.currentIndex < 2 ? 200 : 160
                                anchors.leftMargin: -15

                                Label {
                                    text: textOutSpaces
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                SpinBox {
                                    id: spaceSpin2
                                    font.family: "Poppins Medium"
                                    Layout.maximumWidth: 100
                                    Layout.minimumWidth: 65
                                    Layout.maximumHeight: 24
                                    Layout.minimumHeight: 24
                                    enabled: activeWindow
                                    value: mySpaces
                                    stepSize: 1
                                    to: 99
                                    from: 0
                                    background: Rectangle {
                                        color: myBackground2
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        border.width: .5
                                        anchors.fill: parent
                                        radius: 8
                                    }
                                    down.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 3
                                        anchors.rightMargin: 44
                                        radius: 8
                                        color: spaceSpin2.down.pressed ? myHighLighht : (spaceSpin2.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin2.down.pressed ? myHighLighht : (spaceSpin2.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                    myBackground2)
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.topMargin: 0
                                            anchors.bottomMargin: 0
                                            anchors.rightMargin: 0
                                        }

                                        Text {
                                            text: '❰'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }

                                    up.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        radius: 8
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 44
                                        anchors.rightMargin: 3
                                        color: spaceSpin2.up.pressed ? myHighLighht : (spaceSpin2.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin2.up.pressed ? myHighLighht : (spaceSpin2.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                        myBackground2)
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                        }

                                        Text {
                                            text: '❱'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }
                                    onValueChanged: {
                                        spaceSpin.value = spaceSpin2.value 
                                    }
                                }

                                Label {
                                    text: textOutSpaces2
                                    Layout.rightMargin: 20
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }
                            }
                        }
                        Button{
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.maximumHeight :50
                            visible: choseAbcTab.currentIndex < 2 ? false : true
                            background: Rectangle {
                                color: parent.down ? myHighLighht : (parent.hovered ? Qt.lighter(myBackground, 2) : myBackground)
                                anchors.fill: parent
                                radius: 8
                            }
                            Label {
                                anchors.fill: parent
                                color: parent.down ? myUpperBar: myWhiteFont
                                text: makeCircle
                                Layout.rightMargin: 20
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pixelSize: 12
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.family: "Poppins Medium"
                            }
                            onClicked: {
                                activeWindow = false
                                circleDraw.show()
                            }
                        }
                    }
                }

                // right column
                StackLayout {
                    width: 200
                    height: 200
                    currentIndex: naiveModernTab.currentIndex
                    Layout.fillWidth: true
                    Layout.bottomMargin: -6
                    Layout.rightMargin: 14
                    Layout.minimumWidth: 300
                    Layout.maximumWidth: 350
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true

                    // naive brench
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.rightMargin: 4
                        Layout.topMargin: 0
                        Layout.leftMargin: 2

                        StackLayout {
                            id: stackView
                            width: 200
                            height: 100
                            Layout.minimumHeight: 100
                            Layout.maximumHeight: 100
                            Layout.fillWidth: true
                            Layout.fillHeight: false
                            currentIndex: textFileTab.currentIndex

                            Flickable {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                TextArea.flickable: TextArea {
                                    id: inputText
                                    visible: true
                                    selectByMouse: true
                                    color: myWhiteFont
                                    enabled: activeWindow
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    wrapMode: Text.WrapAnywhere
                                    textFormat: Text.AutoText
                                    placeholderTextColor: Qt.darker(myWhiteFont, 2)
                                    font.family: "Roboto Medium"
                                    font.hintingPreference: Font.PreferFullHinting
                                    font.capitalization: choseAbcTab.currentIndex == 2 && keySensitive ? Font.MixedCase : Font.AllUppercase
                                    placeholderText: textHere
                                    background: Rectangle {
                                        color: myBackground
                                        radius: 8
                                    }
                                    onEditingFinished: {
                                        inputText2.text = inputText.text 
                                    }
                                }

                                ScrollBar.vertical: ScrollBar {}
                            }

                            ColumnLayout {
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                Button {
                                    id: btnChoseFile
                                    enabled: activeWindow
                                    Layout.topMargin: 16
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    background: Rectangle {
                                        anchors.fill: parent
                                        color: btnChoseFile.down ? myHighLighht : (btnChoseFile.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                        radius: 8

                                        Label {
                                            text: buttonChoseFile
                                            anchors.fill: parent
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            font.family: "Roboto Medium"
                                            color: myWhiteFont
                                        }
                                    }
                                    onClicked: fileDialog.visible = true
                                }


                                Label {
                                    id: fileState
                                    Layout.fillWidth: true
                                    text: textChoseFile
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    topPadding: 8
                                    bottomPadding: 16
                                    font.family: "Poppins Medium"
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    color: myUpperBar
                                }
                                
                            }
                
                        }

                        TabBar {
                            id: textFileTab
                            width: 240
                            height: 35
                            enabled: activeWindow
                            position: TabBar.Footer
                            font.family: "Roboto Medium"
                            Layout.topMargin: -6
                            Layout.rightMargin: 4
                            Layout.leftMargin: 4
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Layout.fillWidth: true

                            TabButton {
                                id: textButtno
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: textButtno.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: textFile
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: textFileTab.currentIndex == 0 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: textButtno.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: textFileTab.currentIndex == 0 ? myHighLighht : (textButtno.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        radius: 4
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: textFileTab2.currentIndex = textFileTab.currentIndex
                            }

                            TabButton {
                                id: fileButton
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                bottomPadding: 18
                                padding: 8
                                background: Rectangle {
                                    color: fileButton.hovered
                                            && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                    anchors.fill: parent
                                    Label {
                                        text: fileText
                                        anchors.verticalCenter: parent.verticalCenter
                                        font.weight: Font.Medium
                                        font.family: "Poppins Medium"
                                        anchors.verticalCenterOffset: textFileTab.currentIndex == 1 ? 2 : 0
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        color: fileButton.hovered
                                                && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                    }

                                    Rectangle {
                                        height: 4
                                        color: textFileTab.currentIndex == 1 ? myHighLighht : (fileButton.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                myBackground2)
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.top: parent.top
                                        anchors.rightMargin: 0
                                        anchors.leftMargin: 0
                                        anchors.topMargin: 0
                                    }
                                }
                                onClicked: textFileTab2.currentIndex = textFileTab.currentIndex
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                Layout.maximumHeight: 40
                                spacing: 0

                                Label {
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    text: textShift + shifter.value
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                Slider {
                                    id: shifter
                                    touchDragThreshold: 0
                                    from: 1
                                    to: choseAbcTab.currentIndex == 0 ? basicMaxShift : (choseAbcTab.currentIndex == 1 ? extMaxShift : customMaxShift)
                                    stepSize: 1
                                    enabled: activeWindow
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    Layout.leftMargin: 20
                                    Layout.rightMargin: 20
                                    value: 1

                                    background: Rectangle {
                                        x: shifter.leftPadding
                                        y: shifter.topPadding
                                            + shifter.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 6
                                        width: shifter.availableWidth
                                        height: implicitHeight
                                        radius: 3
                                        color: myBackground

                                        Rectangle {
                                            width: shifter.visualPosition * parent.width
                                            height: parent.height
                                            color: myUpperBar
                                            radius: 3
                                        }
                                    }

                                    handle: Rectangle {
                                        x: shifter.leftPadding + shifter.visualPosition
                                            * (shifter.availableWidth - width)
                                        y: shifter.topPadding
                                            + shifter.availableHeight / 2 - height / 2
                                        implicitWidth: 20
                                        implicitHeight: 12
                                        radius: 4
                                        color: shifter.pressed ? myHighLighht : (shifter.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.maximumHeight: 50

                                Label {
                                    text: textSpaces
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                TextField {
                                    id: repSpaces
                                    selectByMouse: true
                                    color: myUpperBar
                                    enabled: activeWindow
                                    horizontalAlignment: Text.AlignHCenter
                                    font.capitalization: choseAbcTab.currentIndex == 2 && keySensitive ? Font.MixedCase : Font.AllUppercase
                                    font.family: "Poppins Medium"
                                    placeholderTextColor: Qt.lighter(myUpperBar, 2)
                                    placeholderText: repSpc
                                    Layout.rightMargin: 40
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 24
                                    Layout.minimumWidth: 40
                                    Layout.maximumWidth: 120
                                    background: Rectangle {
                                        color: myBackground2
                                        border.width: 1
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        radius: 8
                                    }
                                    onEditingFinished: {
                                        repSpaces2.text = repSpaces.text
                                    }
                                }
                            }

                            RowLayout {
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.maximumHeight: 50

                                Label {
                                    text: textOutSpaces
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignRight
                                    verticalAlignment: Text.AlignVCenter
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }

                                SpinBox {
                                    id: spaceSpin
                                    font.family: "Poppins Medium"
                                    Layout.maximumWidth: 100
                                    Layout.minimumWidth: 65
                                    Layout.maximumHeight: 24
                                    Layout.minimumHeight: 24
                                    enabled: activeWindow
                                    value: mySpaces
                                    stepSize: 1
                                    to: 99
                                    from: 0
                                    background: Rectangle {
                                        color: myBackground2
                                        border.color: Qt.darker(myBackground2, 1.1)
                                        border.width: .5
                                        anchors.fill: parent
                                        radius: 8
                                    }
                                    down.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 3
                                        anchors.rightMargin: 44
                                        radius: 8
                                        color: spaceSpin.down.pressed ? myHighLighht : (spaceSpin.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin.down.pressed ? myHighLighht : (spaceSpin.down.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                    myBackground2)
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.topMargin: 0
                                            anchors.bottomMargin: 0
                                            anchors.rightMargin: 0
                                        }

                                        Text {
                                            text: '❰'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }

                                    up.indicator: Rectangle {
                                        height: 20
                                        width: 20
                                        radius: 8
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.verticalCenterOffset: 0
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.leftMargin: 44
                                        anchors.rightMargin: 3
                                        color: spaceSpin.up.pressed ? myHighLighht : (spaceSpin.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                    myBackground2)

                                        Rectangle {
                                            width: 8
                                            color: spaceSpin.up.pressed ? myHighLighht : (spaceSpin.up.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) :
                                                        myBackground2)
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            anchors.bottomMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                        }

                                        Text {
                                            text: '❱'
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            padding: 0
                                            font.pixelSize: 18
                                            font.family: "Poppins Medium"
                                            font.weight: Font.Medium
                                        }
                                    }
                                    onValueChanged: {
                                        spaceSpin2.value = spaceSpin.value 
                                    }
                                }

                                Label {
                                    text: textOutSpaces2
                                    Layout.rightMargin: 20
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pixelSize: 12
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                    font.family: "Poppins Medium"
                                    color: myUpperBar
                                }
                            }

                            ColumnLayout {
                                spacing: 0
                                Layout.fillHeight: true
                                Layout.fillWidth: true

                                Button {
                                    id: encButton
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 54
                                    enabled: activeWindow && choseAbcTab.currentIndex < 2 ? true : 
                                            (activeWindow && choseAbcTab.currentIndex == 2 && customLenght() > 8 ? true : false)
                                    function customLenght(){
                                        return customAlpha.length
                                    }
                                    background: Rectangle {
                                        color: encButton.down ? myHighLighht : (encButton.hovered && activeWindow &&
                                        (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                        anchors.fill: parent
                                        radius: 8
                                        function customLenght(){
                                            return customAlpha.length
                                        }
                                        Rectangle {
                                            height: 8
                                            color: encButton.down ? myHighLighht : (encButton.hovered && activeWindow && 
                                                    (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.bottom: parent.bottom
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.bottomMargin: 0
                                            function customLenght(){
                                                return customAlpha.length
                                            }
                                        }
                                    }


                                    Label {
                                        text: textEncode
                                        anchors.fill: parent
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                        font.weight: Font.Medium
                                        color: encButton.down ? myUpperBar : myWhiteFont
                                        padding: 8
                                    }
                                    onClicked: {
                                        var spcStr = repSpaces.text
                                        if(choseAbcTab.currentIndex == 0){
                                            spcStr = spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (basicAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else if (choseAbcTab.currentIndex == 1) {
                                            spcStr =spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                alphaErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (extAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else {
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else if (keySensitive) {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            } else {
                                                spcStr = spcStr.toUpperCase()
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        }
                                        if (!spaceErr) {
                                        
                                            if (!inputErr) {
                                                if (naiveModernTab.currentIndex == 0) {
                                                    myData.getType(false)
                                                } else {
                                                    myData.getType(true)
                                                }
                                                if (choseAbcTab.currentIndex == 0) {
                                                    myData.getAbc(basicAlpha)
                                                } else if (choseAbcTab.currentIndex == 1) {
                                                    myData.getAbc(extAlpha)
                                                } else {
                                                    myData.getAbc(customAlpha)
                                                }
                                                if (textFileTab.currentIndex == 0) {
                                                    if(!inputText.text) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow = false
                                                    } else {
                                                        inputErr == false
                                                        myData.getInputIndex(false)
                                                        var myInput = inputText.text
                                                        if (choseAbcTab < 2 || keySensitive == false) {
                                                            myInput = myInput.toUpperCase()
                                                        }
                                                        myData.getInput(myInput)
                                                    }
                                                } else {
                                                    var inputFile = String(fileDialog.currentFile)
                                                    if (!inputFile.length) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow= false
                                                    } else {
                                                        inputErr = false
                                                        myData.getInputIndex(true)
                                                        myData.getInput(fileDialog.currentFile)
                                                    }
                                                }
                                                    
                                                if (openText.indexOf(spcStr) < 0 || spcStr == ""){
                                                    repErr = false
                                                    if (!inputErr){
                                                        myData.getShift(shifter.value)
                                                        myData.getRepSpaces(spcStr)
                                                        myData.getOutputSpaces(spaceSpin.value)
                                                        myData.encode()
                                                        if (repairCount > 0) {
                                                            activeWindow = false
                                                            var component = Qt.createComponent("Repair.qml")
                                                            var win = component.createObject()
                                                            win.crComp()
                                                        } else {
                                                            mySpaces = 5.0
                                                            abcList = ["a", "b"]
                                                            badChar = ["@", "&"]
                                                            inputFile = ""
                                                            winSol.show()
                                                            activeWindow = false
                                                            
                                                        }
                                                    }
                                                } else {
                                                    openText = ""
                                                    repErr = true
                                                    activeWindow = false
                                                    winErr.show()
                                                }
                                            }
                                        }
                                    }
                                }

                                Button {
                                    id: decButton
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 54
                                    enabled: activeWindow && choseAbcTab.currentIndex < 2 ? true : 
                                            (activeWindow && choseAbcTab.currentIndex == 2 && customLenght() > 8 ? true : false)
                                    function customLenght(){
                                        return customAlpha.length
                                    }
                                    background: Rectangle {
                                        color: decButton.down ? myHighLighht : (decButton.hovered && activeWindow && 
                                                (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                        anchors.fill: parent
                                        radius: 8
                                            function customLenght(){
                                            return customAlpha.length
                                        }
                                        Rectangle {
                                            height: 8
                                            color: decButton.down ? myHighLighht : (decButton.hovered && activeWindow && 
                                                    (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                            function customLenght(){
                                                return customAlpha.length
                                            }
                                        }
                                    }
                                    Label {
                                        text: textDecode
                                        anchors.fill: parent
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                        font.weight: Font.Medium
                                        color: decButton.down ? myUpperBar : myWhiteFont
                                        padding: 8
                                    }
                                    onClicked: {
                                        var spcStr = repSpaces.text
                                        if(choseAbcTab.currentIndex == 0){
                                            spcStr = spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (basicAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else if (choseAbcTab.currentIndex == 1) {
                                            spcStr =spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                alphaErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (extAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else {
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else if (keySensitive) {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            } else {
                                                spcStr = spcStr.toUpperCase()
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        }
                                        if (!spaceErr) {
                                        
                                            if (!inputErr) {
                                                if (naiveModernTab.currentIndex == 0) {
                                                    myData.getType(false)
                                                } else {
                                                    myData.getType(true)
                                                }
                                                if (choseAbcTab.currentIndex == 0) {
                                                    myData.getAbc(basicAlpha)
                                                } else if (choseAbcTab.currentIndex == 1) {
                                                    myData.getAbc(extAlpha)
                                                } else {
                                                    myData.getAbc(customAlpha)
                                                }
                                                if (textFileTab.currentIndex == 0) {
                                                    if(!inputText.text) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow = false
                                                    } else {
                                                        inputErr == false
                                                        myData.getInputIndex(false)
                                                        var myInput = inputText.text
                                                        if (choseAbcTab < 2 || keySensitive == false) {
                                                            myInput = myInput.toUpperCase()
                                                        }
                                                        if (choseAbcTab.currentIndex == 0) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!basicAlpha.includes(myInput[i]))  { 
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        } else if (choseAbcTab.currentIndex == 1) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!extAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                            myData.getAbc(extAlpha)
                                                        } else {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!customAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        }
                                                        if(!inputErr) {myData.getInput(myInput)}
                                                    }
                                                } else {
                                                    var inputFile = String(fileDialog.currentFile)
                                                    if (!inputFile.length) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow= false
                                                    } else {
                                                        inputErr = false
                                                        myData.getInputIndex(true)
                                                        if (choseAbcTab.currentIndex == 0) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!basicAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        } else if (choseAbcTab.currentIndex == 1) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!extAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                            myData.getAbc(extAlpha)
                                                        } else {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!customAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        }
                                                        if(!inputErr) {myData.getInput(fileDialog.currentFile)}
                                                    }
                                                }
                                                if (!inputErr){
                                                    myData.getShift(shifter.value)
                                                    myData.getRepSpaces(spcStr)
                                                    myData.getOutputSpaces(spaceSpin.value)
                                                    myData.decode()
                                                    winSol.show()
                                                
                                                    mySpaces = 5.0
                                                    abcList = ["a", "b"]
                                                    badChar = ["@", "&"]
                                                    inputFile = ""
                                                    activeWindow = false
                                                
                                                }
                                            }
                                        }
                                    }
                                }

                                WinSol {
                                    id: winSol
                                    visible: false
                                }

                                WinErr {
                                    id: winErr
                                    visible: false
                                }
                            }
                        }
                    }
                    
                    // modern brench
                    RowLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Rectangle {
                            color:  "transparent"
                            Layout.margins: 1
                            Layout.rightMargin: 0
                            Layout.bottomMargin: 24
                            Layout.leftMargin: 4
                            Layout.topMargin: 0
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            ColumnLayout {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.top: parent.top
                                anchors.rightMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                spacing: 0

                                StackLayout {
                                    width: 200
                                    height: 100
                                    Layout.minimumHeight: 100
                                    Layout.maximumHeight: 100
                                    Layout.fillWidth: true
                                    Layout.fillHeight: false
                                    currentIndex: textFileTab2.currentIndex

                                    Flickable {
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        TextArea.flickable: TextArea {
                                            id: inputText2
                                            visible: true
                                            selectByMouse: true
                                            color: myWhiteFont
                                            enabled: activeWindow
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            wrapMode: Text.WrapAnywhere
                                            textFormat: Text.AutoText
                                            placeholderTextColor: Qt.darker(myWhiteFont, 2)
                                            font.family: "Roboto Medium"
                                            font.hintingPreference: Font.PreferFullHinting
                                            font.capitalization: choseAbcTab.currentIndex == 2 && keySensitive ? Font.MixedCase : Font.AllUppercase
                                            placeholderText: textHere
                                            background: Rectangle {
                                                color: myBackground
                                                radius: 8
                                            }
                                            onEditingFinished: {
                                                inputText.text = inputText2.text 
                                            }
                                        }

                                        ScrollBar.vertical: ScrollBar {}
                                    }

                                    ColumnLayout {
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true

                                        Button {
                                            id: btnChoseFile2
                                            enabled: activeWindow
                                            Layout.topMargin: 16
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            background: Rectangle {
                                                anchors.fill: parent
                                                color: btnChoseFile2.down ? myHighLighht : (btnChoseFile2.hovered && activeWindow ? Qt.lighter(myBackground, 2) : myBackground)
                                                radius: 8

                                                Label {
                                                    text: buttonChoseFile
                                                    anchors.fill: parent
                                                    horizontalAlignment: Text.AlignHCenter
                                                    verticalAlignment: Text.AlignVCenter
                                                    font.family: "Roboto Medium"
                                                    color: myWhiteFont
                                                }
                                            }
                                            onClicked: fileDialog.visible = true
                                        }


                                        Label {
                                            id: fileState2
                                            Layout.fillWidth: true
                                            text: textChoseFile
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            topPadding: 8
                                            bottomPadding: 16
                                            font.family: "Poppins Medium"
                                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                            color: myUpperBar
                                        }
                                        
                                    }
                        
                                }

                                TabBar {
                                    id: textFileTab2
                                    width: 240
                                    height: 35
                                    enabled: activeWindow
                                    position: TabBar.Footer
                                    font.family: "Roboto Medium"
                                    Layout.bottomMargin: 8
                                    Layout.topMargin: 0
                                    Layout.rightMargin: 4
                                    Layout.leftMargin: 4
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    Layout.fillWidth: true

                                    TabButton {
                                        id: textButtno2
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        bottomPadding: 18
                                        padding: 8
                                        background: Rectangle {
                                            color: textButtno2.hovered
                                                    && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                            anchors.fill: parent
                                            Label {
                                                text: textFile
                                                anchors.verticalCenter: parent.verticalCenter
                                                font.weight: Font.Medium
                                                font.family: "Poppins Medium"
                                                anchors.verticalCenterOffset: textFileTab2.currentIndex == 0 ? 2 : 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                color: textButtno2.hovered
                                                        && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                            }

                                            Rectangle {
                                                height: 4
                                                color: textFileTab2.currentIndex == 0 ? myHighLighht : (textButtno2.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                        myBackground2)
                                                radius: 4
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: parent.top
                                                anchors.rightMargin: 0
                                                anchors.leftMargin: 0
                                                anchors.topMargin: 0
                                            }
                                        }
                                        onClicked: textFileTab.currentIndex = textFileTab2.currentIndex
                                    }

                                    TabButton {
                                        id: fileButton2
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom
                                        bottomPadding: 18
                                        padding: 8
                                        background: Rectangle {
                                            color: fileButton2.hovered
                                                    && activeWindow ? Qt.darker(myBackground2, 1.25) : myBackground2
                                            anchors.fill: parent
                                            Label {
                                                text: fileText
                                                anchors.verticalCenter: parent.verticalCenter
                                                font.weight: Font.Medium
                                                font.family: "Poppins Medium"
                                                anchors.verticalCenterOffset: textFileTab2.currentIndex == 1 ? 2 : 0
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                color: fileButton2.hovered
                                                        && activeWindow ? Qt.darker(myWhiteFont, 1.25) : myUpperBar
                                            }

                                            Rectangle {
                                                height: 4
                                                color: textFileTab2.currentIndex == 1 ? myHighLighht : (fileButton2.hovered && activeWindow ? Qt.darker(myBackground2, 1.25) : 
                                                        myBackground2)
                                                anchors.left: parent.left
                                                anchors.right: parent.right
                                                anchors.top: parent.top
                                                anchors.rightMargin: 0
                                                anchors.leftMargin: 0
                                                anchors.topMargin: 0
                                            }
                                        }
                                        onClicked: textFileTab.currentIndex = textFileTab2.currentIndex

                                    }
                                }

                                Button {
                                    id: encButton2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 54
                                    Layout.minimumHeight:54
                                    enabled: activeWindow && choseAbcTab.currentIndex < 2 ? true : 
                                            (activeWindow && choseAbcTab.currentIndex == 2 && customLenght() > 8 ? true : false)
                                    function customLenght(){
                                        return customAlpha.length
                                    }
                                    background: Rectangle {
                                        color: encButton2.down ? myHighLighht : (encButton2.hovered && activeWindow &&
                                        (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                        anchors.fill: parent
                                        radius: 8
                                        function customLenght(){
                                            return customAlpha.length
                                        }
                                        Rectangle {
                                            height: 8
                                            color: encButton2.down ? myHighLighht : (encButton2.hovered && activeWindow && 
                                                    (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.bottom: parent.bottom
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.bottomMargin: 0
                                            function customLenght(){
                                                return customAlpha.length
                                            }
                                        }
                                    }


                                    Label {
                                        text: textEncode
                                        anchors.fill: parent
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                        font.weight: Font.Medium
                                        color: encButton2.down ? myUpperBar : myWhiteFont
                                        padding: 8
                                    }
                                    onClicked: {
                                        var spcStr = repSpaces.text
                                        if(choseAbcTab.currentIndex == 0){
                                            spcStr = spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (basicAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else if (choseAbcTab.currentIndex == 1) {
                                            spcStr =spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                alphaErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (extAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else {
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else if (keySensitive) {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            } else {
                                                spcStr = spcStr.toUpperCase()
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        }
                                        if (!spaceErr) {
                                        
                                            if (!inputErr) {
                                                if (naiveModernTab.currentIndex == 0) {
                                                    myData.getType(false)
                                                } else {
                                                    myData.getType(true)
                                                }
                                                if (choseAbcTab.currentIndex == 0) {
                                                    myData.getAbc(basicAlpha)
                                                } else if (choseAbcTab.currentIndex == 1) {
                                                    myData.getAbc(extAlpha)
                                                } else {
                                                    myData.getAbc(customAlpha)
                                                }
                                                if (textFileTab2.currentIndex == 0) {
                                                    if(!inputText2.text) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow = false
                                                    } else {
                                                        inputErr == false
                                                        myData.getInputIndex(false)
                                                        var myInput = inputText2.text
                                                        if (choseAbcTab < 2 || keySensitive == false) {
                                                            myInput = myInput.toUpperCase()
                                                        }
                                                        myData.getInput(myInput)
                                                    }
                                                } else {
                                                    var inputFile2 = String(fileDialog.currentFile)
                                                    if (!inputFile2.length) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow= false
                                                    } else {
                                                        inputErr = false
                                                        myData.getInputIndex(true)
                                                        myData.getInput(fileDialog.currentFile)
                                                    }
                                                }
                                                    
                                                if (openText.indexOf(spcStr) < 0 || spcStr == ""){
                                                    repErr = false
                                                    if (!inputErr){
                                                        myData.getAB(shifterA.value, shifterB.value)
                                                        myData.getRepSpaces(spcStr)
                                                        myData.getOutputSpaces(spaceSpin2.value)
                                                        myData.encode()
                                                        if (repairCount > 0) {
                                                            activeWindow = false
                                                            var component = Qt.createComponent("Repair.qml")
                                                            var win = component.createObject()
                                                            win.crComp()
                                                        } else {
                                                            mySpaces = 5.0
                                                            abcList = ["a", "b"]
                                                            badChar = ["@", "&"]
                                                            inputFile = ""
                                                            winSol.show()
                                                            activeWindow = false
                                                            
                                                        }
                                                    }
                                                } else {
                                                    openText = ""
                                                    repErr = true
                                                    activeWindow = false
                                                    winErr.show()
                                                }
                                            }
                                        }
                                    }
                                }

                                Button {
                                    id: decButton2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumHeight: 54
                                    Layout.minimumHeight:54
                                    enabled: activeWindow && choseAbcTab.currentIndex < 2 ? true : 
                                            (activeWindow && choseAbcTab.currentIndex == 2 && customLenght() > 8 ? true : false)
                                    function customLenght(){
                                        return customAlpha.length
                                    }
                                    background: Rectangle {
                                        color: decButton2.down ? myHighLighht : (decButton2.hovered && activeWindow && 
                                                (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                        anchors.fill: parent
                                        radius: 8
                                            function customLenght(){
                                            return customAlpha.length
                                        }
                                        Rectangle {
                                            height: 8
                                            color: decButton2.down ? myHighLighht : (decButton2.hovered && activeWindow && 
                                                    (choseAbcTab.currentIndex < 2 || customLenght() > 8) ? Qt.lighter(myBackground, 2) : myBackground)
                                            anchors.left: parent.left
                                            anchors.right: parent.right
                                            anchors.top: parent.top
                                            anchors.rightMargin: 0
                                            anchors.leftMargin: 0
                                            anchors.topMargin: 0
                                            function customLenght(){
                                                return customAlpha.length
                                            }
                                        }
                                    }
                                    Label {
                                        text: textDecode
                                        anchors.fill: parent
                                        font.pixelSize: 12
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        font.family: "Roboto Medium"
                                        font.weight: Font.Medium
                                        color: decButton2.down ? myUpperBar : myWhiteFont
                                        padding: 8
                                    }
                                    onClicked: {
                                        var spcStr = repSpaces.text
                                        if(choseAbcTab.currentIndex == 0){
                                            spcStr = spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (basicAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else if (choseAbcTab.currentIndex == 1) {
                                            spcStr =spcStr.toUpperCase()
                                            if (repSpaces.text == "") {
                                                alphaErr = false
                                            } else {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (extAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        } else {
                                            if (repSpaces.text == "") {
                                                spaceErr = false
                                            } else if (keySensitive) {
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            } else {
                                                spcStr = spcStr.toUpperCase()
                                                for (var i = 0; i < spcStr.length; i++) {
                                                    if (customAlpha.search(spcStr[i] )< 0) {
                                                        spaceErr = true
                                                        winErr.show()
                                                        break
                                                    } else {
                                                        spaceErr = false
                                                    }
                                                }
                                            }
                                        }
                                        if (!spaceErr) {
                                        
                                            if (!inputErr) {
                                                if (naiveModernTab.currentIndex == 0) {
                                                    myData.getType(false)
                                                } else {
                                                    myData.getType(true)
                                                }
                                                if (choseAbcTab.currentIndex == 0) {
                                                    myData.getAbc(basicAlpha)
                                                } else if (choseAbcTab.currentIndex == 1) {
                                                    myData.getAbc(extAlpha)
                                                } else {
                                                    myData.getAbc(customAlpha)
                                                }
                                                if (textFileTab2.currentIndex == 0) {
                                                    if(!inputText2.text) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow = false
                                                    } else {
                                                        inputErr == false
                                                        myData.getInputIndex(false)
                                                        var myInput = inputText2.text
                                                        if (choseAbcTab < 2 || keySensitive == false) {
                                                            myInput = myInput.toUpperCase()
                                                        }
                                                        if (choseAbcTab.currentIndex == 0) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!basicAlpha.includes(myInput[i]))  { 
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        } else if (choseAbcTab.currentIndex == 1) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!extAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                            myData.getAbc(extAlpha)
                                                        } else {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!customAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        }
                                                        if(!inputErr) {myData.getInput(myInput)}
                                                    }
                                                } else {
                                                    var inputFile2 = String(fileDialog.currentFile)
                                                    if (!inputFile2.length) {
                                                        inputErr = true
                                                        winErr.show()
                                                        activeWindow= false
                                                    } else {
                                                        inputErr = false
                                                        myData.getInputIndex(true)
                                                        if (choseAbcTab.currentIndex == 0) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!basicAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        } else if (choseAbcTab.currentIndex == 1) {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!extAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                            myData.getAbc(extAlpha)
                                                        } else {
                                                            for (var i = 0; i < myInput.length; i++) {
                                                                if (!customAlpha.includes(myInput[i]))  {   
                                                                    inputErr = true
                                                                    inDecErr = true
                                                                    winErr.show()
                                                                    activeWindow = false
                                                                    break
                                                                }
                                                            }
                                                        }
                                                        if(!inputErr) {myData.getInput(fileDialog.currentFile)}
                                                    }
                                                }
                                                if (!inputErr){
                                                    myData.getAB(shifterA.value, shifterB.value)
                                                    myData.getRepSpaces(spcStr)
                                                    myData.getOutputSpaces(spaceSpin2.value)
                                                    myData.decode()
                                                    winSol.show()
                                                
                                                    mySpaces = 5.0
                                                    abcList = ["a", "b"]
                                                    badChar = ["@", "&"]
                                                    inputFile = ""
                                                    activeWindow = false
                                                
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                
                
            }
        }

        // effects
        Rectangle {
            id: windowGlow
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
            anchors.fill: windowGlow
            radius: 12
            transparentBorder: true
            source: windowGlow
            z: -1
        }
        HueSaturation {
            anchors.fill: window
            source: window
            saturation: activeWindow ? 0 : -.75
            lightness: activeWindow ? 0 : -0.25
        }
        HueSaturation {
            anchors.fill: windowGlow
            source: windowGlow
            saturation: activeWindow ? 0 : -.85
            lightness: activeWindow ? 0 : -0.25
            z: -1
        }
    }

    FileDialog {
        id: fileDialog
        visible: false
        nameFilters: [ "Text files (*.txt)"]
        onAccepted: {
            var url = String(fileDialog.currentFile)
            var index = 0
            var urlCh = url.split("")
            for (let i =0; i <url.length; i++){
                if(urlCh[i] === "/") {index = i + 1;}
            }
            var filename = url.substring(index);
            fileState.text = filename
            fileState2.text = filename

        }
        onRejected: {
            fileState.text = textChoseFile
            fileState2.text = textChoseFile
        }

    }    

    Connections {
        target: myData
        function onRepCount(myRepCount) {
            repairCount = myRepCount
        }

        function onAbcList(myAbcList) {
            abcList = myAbcList
        }

        function onIllegalChars(ilCh) {
            badChar = ilCh
        }

        function onFinalAbc(FAbc) {
            customAlpha = FAbc
        }

        function onOpenText(opT) {
            openText = opT
        }

        function onEncodeText(enT) {
            encodedText = enT
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/

