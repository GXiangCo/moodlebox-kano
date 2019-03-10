/**
 * no_internet.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Notifies about internet connection problems
 */


import QtQuick 2.3
import QtGraphicalEffects 1.0
import Updates 1.0

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.Colours 1.0 as Colours
import KanoDashboard.Widgets.LatestView 1.0 as LatestView


LatestView.AlertView {
    id: view
    title.text: qsTr('無網路連線')

    LatestView.AlertCard {
        property int margins: 20

        anchors.top: parent.title.bottom
        color: Colours.Palette.notification_color
        image: 'no_internet.png'
        heading: qsTr('No Internet')
        button_text: qsTr('WiFi Setup')
        open_view: 'sudo kano-wifi-gui'
    }
}
