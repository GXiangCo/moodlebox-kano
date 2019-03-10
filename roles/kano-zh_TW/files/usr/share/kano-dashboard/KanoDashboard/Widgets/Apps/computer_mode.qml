/**
 * computer_mode.qml
 *
 * Copyright (C) 2016 Kano Computing Ltd.
 * License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 * Widget for switching to the desktop
 */


import QtQuick 2.3
import KanoDashboard.Widgets.Templates 1.0 as Templates

Templates.ButtonWidget {
    text: qsTr('桌面模式')
    switch_mode: 'kano-os'
}
