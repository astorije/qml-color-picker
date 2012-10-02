import QtQuick 1.1

FocusScope {
    id: button

    width: 60
    height: 25

    property alias text: label.text
    property alias pressed: mouseArea.pressed
    signal clicked()

    Rectangle {
        anchors.fill: parent

        border.color: mouseArea.activeFocus ? "gray" : "silver"
        radius: 2
        smooth: true

        SystemPalette { id: palette }

        gradient: Gradient {
            id: inactiveGradient
            GradientStop { position: 0.0; color: "white" }
            GradientStop { position: 1.0; color: palette.button }
        }

        Gradient {
            id: pressedGradient
            GradientStop { position: 0.0; color: palette.button }
            GradientStop { position: 1.0; color: "white" }
        }

        Text {
            id: label
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            focus: true;
            onClicked: button.clicked()
            onPressedChanged: {
                if(mouseArea.pressed) {
                    parent.gradient = pressedGradient;
                    button.focus = true;
                }
                else
                    parent.gradient = inactiveGradient;
            }
        }

        Keys.onSpacePressed:  keyboardClick()
        Keys.onEnterPressed:  keyboardClick()
        Keys.onReturnPressed: keyboardClick()

        function keyboardClick() {
            button.clicked();
            gradient = pressedGradient;
            resetGradient.start();
        }

        Timer {
            id: resetGradient
            interval: 250
            onTriggered: parent.gradient = inactiveGradient;
        }
    }
}
