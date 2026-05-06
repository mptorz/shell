pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Caelestia.Config
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
        spacing: Tokens.spacing.small

        StyledText {
            text: qsTr("Scenes")
            font.weight: 500
            font.pointSize: Tokens.font.size.normal
        }

        IconTextButton {
            Layout.fillWidth: true
            icon: "menu_book"
            text: "Read"
            onClicked: OpenHue.setScene("Read")
        }

        IconTextButton {
            Layout.fillWidth: true
            icon: "weekend"
            text: "Relax"
            onClicked: OpenHue.setScene("Relax")
        }

        IconTextButton {
            Layout.fillWidth: true
            icon: "brightness_low"
            text: "Dimmed"
            onClicked: OpenHue.setScene("Dimmed")
        }

        IconTextButton {
            Layout.fillWidth: true
            icon: "location_city"
            text: "Chinatown"
            onClicked: OpenHue.setScene("Chinatown")
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Colours.palette.m3outlineVariant
            opacity: 0.5
        }

        IconTextButton {
            Layout.fillWidth: true
            icon: "power_settings_new"
            text: "Turn Off"
            type: IconTextButton.Tonal
            onClicked: OpenHue.turnOffRoom("Living room")
        }
    }
}
