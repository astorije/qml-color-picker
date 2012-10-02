import QtQuick 1.1
import "components"

Rectangle {
    id: colorPicker

    height: 340
    width: 740

    SystemPalette { id: palette }
    color: palette.window

    property color previousColor: "transparent"
    property alias currentColor: currentColorComponents.color

    ColorComponents {
        id: currentColorComponents

        color: "black"

        onHueChanged: txtHue.text = Math.round(hue * 360);
        onSaturationChanged: txtSaturation.text = Math.round(saturation * 100);
        onValueChanged: txtValue.text = Math.round(value * 100);

        onRedChanged: txtRed.text = Math.round(red * 255);
        onGreenChanged: txtGreen.text = Math.round(green * 255);
        onBlueChanged: txtBlue.text = Math.round(blue * 255);

        onAlphaChanged: txtAlpha.text = Math.round(alpha * 255);

        onColorChanged: txtHex.text = fullName;
    }

    ColorSlider2D {
        id: sbSlider
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 20

        width: height

        xValue: currentColorComponents.saturation
        yValue: 1.0 - currentColorComponents.value

        Rectangle {
            anchors.fill: parent
            rotation: -90

            gradient: Gradient {
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 1.0; color: Qt.hsla(currentColorComponents.hue, 1.0, 0.5, 1.0) }
            }
        }

        Rectangle {
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 1.0; color: "black" }
                GradientStop { position: 0.0; color: "transparent" }
            }
        }

        onMousePositionChanged: {
            currentColorComponents.saturation = Math.max(0.0, Math.min(sbSlider.mouseX / sbSlider.width,        1.0));
            currentColorComponents.value      = Math.max(0.0, Math.min(1.0 - sbSlider.mouseY / sbSlider.height, 1.0));
        }
    }
    
    ColorSlider {
        id: hSlider
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: sbSlider.right
        anchors.margins: 20
        anchors.leftMargin: 15

        value: 1.0 - currentColorComponents.hue
        gradient: Gradient {
            GradientStop { position: 0/6; color: "red" }
            GradientStop { position: 1/6; color: "magenta" }
            GradientStop { position: 2/6; color: "blue" }
            GradientStop { position: 3/6; color: "cyan" }
            GradientStop { position: 4/6; color: "lime" }
            GradientStop { position: 5/6; color: "yellow" }
            GradientStop { position: 6/6; color: "red" }
        }

        onMouseYChanged: currentColorComponents.hue = Math.max(0.0, Math.min(1.0 - mouseY / height, 1.0));
    }

    Item {
        id: previewItem
        anchors.top: parent.top
        anchors.left: hSlider.right
        anchors.margins: 20
        anchors.leftMargin: anchors.margins + 17

        height: 55
        width: 160

        Text {
            text: "Current"
        }

        Text {
            text: "Previous"
            anchors.right: parent.right
        }

        Item {
            anchors.fill: parent
            anchors.topMargin: 15

            TransparentBackground {
                anchors.fill: parent
            }

            Rectangle {
                anchors.fill: parent
                anchors.rightMargin: parent.width / 2
                color: currentColor
            }

            Rectangle {
                anchors.fill: parent
                anchors.leftMargin: parent.width / 2
                color: previousColor

                MouseArea {
                    anchors.fill: parent
                    onClicked: currentColorComponents.color = previousColor
                }
            }
        }
    }

    Column {
        id: buttonColumn

        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: sliderColumn.right
        anchors.rightMargin: 14
        spacing: 5

        Button {
            id: btnOk
            text: "OK"
            onClicked: previousColor = currentColorComponents.color

            KeyNavigation.backtab: txtHex
            KeyNavigation.tab: btnReset
        }

        Button {
            id: btnReset
            text: "Reset"

            onClicked: {
                currentColor  = "black";
                previousColor = "transparent";
            }

            KeyNavigation.backtab: btnOk
            KeyNavigation.tab: txtHue
        }
    }

    Column {
        id: sliderColumn
        anchors.top: previewItem.bottom
        anchors.left: hSlider.right
        anchors.margins: 20

        spacing: 15

        Column {
            spacing: 5

            Row {
                spacing: 10

                Text {
                    text: "H"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.hue
                    gradient: Gradient {
                        GradientStop { position: 0/6; color: currentColorComponents.hsva(0 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 1/6; color: currentColorComponents.hsva(1 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 2/6; color: currentColorComponents.hsva(2 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 3/6; color: currentColorComponents.hsva(3 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 4/6; color: currentColorComponents.hsva(4 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 5/6; color: currentColorComponents.hsva(5 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 6/6; color: currentColorComponents.hsva(6 / 6, currentColorComponents.saturation, currentColorComponents.value, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.hue = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    TextField {
                        id: txtHue
                        text: Math.round(currentColorComponents.hue * 360)

                        validator: IntValidator {
                            bottom: 0
                            top: 360
                        }

                        onTextChanged: {
                            if(Math.round(currentColorComponents.hue * 360) !== parseInt(txtHue.text, 10))
                                currentColorComponents.hue = txtHue.text / 360;
                        }

                        KeyNavigation.backtab: btnReset
                        KeyNavigation.tab: txtSaturation
                    }

                    Text { text: " °" }
                }
            }

            Row {
                spacing: 10

                Text {
                    text: "S"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.saturation
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: currentColorComponents.hsva(currentColorComponents.hue, 0.0, currentColorComponents.value, currentColorComponents.alpha) }
                        GradientStop { position: 1.0; color: currentColorComponents.hsva(currentColorComponents.hue, 1.0, currentColorComponents.value, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.saturation = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    TextField {
                        id: txtSaturation
                        text: Math.round(currentColorComponents.saturation * 100)

                        validator: IntValidator {
                            bottom: 0
                            top: 100
                        }

                        onTextChanged: {
                            if(Math.round(currentColorComponents.saturation * 100) !== parseInt(txtSaturation.text, 10))
                                currentColorComponents.saturation = txtSaturation.text / 100
                        }

                        KeyNavigation.tab: txtValue
                        KeyNavigation.backtab: txtHue
                    }

                    Text { text: " %" }
                }

            }

            Row {
                spacing: 10

                Text {
                    text: "V"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.value
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: currentColorComponents.hsva(currentColorComponents.hue, currentColorComponents.saturation, 0.0, currentColorComponents.alpha) }
                        GradientStop { position: 1.0; color: currentColorComponents.hsva(currentColorComponents.hue, currentColorComponents.saturation, 1.0, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.value = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    TextField {
                        id: txtValue
                        text: Math.round(currentColorComponents.value * 100)

                        validator: IntValidator {
                            bottom: 0
                            top: 100
                        }

                        onTextChanged: {
                            if(Math.round(currentColorComponents.value * 100) !== parseInt(txtValue.text, 10))
                                currentColorComponents.value = txtValue.text / 100
                        }

                        KeyNavigation.tab: txtRed
                        KeyNavigation.backtab: txtSaturation
                    }

                    Text { text: " %" }
                }
            }
        }

        Column {
            spacing: 5
            Row {
                spacing: 10

                Text {
                    text: "R"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.red
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(0.0, currentColorComponents.green, currentColorComponents.blue, currentColorComponents.alpha) }
                        GradientStop { position: 1.0; color: Qt.rgba(1.0, currentColorComponents.green, currentColorComponents.blue, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.red = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                TextField {
                    id: txtRed
                    text: Math.round(currentColorComponents.red * 255)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    validator: IntValidator {
                        bottom: 0
                        top: 255
                    }

                    onTextChanged: {
                        if(Math.round(currentColorComponents.red * 255) !== parseInt(txtRed.text, 10))
                            currentColorComponents.red = txtRed.text / 255;
                    }

                    KeyNavigation.tab: txtGreen
                    KeyNavigation.backtab: txtValue
                }
            }

            Row {
                spacing: 10

                Text {
                    text: "G"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.green
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(currentColorComponents.red, 0.0, currentColorComponents.blue, currentColorComponents.alpha) }
                        GradientStop { position: 1.0; color: Qt.rgba(currentColorComponents.red, 1.0, currentColorComponents.blue, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.green = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                TextField {
                    id: txtGreen
                    text: Math.round(currentColorComponents.green * 255)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    validator: IntValidator {
                        bottom: 0
                        top: 255
                    }

                    onTextChanged: {
                        if(Math.round(currentColorComponents.green * 255) !== parseInt(txtGreen.text, 10))
                            currentColorComponents.green = txtGreen.text / 255;
                    }

                    KeyNavigation.tab: txtBlue
                    KeyNavigation.backtab: txtRed
                }

            }

            Row {
                spacing: 10

                Text {
                    text: "B"
                    width: 7
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 5
                }

                ColorSlider {
                    orientation: Qt.Horizontal
                    style: "compact"
                    value: currentColorComponents.blue
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Qt.rgba(currentColorComponents.red, currentColorComponents.green, 0.0, currentColorComponents.alpha) }
                        GradientStop { position: 1.0; color: Qt.rgba(currentColorComponents.red, currentColorComponents.green, 1.0, currentColorComponents.alpha) }
                    }

                    onMouseXChanged: currentColorComponents.blue = Math.max(0.0, Math.min(mouseX / width, 1.0));
                }

                TextField {
                    id: txtBlue
                    text: Math.round(currentColorComponents.blue * 255)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: 4

                    validator: IntValidator {
                        bottom: 0
                        top: 255
                    }

                    onTextChanged: {
                        if(Math.round(currentColorComponents.blue * 255) !== parseInt(txtBlue.text, 10))
                            currentColorComponents.blue = txtBlue.text / 255;
                    }

                    KeyNavigation.backtab: txtGreen
                    KeyNavigation.tab: txtAlpha
                }

            }
        }

        Row {
            spacing: 10

            Text {
                text: "A"
                width: 7
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 5
            }

            ColorSlider {
                orientation: Qt.Horizontal
                style: "compact"
                value: currentColorComponents.alpha
                gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.rgba(currentColorComponents.red, currentColorComponents.green, currentColorComponents.blue, 0.0) }
                    GradientStop { position: 1.0; color: Qt.rgba(currentColorComponents.red, currentColorComponents.green, currentColorComponents.blue, 1.0) }
                }

                onMouseXChanged: currentColorComponents.alpha = Math.max(0.0, Math.min(mouseX / width, 1.0));
            }

            TextField {
                id: txtAlpha
                text: Math.round(currentColorComponents.alpha * 255)
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 4

                validator: IntValidator {
                    bottom: 0
                    top: 255
                }

                onTextChanged: {
                    if(Math.round(currentColorComponents.alpha * 255) !== parseInt(txtAlpha.text, 10))
                        currentColorComponents.alpha = txtAlpha.text / 255;
                }

                KeyNavigation.backtab: txtBlue
                KeyNavigation.tab: txtHex
            }
        }
    }

    Row {
        id: hexadecimalRow

        spacing: 5
        anchors.top: sliderColumn.bottom
        anchors.topMargin: 3 + sliderColumn.spacing
        anchors.right: sliderColumn.right
        anchors.rightMargin: 14

        Text {
            text: "Hexadecimal"
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: txtHex
            text: currentColorComponents.fullName
            anchors.verticalCenter: parent.verticalCenter
            width: 65

            maximumLength: 9

            validator: RegExpValidator{
                regExp: /#?[0-9a-fA-F]*/
            }

            onTextChanged: {
                if(txtHex.text[0] !== '#')
                    txtHex.text = '#' + txtHex.text;

                if(txtHex.text.length !== 7 && txtHex.text.length !== 9)
                    return;

                if(currentColorComponents.fullName !== txtHex.text)
                    currentColorComponents.color = txtHex.text;
            }

            KeyNavigation.backtab: txtAlpha
            KeyNavigation.tab: btnOk
        }
    }
}
