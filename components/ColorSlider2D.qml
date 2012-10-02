import QtQuick 1.1

Item {
    id: slider

    height: 100
    width: height

    clip: true

    property real xValue: 0.0
    property real yValue: 0.0

    property alias mouseX: mouseArea.mouseX
    property alias mouseY: mouseArea.mouseY
    signal mousePositionChanged


    Item {
        x: xValue * mouseArea.width - width / 2
        y: yValue * mouseArea.height - height / 2
        z: 1

        width: 30
        height: width

        Image {
            source:   "content/left_tick.png"
            anchors.verticalCenter: parent.verticalCenter
        }

        Image {
            source:   "content/top_tick.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image {
            source:   "content/right_tick.png"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
        }

        Image {
            source:   "content/bottom_tick.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onMousePositionChanged: slider.mousePositionChanged()
        z: 1
    }
}
