/**
 * power_menu.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * A list of power option
 */


import QtQuick 2.3

import KanoDashboard.Widgets.PowerMenu 1.0 as PowerMenu
import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Colours 1.0 as Colours
import KanoDashboard.Widgets.Shapes 1.0 as Shapes

Templates.MenuWidget {
    width: menu.width
    height: menu.height + arrow.height

    Rectangle {
        id: menu
        width: 200
        height: dialog_options.count * 65 +
            (dialog_options.count - 1) * column.spacing
        color: Colours.Palette.dark_color
        radius: 5

        ListModel {
            id: dialog_options
            ListElement {
                option_name: QT_TR_NOOP('Logout')
            }
            ListElement {
                option_name: QT_TR_NOOP('Reboot')
            }
            ListElement {
                option_name: QT_TR_NOOP('Shutdown')
            }
        }

        Column {
            id: column
            anchors.fill: parent
            spacing: 0

            Repeater {
                model: dialog_options
                PowerMenu.PowerMenuItem {
                    name: option_name
                    label: qsTr(option_name)
                    show_spacer: index + 1 < dialog_options.count
                }
            }
        }
    }

    Shapes.Triangle {
        id: arrow
        anchors.top: menu.bottom
        width: 25
        height: 15
        x: (owner.width - width) / 2
        color: Colours.Palette.dark_color
    }

}
