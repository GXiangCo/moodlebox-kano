/**
 * update_notifications.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget to list individual package updates when they are available
 */


import QtQuick 2.3
import Updates 1.0

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.LatestView 1.0 as LatestView
import KanoDashboard.Widgets.Fonts 1.0 as Fonts


LatestView.AlertView {
    signal muted_update()

    id: view
    title.text: qsTr("警告")

    Updates {
        id: updates
    }

    ListView {
        id: list_view
        anchors.top: parent.title.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        model: updates.packages_available.length

        delegate: LatestView.UpdateNotification {
            width: list_view.width
            pkg: updates.packages_available[modelData]
        }
    }
}
