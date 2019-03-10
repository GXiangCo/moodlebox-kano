/**
 * wifi_details.qml
 *
 * Copyright (C) 2016-2017 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * A menu showing the dtails of the WiFi connection, launched by the WiFi
 * status icon.
 */


import QtQuick 2.3

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.Colours 1.0 as Colours
import KanoDashboard.Widgets.Shapes 1.0 as Shapes

Templates.MenuWidget {
    signal refresh()
    property bool ethernet_mode: kano_networking.network_name == 'Ethernet'
    property bool low_signal_mode: false
    property int margins: 15

    property QtObject palette: Item {
        property color text_colour: '#ffffff'
        property color normal_colour: Colours.Palette.dark_color
        property color hover_colour: '#6d777a'
        property color pressed_colour: '#303a3c'
    }

    width: menu.width
    height: menu.height + arrow.height
    offset: Qt.point(menu.width - owner.width, 0)
    onRefresh: menu.refresh()
    onHeightChanged: position_menu()
    onOffsetChanged: position_menu()

    Rectangle {
        id: menu
        width: buttons.visible ?
            buttons.childrenRect.width + 2 * margins :
            Math.max(ip.width, net.width) + 2 * margins
        height: col.childrenRect.height + 2 * margins
        onHeightChanged: inited = false
        radius: 5

        anchors.margins: 0
        color: Colours.Palette.dark_color

        function refresh() {
            kano_networking.refresh()
        }

        Column {
            id: col
            spacing: 10
            anchors.margins: margins
            anchors.fill: parent

            Item {
                id: net
                anchors.horizontalCenter: parent.horizontalCenter
                width: childrenRect.width
                height: childrenRect.height

                Fonts.H4 {
                    id: network
                    text: qsTr('Network: ')
                    color: Colours.Palette.light_color
                    anchors.top: parent.top
                }

                Fonts.H4 {
                    id: network_name
                    text: kano_networking.network_name
                    color: '#ffffff'
                    anchors.verticalCenter: network.verticalCenter
                    anchors.left: network.right
                    font.bold: false
                }
            }

            Item {
                id: ip
                anchors.horizontalCenter: parent.horizontalCenter
                width: childrenRect.width
                height: childrenRect.height

                Fonts.H4 {
                    id: ip_addr
                    text: qsTr('IP 位址: ')
                    color: Colours.Palette.light_color
                    anchors.top: parent.top
                }

                Fonts.H4 {
                    id: ip_addr_value
                    text: kano_networking.ip_address
                    color: '#ffffff'
                    anchors.verticalCenter: ip_addr.verticalCenter
                    anchors.left: ip_addr.right
                    font.bold: false
                }
            }

            Fonts.H4 {
                visible: low_signal_mode
                text: qsTr('訊號微弱, 往WIFI基地台移動一些')
                color: '#ffffff'
                width: buttons.width / 2
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: false
            }

            Item {
                property int button_border_width: 2
                property int button_padding: 10
                property int button_top_margin: margins - col.spacing

                function get_button_colour(is_hovered, is_pressed) {
                    if (is_pressed) {
                        return palette.pressed_colour;
                    }

                    if (is_hovered) {
                        return palette.hover_colour;
                    }

                    return palette.normal_colour;
                }

                function get_button_border_colour(is_hovered, is_pressed) {
                    if (is_pressed) {
                        return palette.pressed_colour;
                    }

                    return palette.hover_colour;
                }

                id: buttons
                visible: !ethernet_mode
                anchors.horizontalCenter: parent.horizontalCenter
                width: childrenRect.width
                height: childrenRect.height + button_top_margin

                Templates.RoundButton {
                    id: change_network
                    text: qsTr('變更網路')
                    open_view: 'sudo kano-wifi-gui'
                    anchors.top: parent.top
                    anchors.topMargin: parent.button_top_margin
                    padding: parent.button_padding
                    border.width: parent.button_border_width
                    border.color: parent.get_button_border_colour(
                        area.containsMouse, area.containsPress
                    )
                    text_color: palette.text_colour
                    color: parent.get_button_colour(
                        area.containsMouse, area.containsPress
                    )
                }


                Templates.RoundButton {
                    id: disconnect
                    text: qsTr('中斷連線')
                    open_view: 'sudo kano-wifi-gui --disconnect'
                    anchors.left: change_network.right
                    anchors.top: parent.top
                    anchors.topMargin: parent.button_top_margin
                    anchors.leftMargin: margins
                    padding: parent.button_padding
                    border.width: parent.button_border_width
                    border.color: parent.get_button_border_colour(
                        area.containsMouse, area.containsPress
                    )
                    text_color: palette.text_colour
                    color: parent.get_button_colour(
                        area.containsMouse, area.containsPress
                    )
                }
            }
        }
    }

    Shapes.Triangle {
        id: arrow
        anchors.top: menu.bottom
        width: 25
        height: 15
        x: parent.width - (owner.width + width) / 2
        color: Colours.Palette.dark_color
    }
}
