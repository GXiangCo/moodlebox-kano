/**
 * no_profile.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Notifies that the user isn't logged in to Kano World
 */


import QtQuick 2.3
import QtGraphicalEffects 1.0
import QtQml 2.2
import Updates 1.0

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.LatestView 1.0 as LatestView


LatestView.AlertView {
    id: no_profile
    title.text: qsTr('Kano世界 解鎖')

    LatestView.AlertCard {
        id: new_account

        color: '#38495c'
        heading: qsTr('加入 Kano世界')
        image: 'create_account.png'
        button_text: qsTr('註冊')
        open_view: 'kano-login --register'

        anchors.top: title.bottom
    }

    LatestView.AlertCard {
        id: existing_account

        color: '#4b7792'
        heading: qsTr('已加入?')
        image: 'account_login.png'
        button_text: qsTr('登入')
        open_view: 'kano-login'

        anchors.top: new_account.bottom
        anchors.topMargin: no_profile.spacing / 2
    }
}
