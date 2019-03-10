/**
 * major_update_notification.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Pane that appears when there is a full update available
 */


import QtQuick 2.3
import Updates 1.0

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.LatestView 1.0 as LatestView


LatestView.AlertView {
    signal muted_update()

    id: card
    title.text: qsTr("警告")

    LatestView.AlertCard {
        id: install_system_updates

        anchors.top: parent.title.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        color: '#e38334'
        heading: qsTr('系統更新')
        image: 'system_update.png'
        button_text: qsTr('安裝')

        switch_mode: 'update'

        MouseArea {
            id: alert_mouse_area
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            anchors.fill: install_system_updates
            hoverEnabled: true
            propagateComposedEvents: true
        }
    }

    SequentialAnimation {
        running: !alert_mouse_area.containsMouse
        loops: Animation.Infinite

        ScaleAnimator {
            target: install_system_updates
            easing.type: Easing.InOutSine
            from: 1;
            to: 1.1;
            duration: 1000
        }

        ScaleAnimator {
            target: install_system_updates
            easing.type: Easing.InOutSine
            from: 1.1;
            to: 1.0;
            duration: 1000
        }

        onStopped: {
            install_system_updates.scale=1.0;
        }
    }
}
