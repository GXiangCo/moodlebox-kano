/**
 * story_mode.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget for launching Kano Overworld
 */


import QtQuick 2.3
import QtGraphicalEffects 1.0

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.Fonts 1.0 as Fonts


Templates.ContentWidget {
    color: 'transparent'
    title.text: qsTr('故事模式')
    title.z: 1
    description: qsTr('Let\'s go back to Story Mode,<br>click here.')
    anchors.margins: 0
    width: screenshot.width

    property int progress: kano_profile.get_story_progress()
    property int total_progress: 100

    Templates.ImageWidget {
        id: screenshot
        source: home_dir + '/.local/share/love/kanoOverworld/lastPosition.png'
        default_source: '../StoryMode/story.png'

        anchors.top: parent.title.bottom
        height: Math.max(0, Math.min(max_width, guide_height))
        width: height
        anchors.margins: 0
        anchors.right: parent.right
        radius: parent.radius
        switch_mode: 'kanoOverworld'
        scale: area.containsMouse ? 1.02 : 1.0
        area.onEntered: app_state.play_hover_sound()
        area.z: 100

        Templates.ImageWidget {
            id: story_title
            source: 'story-mode.png'

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: -15
            width: Math.min(parent.width / 2, 150)
        }
    }

}
