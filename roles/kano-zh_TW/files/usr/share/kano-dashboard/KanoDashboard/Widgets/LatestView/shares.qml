/**
 * shares.qml
 *
 * Copyright (C) 2016-2017 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget to show staff picks in a grid layout
 */


import QtQuick 2.3
import QtQuick.Controls 1.4

import Kano.Share 1.0 as Share

import KanoDashboard.Widgets.Templates 1.0 as Templates
import KanoDashboard.Widgets.LatestView 1.0 as LatestView
import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.Colours 1.0 as Colours


Templates.WidgetTemplate {
    id: shares
    property int margins: 5
    x: margins / 2

    Component.onCompleted: {
        app_state.refresh.connect(share_grid.share_list.refresh);
        share_grid.share_list.refresh();
    }

    title.text: qsTr("創作坊精選")
    activatable: false

    BusyIndicator {
        anchors.centerIn: parent
        visible: share_grid.share_list.length == 0
        running: visible
    }


    Share.ShareGrid {
        id: share_grid
        rows: 2
        columns: 2
        model: layout.tile
        anchors.top: parent.title.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: width

        onShare_clicked: {
            shares.open_view = 'kano-world-launcher /shared/' + share.id;
            shares.area.activate();
        }
    }

    Templates.WidgetTemplate {
        id: more_creations

        property color overlay_color: Colours.Palette.dark_color
        property int padding: 15
        property int elements_spacing: 8

        open_view: 'kano-world-launcher'

        color: area.containsMouse ?
            Colours.Palette.dark_color : Colours.Palette.button_color

        width: (text.width + elements_spacing + right_arrow_image.width) + (2 * radius)
        height: Math.max(text.height, right_arrow_image.height) + 2 * padding
        radius: height / 2
        activatable: true
        hover_sound_enabled: true
        area.z: 100

        anchors.top: share_grid.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        Fonts.H3 {
            id: text
            text: qsTr('更多創作')

            color: parent.area.containsMouse ?
                Colours.Palette.button_text_color : parent.overlay_color

            anchors.left: parent.left
            anchors.leftMargin: parent.radius
            anchors.verticalCenter: parent.verticalCenter
        }

        Templates.ImageWidget {
            id: right_arrow_image
            source: 'right_arrow.png'
            height: img.sourceSize.height
            width: img.sourceSize.width

            overlay.color: parent.area.containsMouse ? 'white' : parent.overlay_color

            anchors.left: text.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: parent.elements_spacing
        }
    }
}
