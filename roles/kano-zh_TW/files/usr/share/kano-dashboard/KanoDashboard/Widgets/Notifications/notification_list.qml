/**
 * notification_list.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * A list of all the user's notifications
 */


import QtQuick 2.3
import QtQuick.Controls 1.4
import Notifications 1.0

import KanoDashboard.Widgets.Notifications 1.0 as DashboardNotifications
import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Colours 1.0 as Colours
import KanoDashboard.Widgets.Styles 1.0 as Styles


Templates.Pane {
    signal new_notification(var new_notification)
    property int notif_height: 70
    property int max_height: calc_list_height(5)
    property int spacing: 8

    id: notif_menu
    title: qsTr('通知')

    anchors.margins: 0
    radius: 5
    spacer_margin: list_view.spacing

    Component.onCompleted: {
        app_state.open_notification_list.connect(open)
        app_state.close_notification_list.connect(close)
    }

    function calc_list_height(notif_count) {
        return notif_height * notif_count
                + spacing * (notif_count + 1);
    }

    ListView {
        id: list_view
        anchors.fill: parent
        anchors.margins: 0
        anchors.leftMargin: 2 * notif_menu.spacing
        model: DashboardNotifications.NotificationWatcher.notifications
        spacing: notif_menu.spacing
        clip: true

        delegate: Item {
            width: list_view.width
            height: notif_height + spacer.height + spacer.anchors.topMargin

            DashboardNotifications.Notification {
                id: notif
                width: list_view.width
                height: notif_height
                notification: modelData
            }
            Rectangle {
                id: spacer
                anchors.topMargin: list_view.spacing
                anchors.left: notif.left
                anchors.right: parent.right
                anchors.top: notif.bottom

                color: spacer_colour
                height: spacer_height
            }
        }
    }

    property bool inited: false
    onStateChanged: {
        if (state != 'closed') {
            return;
        }

        if (!inited) {
            inited = true;
            return;
        }

        DashboardNotifications.NotificationWatcher.clear_queue();
    }

}
