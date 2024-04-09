import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.plasma5support as P5Support
import "components" as Components

KCM.SimpleKCM {
    id:root
    property bool cfg_hideWidget: hideWidget.checked
    property alias cfg_BlurMode: blurModeCombo.currentIndex
    property alias cfg_CheckActiveScreen: activeScreenOnlyCheckbx.checked
    property alias cfg_BlurRadius: blurRadiusSpinBox.value
    property alias cfg_isEnabled: isEnabledCheckbox.checked
    property alias cfg_borderEnabled: borderEnabledCheckbox.checked
    property alias cfg_borderColor: borderColorButton.color
    property alias cfg_borderRadius: borderRadiusSpinBox.value
    property alias cfg_borderMarginTop: marginTopSpinBox.value
    property alias cfg_borderMarginBottom: marginBottomSpinBox.value
    property alias cfg_borderMarginLeft: marginLeftSpinBox.value
    property alias cfg_borderMarginRight: marginRightSpinBox.value
    Kirigami.FormLayout {
        CheckBox {
            id: isEnabledCheckbox
            Kirigami.FormData.label: i18n("Enabled:")
            checked: cfg_isEnabled
            onCheckedChanged: cfg_isEnabled = checked
        }
        CheckBox {
            id: hideWidget
            Kirigami.FormData.label: i18n("Hide widget:")
            text: i18n("Widget will show when configuring or desktop Edit Mode")
            checked: cfg_hideWidget
            onCheckedChanged: cfg_hideWidget = checked
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Blur")
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

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Rounded Corners")
        }

        CheckBox {
            id: borderEnabledCheckbox
            Kirigami.FormData.label: i18nd("@checkbox:border_checkbox", "Enable:")
            checked: cfg_borderEnabled
            text: i18n("Draw rounded corners over wallpaper")
            onCheckedChanged: {
                cfg_borderEnabled = checked
            }
        }

        Components.ColorButton {
            id: borderColorButton
            showAlphaChannel: false
            Kirigami.FormData.label: i18nd("@button:background_color", "Color:")
            dialogTitle: i18nd("@dialog:background_color", "Border Color")
            color: cfg_borderColor
            onAccepted: {
                cfg_borderColor = color
            }
            enabled: borderEnabledCheckbox.checked
        }
        SpinBox {
            Kirigami.FormData.label: i18nd("@spinbox:border_radius", "Radius:")
            id: borderRadiusSpinBox
            from: 0
            to: 145
            value: cfg_borderRadius
            onValueChanged: {
                cfg_borderRadius = value
            }
            enabled: borderEnabledCheckbox.checked
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Margins")
            Layout.fillWidth: true
        }

        SpinBox {
            Kirigami.FormData.label: i18nd("@spinbox:margin_top", "Top:")
            id: marginTopSpinBox
            from: 0
            to: 999
            value: cfg_borderMarginTop
            onValueChanged: {
                cfg_borderMarginTop = value
            }
            enabled: borderEnabledCheckbox.checked
        }
        SpinBox {
            Kirigami.FormData.label: i18nd("@spinbox:margin_bottom", "Bottom:")
            id: marginBottomSpinBox
            from: 0
            to: 999
            value: cfg_borderMarginBottom
            onValueChanged: {
                cfg_borderMarginBottom = value
            }
            enabled: borderEnabledCheckbox.checked
        }
        SpinBox {
            Kirigami.FormData.label: i18nd("@spinbox:margin_left", "Left:")
            id: marginLeftSpinBox
            from: 0
            to: 999
            value: cfg_borderMarginLeft
            onValueChanged: {
                cfg_borderMarginLeft = value
            }
            enabled: borderEnabledCheckbox.checked
        }
        SpinBox {
            Kirigami.FormData.label: i18nd("@spinbox:margin_right", "Right:")
            id: marginRightSpinBox
            from: 0
            to: 999
            value: cfg_borderMarginRight
            onValueChanged: {
                cfg_borderMarginRight = value
            }
            enabled: borderEnabledCheckbox.checked
        }
    }
}
