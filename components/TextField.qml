import QtQuick 1.1

FocusScope {
    height: 18
    width: 33

    property alias text: textInput.text
    property alias validator: textInput.validator
    property alias maximumLength: textInput.maximumLength

    property bool selectAllOnFocus: true

    Rectangle {
        anchors.fill: parent

        border.color: textInput.activeFocus ? "gray" : "silver"
        radius: 2
        smooth: true

        TextInput {
            id: textInput
            focus: true

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 4
            anchors.verticalCenter: parent.verticalCenter

            selectByMouse: true

            onActiveFocusChanged: if(selectAllOnFocus && activeFocus) selectAll();
        }
    }
}
