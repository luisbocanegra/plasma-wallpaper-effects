import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as P5Support

KCM.SimpleKCM {
    id:root
    property bool cfg_hideWidget: hideWidget.checked
    property alias cfg_BlurMode: blurModeCombo.currentIndex
    property alias cfg_CheckActiveScreen: activeScreenOnlyCheckbx.checked
    property alias cfg_BlurRadius: blurRadiusSpinBox.value
    Kirigami.FormLayout {
        CheckBox {
            id: hideWidget
            Kirigami.FormData.label: i18n("Hide widget:")
            text: i18n("Widget will show when configuring or desktop Edit Mode")
            checked: cfg_hideWidget
            onCheckedChanged: cfg_hideWidget = checked
        }

        ComboBox {
            Kirigami.FormData.label: i18nd("@buttonGroup:blur_mode", "Blur wallpaper:")
            id: blurModeCombo
            model: [
                {
                    'label': i18nd("@option:blur_mode", "Maximized or full-screen windows")
                },
                {
                    'label': i18nd("@option:blur_mode", "Active window is present")
                },
                {
                    'label': i18nd("@option:blur_mode", "At least one window is shown")
                },
                {
                    'label': i18nd("@option:blur_mode", "Always")
                },
                {
                    'label': i18nd("@option:blur_mode", "Never")
                }
            ]
            textRole: "label"
            onCurrentIndexChanged: cfg_BlurMode = currentIndex
            currentIndex: cfg_BlurMode
        }

        CheckBox {
            id: activeScreenOnlyCheckbx
            Kirigami.FormData.label: i18nd("@checkbox:screen_filter", "Filter:")
            checked: cfg_CheckActiveScreen
            text: i18n("Only check for windows in active screen")
            onCheckedChanged: {
                cfg_CheckActiveScreen = checked
            }
            visible: !screenLockModeCheckbox.checked
        }
        SpinBox {
            Kirigami.FormData.label: i18nd("@checkBox:blur_strength", "Blur radius:")
            id: blurRadiusSpinBox
            from: 0
            to: 145
            value: cfg_BlurRadius
            onValueChanged: {
                cfg_BlurRadius = value
            }
            visible: cfg_BlurMode !== 4
        }
        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            visible: blurRadiusSpinBox.visible && cfg_BlurRadius > 64
            text: qsTr("Quality of the blur is reduced if value exceeds 64. Higher values may cause the blur to stop working!")
        }
    }
}
