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
    id: root
    property alias cfg_hideWidget: hideWidget.checked
    property alias cfg_BlurMode: blurModeCombo.currentIndex
    property alias cfg_GrainMode: grainModeCombo.currentIndex
    property alias cfg_effectsShowGrain: effectsShowGrainInput.text
    property alias cfg_effectsHideGrain: effectsHideGrainInput.text
    property alias cfg_effectsShowPixelate: effectsShowPixelateInput.text
    property alias cfg_effectsHidePixelate: effectsHidePixelateInput.text
    property bool cfg_grainAnimate
    property bool cfg_grainAnimateChange
    property alias cfg_grainOpenGL2Mode: grainOpenGL2ModeCheckbox.checked
    property real cfg_grainAmount: grainAmountInput.value
    property alias cfg_PixelateMode: pixelateModeCombo.currentIndex
    property alias cfg_pixelatePixelSize: pixelatePixelSizeSpinBox.value
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
    property real cfg_brightness: brightnessInput.value
    property real cfg_contrast: contrastInput.value
    property real cfg_saturation: saturationInput.value
    property real cfg_colorization: colorizationInput.value
    property int cfg_colorizationColorMode: plasmoid.configuration.colorizationColorMode
    property alias cfg_colorizationColorModeTheme: colorizationColorModeTheme.currentIndex
    property alias cfg_colorizationColorModeThemeVariant: colorizationColorModeThemeVariant.currentIndex
    property string cfg_colorizationColor
    property alias cfg_colorEffectsMode: colorEffectsModeCombo.currentIndex
    property alias cfg_effectsShowBlur: effectsShowBlurInput.text
    property alias cfg_effectsHideBlur: effectsHideBlurInput.text
    property alias cfg_effectsShowColorization: effectsShowColorizationInput.text
    property alias cfg_effectsHideColorization: effectsHideColorizationInput.text
    property alias cfg_effectsShowBorder: effectsShowBorderInput.text
    property alias cfg_effectsHideBorder: effectsHideBorderInput.text
    property alias cfg_animationDuration: animationDurationSpinBox.value
    property alias cfg_animationOutDuration: animationOutDurationSpinBox.value
    property real cfg_shadowBlur: shadowBlurInput.value
    //TODO remove // when qmlformat off/on becomes a thing
    property var systemColors: [//
        i18n("Text"),
        //
        i18n("Disabled Text"),
        //
        i18n("Highlighted Text"),
        //
        i18n("Active Text"),
        //
        i18n("Link"),
        //
        i18n("Visited Link"),
        //
        i18n("Negative Text"),
        //
        i18n("Neutral Text"),
        //
        i18n("Positive Text"),
        //
        i18n("Background"),
        //
        i18n("Highlight"),
        //
        i18n("Active Background"),
        //
        i18n("Link Background"),
        //
        i18n("Visited Link Background"),
        //
        i18n("Negative Background"),
        //
        i18n("Neutral Background"),
        //
        i18n("Positive Background"),
        //
        i18n("Alternate Background"),
        //
        i18n("Focus"),
        //
        i18n("Hover")//
    ]
    property var systemColorSets: [//
        i18n("View"),
        //
        i18n("Window"),
        //
        i18n("Button"),
        //
        i18n("Selection"),
        //
        i18n("Tooltip"),
        //
        i18n("Complementary"),
        //
        i18n("Header")//
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

    header: ColumnLayout {
        Components.Header {
            id: headerComponent
            Layout.leftMargin: Kirigami.Units.mediumSpacing
            Layout.rightMargin: Kirigami.Units.mediumSpacing
        }
    }

    EffectsModel {
        id: effects
        monitorActive: true
        monitorLoaded: true
        monitorActiveInterval: 500
    }
    ColumnLayout {
        Kirigami.FormLayout {
            id: form1
            CheckBox {
                id: isEnabledCheckbox
                Kirigami.FormData.label: i18n("Enabled:")
            }
        }

        Kirigami.FormLayout {
            enabled: isEnabledCheckbox.checked
            twinFormLayouts: [form1]
            CheckBox {
                id: hideWidget
                Kirigami.FormData.label: i18n("Hide widget:")
            }
            RowLayout {
                Kirigami.FormData.label: i18n("Animation duration (ms):")
                Label {
                    text: i18n("In")
                }
                SpinBox {
                    id: animationDurationSpinBox
                    from: 0
                    to: 60000
                    stepSize: 100
                }
                Label {
                    text: "Out"
                }
                SpinBox {
                    id: animationOutDurationSpinBox
                    from: 0
                    to: 60000
                    stepSize: 100
                }
            }

            CheckBox {
                id: activeScreenOnlyCheckbx
                Kirigami.FormData.label: i18n("Filter windows:")
                text: i18n("This screen only")
            }

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: i18n("Blur")
            }

            ComboBox {
                id: blurModeCombo
                Kirigami.FormData.label: i18n("Enable:")
                model: effectStates
                textRole: "label"
            }

            RowLayout {
                enabled: blurModeCombo.currentIndex !== 4
                Kirigami.FormData.label: i18n("Blur radius:")
                SpinBox {
                    id: blurRadiusSpinBox
                    from: 0
                    to: 145
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
                Kirigami.FormData.label: i18n("Desktop Effects")
                Layout.fillWidth: true
            }

            Components.CheckableValueListView {
                id: effectsHideBlurInput
                Kirigami.FormData.label: i18n("Hide in:")
                model: effects.loadedEffects
                enabled: blurModeCombo.currentIndex !== 4
            }

            Components.CheckableValueListView {
                id: effectsShowBlurInput
                Kirigami.FormData.label: i18n("Show in:")
                model: effects.loadedEffects
                enabled: blurModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: i18n("Pixelate Effect")
            }

            ComboBox {
                id: pixelateModeCombo
                Kirigami.FormData.label: i18n("Enable:")
                model: effectStates
                textRole: "label"
                onCurrentIndexChanged: cfg_PixelateMode = currentIndex
                currentIndex: cfg_PixelateMode
            }

            SpinBox {
                id: pixelatePixelSizeSpinBox
                Kirigami.FormData.label: i18n("Pixel size:")
                from: 0
                to: 100
                enabled: pixelateModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Desktop Effects")
                Layout.fillWidth: true
            }

            Components.CheckableValueListView {
                id: effectsHidePixelateInput
                Kirigami.FormData.label: i18n("Hide in:")
                model: effects.loadedEffects
                enabled: pixelateModeCombo.currentIndex !== 4
            }

            Components.CheckableValueListView {
                id: effectsShowPixelateInput
                Kirigami.FormData.label: i18n("Show in:")
                model: effects.loadedEffects
                enabled: pixelateModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: i18n("Grain Effect")
            }

            ComboBox {
                id: grainModeCombo
                Kirigami.FormData.label: i18n("Enable:")
                model: effectStates
                textRole: "label"
            }

            RowLayout {
                Kirigami.FormData.label: i18n("OpenGL ES 2.0 mode:")
                CheckBox {
                    id: grainOpenGL2ModeCheckbox
                }
                Kirigami.ContextualHelpButton {
                    toolTipText: i18n("Less random grain but supports older devices")
                }
                enabled: grainModeCombo.currentIndex !== 4
            }

            RadioButton {
                Kirigami.FormData.label: i18n("Animate:")
                enabled: grainModeCombo.currentIndex !== 4
                text: i18n("Never")
                checked: !grainAnimateCheckbox.checked && !grainAnimateChangeCheckbox.checked
                ButtonGroup.group: animateButtonGroup
            }
            RadioButton {
                id: grainAnimateCheckbox
                enabled: grainModeCombo.currentIndex !== 4
                text: i18n("Always")
                ButtonGroup.group: animateButtonGroup
                checked: cfg_grainAnimate
                onCheckedChanged: cfg_grainAnimate = checked
            }
            RadioButton {
                id: grainAnimateChangeCheckbox
                enabled: grainModeCombo.currentIndex !== 4
                text: i18n("On change")
                ButtonGroup.group: animateButtonGroup
                checked: cfg_grainAnimateChange
                onCheckedChanged: cfg_grainAnimateChange = checked
            }
            ButtonGroup {
                id: animateButtonGroup
            }

            Components.DoubleSpinBox {
                id: grainAmountInput
                Kirigami.FormData.label: i18n("Grain amount:")
                from: 0 * multiplier
                to: 1 * multiplier
                value: root.cfg_grainAmount * multiplier
                onValueModified: {
                    root.cfg_grainAmount = value / grainAmountInput.multiplier;
                }
                enabled: grainModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Desktop Effects")
                Layout.fillWidth: true
            }

            Components.CheckableValueListView {
                id: effectsHideGrainInput
                Kirigami.FormData.label: i18n("Hide in:")
                model: effects.loadedEffects
                enabled: grainModeCombo.currentIndex !== 4
            }

            Components.CheckableValueListView {
                id: effectsShowGrainInput
                Kirigami.FormData.label: i18n("Show in:")
                model: effects.loadedEffects
                enabled: grainModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: i18n("Color Effects")
            }
            ComboBox {
                id: colorEffectsModeCombo
                Kirigami.FormData.label: i18n("Enable:")
                model: effectStates
                textRole: "label"
            }

            Components.DoubleSpinBox {
                id: brightnessInput
                Kirigami.FormData.label: i18n("Brightness:")
                from: -1 * multiplier
                to: 1 * multiplier
                value: root.cfg_brightness * multiplier
                onValueModified: {
                    root.cfg_brightness = value / brightnessInput.multiplier;
                }
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }
            Components.DoubleSpinBox {
                id: contrastInput
                Kirigami.FormData.label: i18n("Contrast:")
                from: -1 * multiplier
                to: 1 * multiplier
                value: root.cfg_contrast * multiplier
                onValueModified: {
                    root.cfg_contrast = value / contrastInput.multiplier;
                }
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }
            Components.DoubleSpinBox {
                id: saturationInput
                Kirigami.FormData.label: i18n("Saturation:")
                from: 0 * multiplier
                to: 1 * multiplier
                value: root.cfg_saturation * multiplier
                onValueModified: {
                    root.cfg_saturation = value / saturationInput.multiplier;
                }
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Colorization")
                Layout.fillWidth: true
            }

            Components.DoubleSpinBox {
                id: colorizationInput
                Kirigami.FormData.label: i18n("Amount:")
                from: 0 * multiplier
                to: 1 * multiplier
                value: root.cfg_colorization * multiplier
                onValueModified: {
                    root.cfg_colorization = value / colorizationInput.multiplier;
                }
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }

            RadioButton {
                id: customColorizationColorRadio
                Kirigami.FormData.label: i18n("Color source:")
                text: i18n("Custom")
                ButtonGroup.group: colorizationModeGroup
                property int index: 0
                checked: plasmoid.configuration.colorizationColorMode === index
                enabled: cfg_colorization > 0 && colorEffectsModeCombo.currentIndex !== 4
            }
            RadioButton {
                id: systemColorizationColorRadio
                text: i18n("System")
                ButtonGroup.group: colorizationModeGroup
                property int index: 1
                checked: plasmoid.configuration.colorizationColorMode === index
                enabled: cfg_colorization > 0 && colorEffectsModeCombo.currentIndex !== 4
            }

            ButtonGroup {
                id: colorizationModeGroup
                onCheckedButtonChanged: {
                    if (checkedButton) {
                        cfg_colorizationColorMode = checkedButton.index;
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
                    cfg_colorizationColor = color;
                }
                enabled: cfg_colorization > 0 && colorEffectsModeCombo.currentIndex !== 4
                visible: customColorizationColorRadio.checked
            }

            ComboBox {
                id: colorizationColorModeTheme
                Kirigami.FormData.label: i18n("Color:")
                model: systemColors
                visible: systemColorizationColorRadio.checked
                enabled: cfg_colorization > 0 && colorEffectsModeCombo.currentIndex !== 4
            }

            ComboBox {
                id: colorizationColorModeThemeVariant
                Kirigami.FormData.label: i18n("Color set:")
                model: systemColorSets
                visible: systemColorizationColorRadio.checked
                enabled: cfg_colorization > 0 && colorEffectsModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Desktop Effects")
                Layout.fillWidth: true
            }

            Components.CheckableValueListView {
                id: effectsHideColorizationInput
                Kirigami.FormData.label: i18n("Hide in:")
                model: effects.loadedEffects
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }

            Components.CheckableValueListView {
                id: effectsShowColorizationInput
                Kirigami.FormData.label: i18n("Show in:")
                model: effects.loadedEffects
                enabled: colorEffectsModeCombo.currentIndex !== 4
            }

            Kirigami.Separator {
                Kirigami.FormData.isSection: true
                Kirigami.FormData.label: i18n("Rounded Corners")
            }

            RowLayout {
                Kirigami.FormData.label: i18n("Enable:")
                CheckBox {
                    id: borderEnabledCheckbox
                }
                Kirigami.ContextualHelpButton {
                    toolTipText: i18n("Draw rounded corners on top of the wallpaper")
                }
            }

            RadioButton {
                id: customColorRadio
                Kirigami.FormData.label: i18n("Color source:")
                text: i18n("Custom")
                ButtonGroup.group: colorModeGroup
                property int index: 0
                checked: plasmoid.configuration.borderColorMode === index
                enabled: borderEnabledCheckbox.checked
            }
            RadioButton {
                id: systemColorRadio
                text: i18n("System")
                ButtonGroup.group: colorModeGroup
                property int index: 1
                checked: plasmoid.configuration.borderColorMode === index
                enabled: borderEnabledCheckbox.checked
            }

            ButtonGroup {
                id: colorModeGroup
                onCheckedButtonChanged: {
                    if (checkedButton) {
                        cfg_borderColorMode = checkedButton.index;
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
                    cfg_borderColor = color;
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
                id: borderRadiusSpinBox
                Kirigami.FormData.label: i18n("Radius:")
                from: 0
                to: 145
                enabled: borderEnabledCheckbox.checked
            }

            Components.DoubleSpinBox {
                id: shadowBlurInput
                Kirigami.FormData.label: i18n("Shadow:")
                from: 0 * multiplier
                to: 1 * multiplier
                value: root.cfg_shadowBlur * multiplier
                onValueModified: {
                    root.cfg_shadowBlur = value / shadowBlurInput.multiplier;
                }
                enabled: borderEnabledCheckbox.checked
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Margins")
                Layout.fillWidth: true
            }

            SpinBox {
                id: marginTopSpinBox
                Kirigami.FormData.label: i18n("Top:")
                from: 0
                to: 999
                value: cfg_borderMarginTop
                onValueChanged: {
                    cfg_borderMarginTop = value;
                }
                enabled: borderEnabledCheckbox.checked
            }
            SpinBox {
                id: marginBottomSpinBox
                Kirigami.FormData.label: i18n("Bottom:")
                from: 0
                to: 999
                value: cfg_borderMarginBottom
                onValueChanged: {
                    cfg_borderMarginBottom = value;
                }
                enabled: borderEnabledCheckbox.checked
            }
            SpinBox {
                id: marginLeftSpinBox
                Kirigami.FormData.label: i18n("Left:")
                from: 0
                to: 999
                value: cfg_borderMarginLeft
                onValueChanged: {
                    cfg_borderMarginLeft = value;
                }
                enabled: borderEnabledCheckbox.checked
            }
            SpinBox {
                id: marginRightSpinBox
                Kirigami.FormData.label: i18n("Right:")
                from: 0
                to: 999
                value: cfg_borderMarginRight
                onValueChanged: {
                    cfg_borderMarginRight = value;
                }
                enabled: borderEnabledCheckbox.checked
            }

            Kirigami.Separator {
                Kirigami.FormData.label: i18n("Desktop Effects")
                Layout.fillWidth: true
            }

            Components.CheckableValueListView {
                id: effectsHideBorderInput
                Kirigami.FormData.label: i18n("Hide in:")
                model: effects.loadedEffects
                enabled: borderEnabledCheckbox.checked
            }

            Components.CheckableValueListView {
                id: effectsShowBorderInput
                Kirigami.FormData.label: i18n("Show in:")
                model: effects.loadedEffects
                enabled: borderEnabledCheckbox.checked
            }
        }
    }
}
