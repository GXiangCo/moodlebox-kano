/*
 *  boot_warning_ckc.qml
 *
 *  Copyright (C) 2016 Kano Computing Ltd.
 *  License: http://www.gnu.org/licenses/gpl-2.0.txt GNU GPL v2
 *
 *  Screen to be displayed at Dashboard load time, when the user has pulled the plug
 *  On the previous boot, only for CKC Kits.
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
        property color instructions_colour: '#ffffff'
        property color dark_text_color: '#000000'
        property color light_text_color: '#92999C'
        property color warning_colour: '#74c72a'
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

        width: img.width + radius * 2
	height: childrenRect.height

        Item {
            id: popup_wrapper

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
	    implicitHeight: childrenRect.height + 2 * anchors.margins

            AnimatedImage {
                id: img
                anchors.top: parent.top
		asynchronous: true
		playing: true
                fillMode: Image.PreserveAspectFit
                source: 'shutdown-animation-v2.gif'
            }

            Item {
                id: warning_wrapper

                anchors.top: img.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                implicitHeight: childrenRect.height
                anchors.margins: 5

                Item {
                    id: message_wrapper

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    implicitHeight: childrenRect.height

                    Fonts.H1 {
                        id: title
                        anchors.topMargin: 15
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
			horizontalAlignment: Text.AlignHCenter
                        color: "#494d4f"
                        text: qsTr("安全的關機!")
                    }

                    Fonts.H3 {
                        id: description
			anchors.topMargin: 15
			horizontalAlignment: Text.AlignHCenter
			anchors.top: title.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        color: palette.light_text_color
                        font.bold: false
                        font.pointSize: 11
                        text: qsTr('直接按紅色電源按鈕關機，可能會損壞電腦. 建議使用電源選單關機.')
                    }
                }
            }

            Templates.ButtonWidget {
                id: later_button

                text: qsTr('了解')
		text_color: 'white'

                color: area.containsMouse ?
                    Qt.darker(palette.warning_colour, 1.1) :
                    palette.warning_colour

                radius: 50
                width: 100
		anchors.topMargin: 30
		anchors.top: warning_wrapper.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                implicitHeight: height

                onClicked: {
                    loader_boot_warning.source='';
                }
            }
        }
    }
}
