/*
 *  boot_warning.qml
 *
 *  Copyright (C) 2016 Kano Computing Ltd.
 *  License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 *  Screen to be displayed at Dashboard load time, when the user has pulled the plug
 *  On the previous boot, only for non-CKC Kits.
 *
 *  This screen will simply warn them not to do that.
 *
 */

import QtQuick 2.3
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Controls.Styles 1.4

import Kano.Process 1.0

import KanoDashboard.Widgets.Fonts 1.0 as Fonts
import KanoDashboard.Widgets.Templates 1.0 as Templates

Item {

    // TODO: Encapsulate into a reusable component (see QML object FeedbackWidget)
    property QtObject palette: Item {
        property color instructions_colour: '#f26d5b'
        property color dark_text_color: '#ffffff'
        property color warning_colour: '#e83e2f'
    }

    Rectangle {
        id: blur_desktop
        color: "black"
        anchors.fill: parent
        opacity: 0.5
        z: -5

        MouseArea {
            // effectively captures and discards mouse events
            // trespassing down to the Dashboard.
            anchors.fill: parent
            enabled: true
            hoverEnabled: true
        }
    }

    Process {
        id: proc_update_kit
        onFinished: {
            // Close the popup and return to the Dashboard
            loader_boot_warning.source="";
            app_state.fade_in();
        }
    }

    Rectangle {
        // this rectangle covers the complete popup dialog.
        id: popup_dialog
        z: 10
        color: palette.instructions_colour
        radius: 10

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        width: parent.width / 2
        height: popup_wrapper.height + 2 * popup_wrapper.anchors.margins

        Item {
            id: popup_wrapper

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            implicitHeight: warning_wrapper.implicitHeight + 2 * anchors.margins

            Image {
                id: img
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: parent.width / 3
                fillMode: Image.PreserveAspectFit
                source: 'shutdown.png'
            }

            Item {
                id: warning_wrapper

                anchors.top: parent.top
                anchors.bottom: later_button.top
                anchors.left: img.right
                anchors.right: parent.right
                implicitHeight: message_wrapper.height + later_button.height + 2 * anchors.margins

                anchors.margins: 30

                Item {
                    id: message_wrapper

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                    implicitHeight: title.height + description.height + 30

                    Fonts.H1 {
                        id: title
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: palette.dark_text_color
                        text: qsTr("您的 Kano 不正常關機")
                    }

                    Fonts.H2 {
                        id: description
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: palette.dark_text_color
                        text: qsTr('為避免資料遺失，在拔掉電源線前，請使用電源選單並選擇 Shutdown 關機.')
                    }
                }
            }

            Templates.ButtonWidget {
                id: later_button

                text: qsTr('確認')
                text_color: 'white'

                color: area.containsMouse ?
                    Qt.darker(palette.warning_colour, 1.1) :
                    palette.warning_colour

                radius: 10
                width: 100
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: height

                onClicked: {
                    loader_boot_warning.source='';
                }
            }
        }
    }
}
