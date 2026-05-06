pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.components
import qs.components.controls
import qs.services

Item {
    id: root

    required property PopoutState popouts

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    ColumnLayout {
        id: layout

        width: Tokens.sizes.bar.batteryWidth * 1.4
        spacing: Tokens.spacing.normal

        StyledText {
            text: qsTr("Hue Lights")
            font.weight: 500
            font.pointSize: Tokens.font.size.normal
        }

        // Lights section
        Repeater {
            model: OpenHue.lights

            delegate: ColumnLayout {
                id: lightDelegate

                required property var modelData

                Layout.fillWidth: true
                spacing: Tokens.spacing.smaller

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.spacing.small

                    StyledText {
                        text: lightDelegate.modelData.name
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }

                    StyledSwitch {
                        checked: lightDelegate.modelData.on
                        onClicked: OpenHue.setLightOnState(lightDelegate.modelData.id, !lightDelegate.modelData.on)
                    }
                }

                StyledSlider {
                    Layout.fillWidth: true
                    visible: lightDelegate.modelData.dimmable
                    from: 1
                    to: 100
                    value: lightDelegate.modelData.brightness
                    onMoved: OpenHue.setLightBrightness(lightDelegate.modelData.id, value)
                }
            }
        }

        // Separator
        Rectangle {
            Layout.fillWidth: true
            visible: OpenHue.rooms.length > 0 && OpenHue.lights.length > 0
            height: 1
            color: Colours.palette.m3outlineVariant
            opacity: 0.5
        }

        // Rooms section
        StyledText {
            visible: OpenHue.rooms.length > 0
            text: qsTr("Rooms")
            font.weight: 500
            font.pointSize: Tokens.font.size.normal
        }

        Repeater {
            model: OpenHue.rooms

            delegate: ColumnLayout {
                id: roomDelegate

                required property var modelData

                Layout.fillWidth: true
                spacing: Tokens.spacing.smaller

                RowLayout {
                    Layout.fillWidth: true
                    spacing: Tokens.spacing.small

                    StyledText {
                        text: roomDelegate.modelData.name
                        Layout.fillWidth: true
                        elide: Text.ElideRight
                    }

                    StyledSwitch {
                        checked: roomDelegate.modelData.on
                        onClicked: OpenHue.setRoomOnState(roomDelegate.modelData.id, !roomDelegate.modelData.on)
                    }
                }

                StyledSlider {
                    Layout.fillWidth: true
                    from: 1
                    to: 100
                    value: roomDelegate.modelData.brightness
                    onMoved: OpenHue.setRoomBrightness(roomDelegate.modelData.id, value)
                }
            }
        }
    }
}
