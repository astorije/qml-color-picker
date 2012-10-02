import QtQuick 1.1

Item {
    width:  orientation === Qt.Vertical ?
                style === "compact" ? 20 : 40
                : 250
    height: orientation === Qt.Vertical ?
                250 :
                style === "compact" ? 20 : 40

    property real value: 0.0

    property alias mouseX: mouseArea.mouseX
    property alias mouseY: mouseArea.mouseY

    property alias color: rect.color
    property alias gradient: rect.gradient

    property int orientation: Qt.Vertical

    property string style: "default" // Values are: "default", "compact"

    Item {
        anchors.fill: parent
        anchors.leftMargin:    orientation === Qt.Vertical ? tick.width + 2 : 0
        anchors.rightMargin:   style === "compact" ? 0 : anchors.leftMargin
        anchors.topMargin:     orientation === Qt.Vertical ? 0 : tick.height + 2
        anchors.bottomMargin:  style === "compact" ? 0 : anchors.topMargin

        TransparentBackground {
            anchors.fill: parent
        }

        Rectangle {
            id: rect
            color: "transparent"
            width:    orientation === Qt.Vertical ? parent.width  : parent.height
            height:   orientation === Qt.Vertical ? parent.height : parent.width
            x:        orientation === Qt.Vertical ? 0 : height / 2 - width / 2
            y:        orientation === Qt.Vertical ? 0 : width / 2 - height / 2
            rotation: orientation === Qt.Vertical ? 0 : 270
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

    Image {
        id: tick
        source:   orientation === Qt.Vertical ? "content/left_tick.png" : "content/top_tick.png"
        x:        orientation === Qt.Vertical ? 0 : value * mouseArea.width - width / 2
        y:        orientation === Qt.Vertical ? value * mouseArea.height - height / 2 : 0
    }

    Image {
        source:   orientation === Qt.Vertical ? "content/right_tick.png" : "content/bottom_tick.png"
        x:        orientation === Qt.Vertical ? parent.width - width : value * mouseArea.width - width / 2
        y:        orientation === Qt.Vertical ? value * mouseArea.height - height / 2 : parent.height - height

        visible: (style !== "compact")
    }
}
