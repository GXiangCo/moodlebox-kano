/**
 * creative_mode.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget which displays and launches the creative apps from a Grid control.
 *
 * The list of apps themselves are provided by the qt-apps repo,
 * through the Kano.Apps object below.
 *
 */

import QtQuick 2.3

import Kano.Apps 1.0 as KanoApps

import KanoDashboard.Widgets.Apps 1.0 as Apps
import KanoDashboard.Widgets.Templates 1.0 as Templates

Templates.ContentWidget {
    property int max_cell_size: 190
    property int cell_spacing: Math.min(height / 15, 50)
    property int cell_margin: cell_spacing / 2
    property int side_margins: 2 * cell_spacing - cell_margin

    id: pane
    title.text: qsTr("應用程式")
    width: apps.columns * apps.cellWidth
    guide_height: apps.cellHeight / apps.app_rows
    anchors.margins: 0
    anchors.bottomMargin: 20
    anchors.rightMargin: side_margins
    anchors.leftMargin: anchors.rightMargin

    KanoApps.AppGridLayout {
        id: apps

        cellWidth: cellHeight

        onApp_hovered: app_state.play_hover_sound()
        onApp_launched: Templates.ProcessLauncher.open_view.run(launch_command)

        // FIXME: Shouldn't need to add margin
        anchors.top: parent.title.bottom
        anchors.topMargin: - 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Math.max(
            0,
            parent.height - (title.height + max_cell_size * app_rows)
        )
        anchors.left: parent.left
        anchors.right: parent.right

        // links the app grid with the buttons to change the page of apps
        control: app_state.app_grid_control
    }
}
