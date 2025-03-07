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
    property alias cfg_GrainMode: grainModeCombo.currentIndex
    property alias cfg_effectsShowGrain: effectsShowGrainInput.text
    property alias cfg_effectsHideGrain: effectsHideGrainInput.text
    property alias cfg_grainAnimate: grainAnimateCheckbox.checked
    property real cfg_grainSize: grainSizeInput.text
    property real cfg_grainAmount: grainAmountInput.text
    property alias cfg_CheckActiveScreen: activeScreenOnlyCheckbx.checked
    property alias cfg_BlurRadius: blurRadiusSpinBox.value
    property alias cfg_isEnabled: isEnabledCheckbox.checked
    property alias cfg_borderEnabled: borderEnabledCheckbox.checked
    property int cfg_borderColorMode: plasmoid.configuration.borderColorMode
    property alias cfg_borderColorModeTheme: borderModeTheme.currentIndex
    property alias cfg_borderColorModeThemeVariant: borderModeThemeVariant.currentIndex
    property alias cfg_borderColor: borderColorButton.color
    property alias cfg_borderRadius: borderRadiusSpinBox.value
    property alias cfg_borderMarginTop: marginTopSpinBox.value
    property alias cfg_borderMarginBottom: marginBottomSpinBox.value
    property alias cfg_borderMarginLeft: marginLeftSpinBox.value
    property alias cfg_borderMarginRight: marginRightSpinBox.value
    property real cfg_brightness: brightnessInput.text
    property real cfg_contrast: contrastInput.text
    property real cfg_saturation: saturationInput.text
    property real cfg_colorization: colorizationInput.text
    property int cfg_colorizationColorMode: plasmoid.configuration.colorizationColorMode
    property alias cfg_colorizationColorModeTheme: colorizationColorModeTheme.currentIndex
    property alias cfg_colorizationColorModeThemeVariant: colorizationColorModeThemeVariant.currentIndex
    property alias cfg_colorizationColor: colorizationColorButton.color
    property alias cfg_colorEffectsMode: colorEffectsModeCombo.currentIndex
    property alias cfg_effectsShowBlur: effectsShowBlurInput.text
    property alias cfg_effectsHideBlur: effectsHideBlurInput.text
    property alias cfg_effectsShowColorization: effectsShowColorizationInput.text
    property alias cfg_effectsHideColorization: effectsHideColorizationInput.text
    property alias cfg_effectsShowBorder: effectsShowBorderInput.text
    property alias cfg_effectsHideBorder: effectsHideBorderInput.text
    property alias cfg_animationDuration: animationDurationSpinBox.value
    property real cfg_shadowBlur: shadowBlurInput.text
    property var systemColors: [
        i18n("Text"),
        i18n("Disabled Text"),
        i18n("Highlighted Text"),
        i18n("Active Text"),
        i18n("Link"),
        i18n("Visited Link"),
        i18n("Negative Text"),
        i18n("Neutral Text"),
        i18n("Positive Text"),
        i18n("Background"),
        i18n("Highlight"),
        i18n("Active Background"),
        i18n("Link Background"),
        i18n("Visited Link Background"),
        i18n("Negative Background"),
        i18n("Neutral Background"),
        i18n("Positive Background"),
        i18n("Alternate Background"),
        i18n("Focus"),
        i18n("Hover")
    ]
    property var systemColorSets: [
        i18n("View"),
        i18n("Window"),
        i18n("Button"),
        i18n("Selection"),
        i18n("Tooltip"),
        i18n("Complementary"),
        i18n("Header")
    ]
    property var effectStates: [
        {
            'label': i18n("Maximized or full-screen windows")
        },
        {
            'label': i18n("Active window is present")
        },
        {
            'label': i18n("At least one window is shown")
        },
        {
            'label': i18n("Always")
        },
        {
            'label': i18n("Never")
        }
    ]
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
            text: i18n("Widget will show in Desktop Edit Mode")
            checked: cfg_hideWidget
            onCheckedChanged: cfg_hideWidget = checked
        }

        SpinBox {
            Kirigami.FormData.label: i18n("Animation duration:")
            id: animationDurationSpinBox
            from: 0
            to: 2000000000
            stepSize: 100
            value: cfg_animationDuration
            onValueChanged: {
                cfg_animationDuration = value
            }
        }

        CheckBox {
            id: activeScreenOnlyCheckbx
            Kirigami.FormData.label: i18n("Filter:")
            checked: cfg_CheckActiveScreen
            text: i18n("Only check for windows in active screen")
            onCheckedChanged: {
                cfg_CheckActiveScreen = checked
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Blur")
        }

        ComboBox {
            Kirigami.FormData.label: i18n("Enable:")
            id: blurModeCombo
            model: effectStates
            textRole: "label"
            onCurrentIndexChanged: cfg_BlurMode = currentIndex
            currentIndex: cfg_BlurMode
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Desktop Effects")
            Layout.fillWidth: true
        }

        TextField {
            Kirigami.FormData.label: i18n("Hide in:")
            id: effectsHideBlurInput
        }

        TextField {
            Kirigami.FormData.label: i18n("Show in:")
            id: effectsShowBlurInput
        }

        RowLayout {
            visible: cfg_BlurMode !== 4
            Kirigami.FormData.label: i18n("Blur radius:")
            SpinBox {
                id: blurRadiusSpinBox
                from: 0
                to: 145
                value: cfg_BlurRadius
                onValueChanged: {
                    cfg_BlurRadius = value
                }
            }

            Button {
                visible: blurRadiusSpinBox.visible && cfg_BlurRadius > 64
                icon.name: "dialog-warning-symbolic"
                ToolTip.text: i18n("Quality of the blur is reduced if value exceeds 64. Higher values may cause the blur to stop working!")
                highlighted: true
                hoverEnabled: true
                ToolTip.visible: hovered
                Kirigami.Theme.inherit: false
                Kirigami.Theme.textColor: root.Kirigami.Theme.neutralTextColor
                Kirigami.Theme.highlightColor: root.Kirigami.Theme.neutralTextColor
                icon.color: Kirigami.Theme.neutralTextColor
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Grain Effect")
        }

        ComboBox {
            Kirigami.FormData.label: i18n("Enable:")
            id: grainModeCombo
            model: effectStates
            textRole: "label"
            onCurrentIndexChanged: cfg_GrainMode = currentIndex
            currentIndex: cfg_GrainMode
        }

        CheckBox {
            Kirigami.FormData.label: i18n("Animate:")
            id: grainAnimateCheckbox
            checked: cfg_grainAnimate
        }


        RowLayout {
            Kirigami.FormData.label: i18n("Grain size:")
            TextField {
                id: grainSizeInput
                placeholderText: "0-10"
                text: cfg_grainSize
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: 0.0
                    top: 10.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_grainSize = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_grainSize = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Grain amount:")
            TextField {
                id: grainAmountInput
                placeholderText: "0-1"
                text: cfg_grainAmount
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: 0.0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_grainAmount = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_grainAmount = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Desktop Effects")
            Layout.fillWidth: true
        }

        TextField {
            Kirigami.FormData.label: i18n("Hide in:")
            id: effectsHideGrainInput
        }

        TextField {
            Kirigami.FormData.label: i18n("Show in:")
            id: effectsShowGrainInput
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Color Effects")
        }
        ComboBox {
            Kirigami.FormData.label: i18n("Enable:")
            id: colorEffectsModeCombo
            model: effectStates
            textRole: "label"
            onCurrentIndexChanged: cfg_colorEffectsMode = currentIndex
            currentIndex: cfg_colorEffectsMode
        }
        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Desktop Effects")
            Layout.fillWidth: true
        }

        TextField {
            Kirigami.FormData.label: i18n("Hide in:")
            id: effectsHideColorizationInput
        }

        TextField {
            Kirigami.FormData.label: i18n("Show in:")
            id: effectsShowColorizationInput
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Brightness:")
            TextField {
                id: brightnessInput
                placeholderText: "0-1"
                text: cfg_brightness
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: -1.0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_brightness = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_brightness = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Contrast:")
            TextField {
                id: contrastInput
                placeholderText: "0-1"
                text: cfg_contrast
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: -1.0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_contrast = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_contrast = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }
        RowLayout {
            Kirigami.FormData.label: i18n("Saturation:")
            TextField {
                id: saturationInput
                placeholderText: "0-1"
                text: cfg_saturation
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: -1.0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_saturation = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_saturation = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }
        
        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Colorization")
            Layout.fillWidth: true
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Amount:")
            TextField {
                id: colorizationInput
                placeholderText: "0-1"
                text: cfg_colorization
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: 0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_colorization = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_colorization = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }

        RadioButton {
            Kirigami.FormData.label: i18n("Color source:")
            text: i18n("Custom")
            id: customColorizationColorRadio
            ButtonGroup.group: colorizationModeGroup
            property int index: 0
            checked: plasmoid.configuration.colorizationColorMode === index
            enabled: cfg_colorization > 0
        }
        RadioButton {
            text: i18n("System")
            id: systemColorizationColorRadio
            ButtonGroup.group: colorizationModeGroup
            property int index: 1
            checked: plasmoid.configuration.colorizationColorMode === index
            enabled: cfg_colorization > 0
        }

        ButtonGroup {
            id: colorizationModeGroup
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_colorizationColorMode = checkedButton.index
                }
            }
        }

        Components.ColorButton {
            id: colorizationColorButton
            showAlphaChannel: false
            Kirigami.FormData.label: i18n("Color:")
            dialogTitle: i18n("Colorization")
            color: cfg_colorizationColor
            onAccepted: {
                cfg_colorizationColor = color
            }
            enabled: cfg_colorization > 0
            visible: customColorizationColorRadio.checked
        }

        ComboBox {
            id: colorizationColorModeTheme
            Kirigami.FormData.label: i18n("Color:")
            model: systemColors
            visible: systemColorizationColorRadio.checked
            enabled: cfg_colorization > 0
        }

        ComboBox {
            id: colorizationColorModeThemeVariant
            Kirigami.FormData.label: i18n("Color set:")
            model: systemColorSets
            visible: systemColorizationColorRadio.checked
            enabled: cfg_colorization > 0
        }

        Kirigami.Separator {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Rounded Corners")
        }

        CheckBox {
            id: borderEnabledCheckbox
            Kirigami.FormData.label: i18n("Enable:")
            checked: cfg_borderEnabled
            text: i18n("Draw rounded corners over wallpaper")
            onCheckedChanged: {
                cfg_borderEnabled = checked
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Desktop Effects")
            Layout.fillWidth: true
        }

        TextField {
            Kirigami.FormData.label: i18n("Hide in:")
            id: effectsHideBorderInput
        }

        TextField {
            Kirigami.FormData.label: i18n("Show in:")
            id: effectsShowBorderInput
        }

        RadioButton {
            Kirigami.FormData.label: i18n("Color source:")
            text: i18n("Custom")
            id: customColorRadio
            ButtonGroup.group: colorModeGroup
            property int index: 0
            checked: plasmoid.configuration.borderColorMode === index
            enabled: borderEnabledCheckbox.checked
        }
        RadioButton {
            text: i18n("System")
            id: systemColorRadio
            ButtonGroup.group: colorModeGroup
            property int index: 1
            checked: plasmoid.configuration.borderColorMode === index
            enabled: borderEnabledCheckbox.checked
        }

        ButtonGroup {
            id: colorModeGroup
            onCheckedButtonChanged: {
                if (checkedButton) {
                    cfg_borderColorMode = checkedButton.index
                }
            }
        }

        Components.ColorButton {
            id: borderColorButton
            showAlphaChannel: false
            Kirigami.FormData.label: i18n("Color:")
            dialogTitle: i18n("Border Color")
            color: cfg_borderColor
            onAccepted: {
                cfg_borderColor = color
            }
            enabled: borderEnabledCheckbox.checked
            visible: customColorRadio.checked
        }

        ComboBox {
            id: borderModeTheme
            Kirigami.FormData.label: i18n("Color:")
            model: systemColors
            visible: systemColorRadio.checked
            enabled: borderEnabledCheckbox.checked
        }

        ComboBox {
            id: borderModeThemeVariant
            Kirigami.FormData.label: i18n("Color set:")
            model: systemColorSets
            visible: systemColorRadio.checked
            enabled: borderEnabledCheckbox.checked
        }

        SpinBox {
            Kirigami.FormData.label: i18n("Radius:")
            id: borderRadiusSpinBox
            from: 0
            to: 145
            value: cfg_borderRadius
            onValueChanged: {
                cfg_borderRadius = value
            }
            enabled: borderEnabledCheckbox.checked
        }


        RowLayout {
            Kirigami.FormData.label: i18n("Shadow:")
            TextField {
                id: shadowBlurInput
                placeholderText: "0-1"
                text: cfg_shadowBlur
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                property real value: parseFloat(text).toFixed(validator.decimals)

                validator: DoubleValidator {
                    bottom: 0
                    top: 1.0
                    decimals: 2
                    notation: DoubleValidator.StandardNotation
                }

                onValueChanged: {
                    cfg_shadowBlur = isNaN(value) ? 0 : value
                }

                Components.ValueMouseControl {
                    height: parent.height - 8
                    width: height
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    from: parent.validator.bottom
                    to: parent.validator.top
                    decimals: parent.validator.decimals
                    stepSize: 0.05
                    value: parent.value
                    onValueChanged: {
                        cfg_shadowBlur = parseFloat(value).toFixed(decimals)
                    }
                }
            }
        }

        Kirigami.Separator {
            Kirigami.FormData.label: i18n("Margins")
            Layout.fillWidth: true
        }

        SpinBox {
            Kirigami.FormData.label: i18n("Top:")
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
            Kirigami.FormData.label: i18n("Bottom:")
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
            Kirigami.FormData.label: i18n("Left:")
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
            Kirigami.FormData.label: i18n("Right:")
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
