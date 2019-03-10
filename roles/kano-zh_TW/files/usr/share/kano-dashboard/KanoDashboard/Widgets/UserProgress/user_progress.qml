/**
 * user_progress.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget contiaining the user's profile and avatar states and their
 * notification state.
 */


import QtQuick 2.3

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.UserProgress 1.0 as UserProgress
import KanoDashboard.Widgets.Fonts 1.0 as Fonts

Templates.WidgetTemplate {
    property alias progress_bar_thickness: avatar.progress_bar_thickness
    property int minimum_req_width:
        username.contentWidth + avatar.width + 20

    function refresh() {
        desc.update();
        avatar.update();
    }
    Component.onCompleted: {
        app_state.refresh.connect(refresh);
        refresh();
    }

    id: user_progress
    color: 'transparent'
    anchors.margins: 5
    width: Math.max(minimum_req_width, 250)
    radius: 5

    UserProgress.Avatar {
        id: avatar
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: height
        anchors.margins: 0
        onClicked: desc.area.clicked(mouse)
        activatable: true
    }

    Templates.WidgetTemplate {
        id: desc
        open_view: 'kano-profile-gui'
        height: username.height + level.height + 10
        anchors.verticalCenter: avatar.verticalCenter
        anchors.left: avatar.right
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 10

        onUpdate: {
            username.update();
            level.update();
        }

        Fonts.H2 {
            signal update()
            id: username
            onUpdate: text = kano_world.get_username()
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            wrapMode: Text.NoWrap

            horizontalAlignment: Text.AlignLeft
        }

        Fonts.H3 {
            signal update()
            id: level
            onUpdate: text = "等級 " + kano_profile.calculate_kano_level()
            anchors.top: username.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignLeft
        }
    }
}
