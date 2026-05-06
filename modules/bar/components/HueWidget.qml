import QtQuick
import qs.components
import qs.services

Item {
    id: root

    readonly property string name: "openhue"

    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight

    MaterialIcon {
        id: icon

        anchors.centerIn: parent

        text: "lightbulb"
        color: OpenHue.lights.some(l => l.on) || OpenHue.rooms.some(r => r.on)
            ? Colours.palette.m3tertiary
            : Colours.palette.m3secondary
    }
}
