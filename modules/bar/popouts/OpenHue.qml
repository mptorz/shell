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

        spacing: Tokens.spacing.small

        StyledText {
            text: qsTr("Scenes")
            font.weight: 500
            font.pointSize: Tokens.font.size.normal
        }

        IconTextButton {
            icon: "menu_book"
            text: "Read"
            onClicked: OpenHue.setScene("Read")
        }

        IconTextButton {
            icon: "weekend"
            text: "Relax"
            onClicked: OpenHue.setScene("Relax")
        }

        IconTextButton {
            icon: "brightness_low"
            text: "Dimmed"
            onClicked: OpenHue.setScene("Dimmed")
        }

        IconTextButton {
            icon: "location_city"
            text: "Chinatown"
            onClicked: OpenHue.setScene("Chinatown")
        }

        IconTextButton {
            icon: "theater_comedy"
            text: "Movie"
            onClicked: OpenHue.setScene("Movie")
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: Colours.palette.m3outlineVariant
            opacity: 0.5
        }

        IconTextButton {
            icon: "power_settings_new"
            text: "Turn Off"
            type: IconTextButton.Tonal
            onClicked: OpenHue.turnOffRoom("Living room")
        }
    }
}
