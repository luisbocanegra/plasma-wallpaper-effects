pragma ComponentBehavior: Bound

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import QtQuick.Effects

import "components" as Components

PlasmoidItem {
    id: main
    property bool onDesktop: Plasmoid.location === PlasmaCore.Types.Floating
    property string iconName: onDesktop ? "icon" : "error"
    property string icon: Qt.resolvedUrl("../icons/" + iconName + ".svg").toString().replace("file://", "")
    property bool hideWidget: Plasmoid.configuration.hideWidget
    property bool inEditMode: containmentItem?.corona?.editMode ?? false
    property bool widgetConfiguring: Plasmoid.userConfiguring

    property var activeEffects: effectsModel.activeEffects

    property var effectsHideBlur: Plasmoid.configuration.effectsHideBlur.split(",").filter(Boolean)
    property var effectsShowBlur: Plasmoid.configuration.effectsShowBlur.split(",").filter(Boolean)
    property bool effectHideBlur: effectsHideBlur.some(item => activeEffects.includes(item))
    property bool effectShowBlur: effectsShowBlur.some(item => activeEffects.includes(item))
    property int blurRadius: showBlur ? Plasmoid.configuration.BlurRadius : 0

    property var effectsHideGrain: Plasmoid.configuration.effectsHideGrain.split(",").filter(Boolean)
    property var effectsShowGrain: Plasmoid.configuration.effectsShowGrain.split(",").filter(Boolean)
    property bool effectHideGrain: effectsHideGrain.some(item => activeEffects.includes(item))
    property bool effectShowGrain: effectsShowGrain.some(item => activeEffects.includes(item))

    property var effectsHidePixelate: Plasmoid.configuration.effectsHidePixelate.split(",").filter(Boolean)
    property var effectsShowPixelate: Plasmoid.configuration.effectsShowPixelate.split(",").filter(Boolean)
    property bool effectHidePixelate: effectsHidePixelate.some(item => activeEffects.includes(item))
    property bool effectShowPixelate: effectsShowPixelate.some(item => activeEffects.includes(item))

    property bool isEnabled: Plasmoid.configuration.isEnabled

    property var effectsHideBorder: Plasmoid.configuration.effectsHideBorder.split(",").filter(Boolean)
    property var effectsShowBorder: Plasmoid.configuration.effectsShowBorder.split(",").filter(Boolean)
    property bool effectHideBorder: effectsHideBorder.some(item => activeEffects.includes(item))
    property bool effectShowBorder: effectsShowBorder.some(item => activeEffects.includes(item))
    property bool borderEnabled: (Plasmoid.configuration.borderEnabled && isEnabled && !effectHideBorder) || effectShowBorder
    property bool innerBorderEnabled: Plasmoid.configuration.innerBorderEnabled && borderEnabled

    property int borderColorMode: Plasmoid.configuration.borderColorMode
    property int borderColorModeTheme: Plasmoid.configuration.borderColorModeTheme
    property string borderColor: {
        if (borderColorMode === 0) {
            return Plasmoid.configuration.borderColor;
        } else {
            return themeColors[borderColorModeTheme];
        }
    }
    property int borderColorModeThemeVariant: Plasmoid.configuration.borderColorModeThemeVariant
    property var borderColorScope: {
        return themeScopes[borderColorModeThemeVariant];
    }

    property int innerBorderColorMode: Plasmoid.configuration.innerBorderColorMode
    property int innerBorderColorModeTheme: Plasmoid.configuration.innerBorderColorModeTheme
    property string innerBorderColor: {
        if (innerBorderColorMode === 0) {
            return Plasmoid.configuration.innerBorderColor;
        } else {
            return themeColors[innerBorderColorModeTheme];
        }
    }
    property int innerBorderColorModeThemeVariant: Plasmoid.configuration.innerBorderColorModeThemeVariant
    property var innerBorderColorScope: {
        return themeScopes[innerBorderColorModeThemeVariant];
    }

    property int borderRadiusTopLeft: Plasmoid.configuration.borderRadiusTopLeft
    property int borderRadiusTopRight: Plasmoid.configuration.borderRadiusTopRight
    property int borderRadiusBottomLeft: Plasmoid.configuration.borderRadiusBottomLeft
    property int borderRadiusBottomRight: Plasmoid.configuration.borderRadiusBottomRight
    property int borderMarginTop: Plasmoid.configuration.borderMarginTop
    property int borderMarginBottom: Plasmoid.configuration.borderMarginBottom
    property int borderMarginLeft: Plasmoid.configuration.borderMarginLeft
    property int borderMarginRight: Plasmoid.configuration.borderMarginRight
    property bool autoMargins: Plasmoid.configuration.autoMargins
    property int autoMarginOffsetTop: Plasmoid.configuration.autoMarginOffsetTop
    property int autoMarginOffsetBottom: Plasmoid.configuration.autoMarginOffsetBottom
    property int autoMarginOffsetLeft: Plasmoid.configuration.autoMarginOffsetLeft
    property int autoMarginOffsetRight: Plasmoid.configuration.autoMarginOffsetRight
    property var borderMargins: {
        if (autoMargins) {
            let top = Plasmoid.containment.availableScreenRect.y;
            let bottom = (Plasmoid.containment.screenGeometry.height - Plasmoid.containment.availableScreenRect.height) - top;
            let left = Plasmoid.containment.availableScreenRect.x;
            let right = (Plasmoid.containment.screenGeometry.width - Plasmoid.containment.availableScreenRect.width) - left;
            return {
                "top": top + autoMarginOffsetTop,
                "bottom": bottom + autoMarginOffsetBottom,
                "left": left + autoMarginOffsetLeft,
                "right": right + autoMarginOffsetRight
            };
        }
        return {
            "top": borderMarginTop,
            "bottom": borderMarginBottom,
            "left": borderMarginLeft,
            "right": borderMarginRight
        };
    }

    property var effectsHideColorization: Plasmoid.configuration.effectsHideColorization.split(",").filter(Boolean)
    property var effectsShowColorization: Plasmoid.configuration.effectsShowColorization.split(",").filter(Boolean)
    property bool effectHideColorization: effectsHideColorization.some(item => activeEffects.includes(item))
    property bool effectShowColorization: effectsShowColorization.some(item => activeEffects.includes(item))

    property real brightness: showColorEffects ? Plasmoid.configuration.brightness : 0
    property real contrast: showColorEffects ? Plasmoid.configuration.contrast : 0
    property real saturation: showColorEffects ? Plasmoid.configuration.saturation : 0
    property real colorization: showColorEffects ? Plasmoid.configuration.colorization : 0
    property int colorizationColorMode: Plasmoid.configuration.colorizationColorMode
    property int colorizationColorModeTheme: Plasmoid.configuration.colorizationColorModeTheme
    property string colorizationColor: {
        if (colorizationColorMode === 0) {
            return Plasmoid.configuration.colorizationColor;
        } else {
            return themeColors[colorizationColorModeTheme];
        }
    }
    property int colorizationColorModeThemeVariant: Plasmoid.configuration.colorizationColorModeThemeVariant
    property var colorizationColorScope: {
        return themeScopes[colorizationColorModeThemeVariant];
    }
    property int animationInDuration: Plasmoid.configuration.animationDuration
    property int animationOutDuration: Plasmoid.configuration.animationOutDuration
    property real shadowBlur: Plasmoid.configuration.shadowBlur
    property bool contextualActionsEnabled: Plasmoid.configuration.contextualActionsEnabled
    property var wallpaperItem: containmentItem?.wallpaperGraphicsObject ?? null
    property var wallpaperPluginName: wallpaperItem?.pluginName ?? null
    property var containmentPluginName: containmentItem?.pluginName ?? null
    property var containmentItem: Plasmoid.containment ?? null
    property var rootItem: {
        let candidate = main.parent;
        while (candidate) {
            if (candidate.parent === null) {
                return candidate;
            }
            candidate = candidate.parent;
        }
        return null;
    }
    property var blurItem: null
    property var shaderItem: null
    property var borderItem: null
    property var roundedItem: null
    property var pixelateItem: null

    property var themeColors: ["textColor", "disabledTextColor", "highlightedTextColor", "activeTextColor", "linkColor", "visitedLinkColor", "negativeTextColor", "neutralTextColor", "positiveTextColor", "backgroundColor", "highlightColor", "activeBackgroundColor", "linkBackgroundColor", "visitedLinkBackgroundColor", "negativeBackgroundColor", "neutralBackgroundColor", "positiveBackgroundColor", "alternateBackgroundColor", "focusColor", "hoverColor"]

    property var themeScopes: ["View", "Window", "Button", "Selection", "Tooltip", "Complementary", "Header"]

    property bool showBlur: {
        let shouldBlur = false;
        switch (Plasmoid.configuration.BlurMode) {
        case 0:
            shouldBlur = tasksModel.maximizedExists;
            break;
        case 1:
            shouldBlur = tasksModel.activeExists;
            break;
        case 2:
            shouldBlur = tasksModel.visibleExists;
            break;
        case 3:
            shouldBlur = true;
            break;
        case 4:
            shouldBlur = false;
        }
        return (shouldBlur && isEnabled && !effectHideBlur) || effectShowBlur;
    }
    property bool showGrain: {
        let shouldGrain = true;
        switch (Plasmoid.configuration.GrainMode) {
        case 0:
            shouldGrain = tasksModel.maximizedExists;
            break;
        case 1:
            shouldGrain = tasksModel.activeExists;
            break;
        case 2:
            shouldGrain = tasksModel.visibleExists;
            break;
        case 3:
            shouldGrain = true;
            break;
        case 4:
            shouldGrain = false;
        }
        return (shouldGrain && isEnabled && !effectHideGrain) || effectShowGrain;
    }

    property bool showColorEffects: {
        let showEffect = true;
        switch (Plasmoid.configuration.colorEffectsMode) {
        case 0:
            showEffect = tasksModel.maximizedExists;
            break;
        case 1:
            showEffect = tasksModel.activeExists;
            break;
        case 2:
            showEffect = tasksModel.visibleExists;
            break;
        case 3:
            showEffect = true;
            break;
        case 4:
            showEffect = false;
        }
        return (showEffect && isEnabled && !effectHideColorization) || effectShowColorization;
    }

    property bool showPixelate: {
        let shouldPixelate = true;
        switch (Plasmoid.configuration.PixelateMode) {
        case 0:
            shouldPixelate = tasksModel.maximizedExists;
            break;
        case 1:
            shouldPixelate = tasksModel.activeExists;
            break;
        case 2:
            shouldPixelate = tasksModel.visibleExists;
            break;
        case 3:
            shouldPixelate = true;
            break;
        case 4:
            shouldPixelate = false;
        }
        return (shouldPixelate && isEnabled && !effectHidePixelate) || effectShowPixelate;
    }

    Plasmoid.backgroundHints: {
        if (main.inEditMode || !hideWidget) {
            return PlasmaCore.Types.DefaultBackground;
        } else {
            return PlasmaCore.Types.NoBackground;
        }
    }

    toolTipSubText: !onDesktop ? "⚠️ " + i18n("Wallpaper not found, this widget must be placed on the Desktop") : Plasmoid.metaData.description
    toolTipTextFormat: Text.RichText
    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {
        icon: main.icon
        onDesktop: main.onDesktop
    }
    fullRepresentation: Item {}

    TasksModel {
        id: tasksModel
        screenGeometry: Plasmoid.containment.screenGeometry
    }

    EffectsModel {
        id: effectsModel
        monitorActive: {
            return [effectsShowBlur, effectsHideBlur, effectsShowBorder, effectsHideBorder, effectsShowColorization, effectsHideColorization].some(arr => arr.length > 0);
        }
    }

    function dumpProps(obj) {
        console.error("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        for (var k of Object.keys(obj)) {
            const val = obj[k];
            if (typeof val === 'function')
                continue;
            if (k === 'metaData')
                continue;
            print(k + "=" + val + "\n");
        }
    }

    property Component blurComponent: MultiEffect {
        id: effect
        property var target
        height: target.height
        width: target.width
        source: target
        visible: {
            return !(blurMax === 0 && brightness === 0 && contrast === 0 && saturation === 0 && colorization === 0);
        }
        blurEnabled: true
        blurMax: blurRadius
        blur: 1
        autoPaddingEnabled: false
        brightness: main.brightness
        contrast: main.contrast
        saturation: main.saturation
        colorization: main.colorization
        Kirigami.Theme.colorSet: Kirigami.Theme[colorizationColorScope]
        Kirigami.Theme.inherit: false
        colorizationColor: {
            if (main.colorizationColor.startsWith("#")) {
                return main.colorizationColor;
            } else {
                return Kirigami.Theme[main.colorizationColor];
            }
        }
        Behavior on blurMax {
            NumberAnimation {
                duration: blurMax > 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on brightness {
            NumberAnimation {
                duration: brightness !== 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on contrast {
            NumberAnimation {
                duration: contrast !== 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on saturation {
            NumberAnimation {
                duration: saturation > 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on colorization {
            NumberAnimation {
                duration: colorization > 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on colorizationColor {
            ColorAnimation {
                duration: animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    property Component pixelateEffect: ShaderEffect {
        id: pixelate
        property var blurItem
        property var effectsSource
        height: blurItem.height
        width: blurItem.width

        property var source: ShaderEffectSource {
            sourceItem: {
                if (!pixelate.visible) {
                    return null;
                }
                return pixelate.blurItem.visible ? pixelate.blurItem : pixelate.effectsSource;
            }
            live: true
            hideSource: pixelate.visible
            textureMirroring: ShaderEffectSource.MirrorVertically
        }
        property real pixelSize: main.showPixelate ? Plasmoid.configuration.pixelatePixelSize : 1
        property vector2d textureResolution: Qt.vector2d(blurItem.width, blurItem.height)

        Behavior on pixelSize {
            NumberAnimation {
                duration: pixelSize > 1 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }
        visible: pixelSize !== 1
        fragmentShader: visible ? Qt.resolvedUrl("shaders/pixelate.frag.qsb") : ""
    }

    property Component grainEffect: ShaderEffect {
        id: shader
        property var blurItem
        property var effectsSource
        property var pixelateItem
        height: blurItem.height
        width: blurItem.width

        property var source: ShaderEffectSource {
            sourceItem: {
                if (!shader.visible) {
                    return null;
                }
                if (shader.pixelateItem.visible) {
                    return pixelateItem;
                }
                return shader.blurItem.visible ? shader.blurItem : shader.effectsSource;
            }
            live: true
            hideSource: shader.visible
            textureMirroring: ShaderEffectSource.MirrorVertically
        }

        property bool isAnimationRunning: grain_amount !== Plasmoid.configuration.grainAmount
        property real time: 0
        property bool animate: Plasmoid.configuration.grainAnimate || isAnimationRunning
        property real grain_amount: main.showGrain ? Plasmoid.configuration.grainAmount : 0
        Behavior on grain_amount {
            NumberAnimation {
                duration: grain_amount > 0 ? animationOutDuration : animationInDuration
                easing.type: Easing.InOutQuad
            }
        }

        visible: grain_amount !== 0
        fragmentShader: {
            if (!visible) {
                return "";
            }
            if (Plasmoid.configuration.grainOpenGL2Mode) {
                return Qt.resolvedUrl("shaders/grainOpenGL2.frag.qsb");
            }
            return Qt.resolvedUrl("shaders/grain.frag.qsb");
        }
    }

    property Component roundedComponent: Rectangle {
        id: overlayRectangle
        property var target
        opacity: borderEnabled ? 1 : 0
        visible: opacity !== 0
        z: 1000
        Kirigami.Theme.colorSet: borderColorScope
        Kirigami.Theme.inherit: false
        color: {
            if (main.borderColor.startsWith("#")) {
                return main.borderColor;
            } else {
                return Kirigami.Theme[main.borderColor];
            }
        }
        width: target.width
        height: target.height
        Kirigami.ShadowedRectangle {
            id: shadowRect
            anchors.fill: parent
            anchors.topMargin: main.borderMargins.top
            anchors.bottomMargin: main.borderMargins.bottom
            anchors.leftMargin: main.borderMargins.left
            anchors.rightMargin: main.borderMargins.right
            color: parent.color
            shadow.size: main.shadowBlur * 32
            shadow.color: "black"
            shadow.xOffset: 0
            shadow.yOffset: 0
            corners.topLeftRadius: borderEnabled ? borderRadiusTopLeft : 0
            corners.topRightRadius: borderEnabled ? borderRadiusTopRight : 0
            corners.bottomLeftRadius: borderEnabled ? borderRadiusBottomLeft : 0
            corners.bottomRightRadius: borderEnabled ? borderRadiusBottomRight : 0
            Behavior on corners.topLeftRadius {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on corners.topRightRadius {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on corners.bottomLeftRadius {
                NumberAnimation {
                    duration: 100
                }
            }
            Behavior on corners.bottomRightRadius {
                NumberAnimation {
                    duration: 100
                }
            }
        }
        layer.enabled: true
        layer.effect: Components.OpacityMaskInverted {
            source: ShaderEffectSource {
                sourceItem: overlayRectangle
            }
            maskSource: ShaderEffectSource {
                sourceItem: Item {
                    width: overlayRectangle.width
                    height: overlayRectangle.height
                    Rectangle {
                        anchors.fill: parent
                        anchors.topMargin: main.borderMargins.top
                        anchors.bottomMargin: main.borderMargins.bottom
                        anchors.leftMargin: main.borderMargins.left
                        anchors.rightMargin: main.borderMargins.right
                        color: "white"
                        topLeftRadius: borderEnabled ? Math.max(0, borderRadiusTopLeft - 2) : 0
                        topRightRadius: borderEnabled ? Math.max(0, borderRadiusTopRight - 2) : 0
                        bottomLeftRadius: borderEnabled ? Math.max(0, borderRadiusBottomLeft - 2) : 0
                        bottomRightRadius: borderEnabled ? Math.max(0, borderRadiusBottomRight - 2) : 0
                        Behavior on topLeftRadius {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                        Behavior on topRightRadius {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                        Behavior on bottomLeftRadius {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                        Behavior on bottomRightRadius {
                            NumberAnimation {
                                duration: 100
                            }
                        }
                    }
                }
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 100
            }
        }
    }

    property Component borderComponent: Rectangle {
        id: overlayBorder
        property var target
        anchors.fill: target
        anchors.topMargin: main.borderMargins.top
        anchors.bottomMargin: main.borderMargins.bottom
        anchors.leftMargin: main.borderMargins.left
        anchors.rightMargin: main.borderMargins.right
        opacity: innerBorderEnabled ? 1 : 0
        z: 1000
        color: "transparent"
        border.color: {
            if (innerBorderColor.startsWith("#")) {
                return innerBorderColor;
            } else {
                return Kirigami.Theme[innerBorderColor];
            }
        }
        border.width: Plasmoid.configuration.innerBorderWidth
        Behavior on opacity {
            NumberAnimation {
                duration: 100
            }
        }
        topLeftRadius: borderEnabled ? Math.max(0, borderRadiusTopLeft - 2) : 0
        topRightRadius: borderEnabled ? Math.max(0, borderRadiusTopRight - 2) : 0
        bottomLeftRadius: borderEnabled ? Math.max(0, borderRadiusBottomLeft - 2) : 0
        bottomRightRadius: borderEnabled ? Math.max(0, borderRadiusBottomRight - 2) : 0
    }

    function findBlurSource(element, root) {
        if (!element.children)
            return null;
        var visibleChildren = element.children.filter(function (child) {
            return child.height === root.height && child.width === root.width && child.visible;
        });
        return visibleChildren[visibleChildren.length - 1];
    }

    function applyEffects() {
        if (!wallpaperItem || !rootItem)
            return;
        var effectsSource = findBlurSource(wallpaperItem, rootItem);
        if (effectsSource) {
            blurItem = blurComponent.createObject(wallpaperItem, {
                "target": effectsSource
            });
            pixelateItem = pixelateEffect.createObject(wallpaperItem, {
                "blurItem": blurItem,
                "effectsSource": effectsSource
            });
            shaderItem = grainEffect.createObject(wallpaperItem, {
                "blurItem": blurItem,
                "pixelateItem": pixelateItem,
                "effectsSource": effectsSource
            });
        }
        roundedItem = roundedComponent.createObject(wallpaperItem, {
            "target": wallpaperItem
        });

        borderItem = borderComponent.createObject(wallpaperItem, {
            "target": wallpaperItem
        });
    }

    function cleanupEffects() {
        if (blurItem)
            blurItem.destroy();
        if (borderItem)
            borderItem.destroy();
        if (roundedItem)
            roundedItem.destroy();
        if (shaderItem)
            shaderItem.destroy();
        if (pixelateItem)
            pixelateItem.destroy();
    }

    function restart() {
        if (!wallpaperPluginName || !containmentPluginName)
            return;
        cleanupEffects();
        // callLater so applyEffects runs after effects are destroyed
        Qt.callLater(applyEffects);
    }

    onWallpaperPluginNameChanged: {
        restart();
    }
    onContainmentPluginNameChanged: {
        restart();
    }

    PlasmaCore.Action {
        id: configureEffectsAction
        objectName: "wallpaperEffectsAction"
        text: i18n("Configure %1", Plasmoid.metaData.name)
        icon.name: 'configure'
        onTriggered: Plasmoid.internalAction("configure").trigger()
    }

    PlasmaCore.Action {
        id: toggleEffectsAction
        objectName: "wallpaperEffectsAction"
        text: (Plasmoid.configuration.isEnabled ? i18n("Disable") : i18n("Enable")) + ` ${Plasmoid.metaData.name}`
        icon.name: "starred-symbolic"
        onTriggered: {
            Plasmoid.configuration.isEnabled = !Plasmoid.configuration.isEnabled;
            Plasmoid.configuration.writeConfig();
        }
    }

    PlasmaCore.Action {
        id: hideWidgetAction
        text: (Plasmoid.configuration.hideWidget ? i18n("Show") : i18n("Hide")) + " widget"
        icon.name: "visibility-symbolic"
        onTriggered: {
            Plasmoid.configuration.hideWidget = !Plasmoid.configuration.hideWidget;
            Plasmoid.configuration.writeConfig();
        }
    }

    onContainmentItemChanged: {
        updateContextualActions();
    }

    onContextualActionsEnabledChanged: {
        updateContextualActions();
    }

    Connections {
        target: Qt.application
        function onAboutToQuit() {
            main.cleanupEffects();
            main.removeContextualActions();
        }
    }

    Component.onDestruction: {
        cleanupEffects();
        removeContextualActions();
    }

    Timer {
        id: shaderTimer
        running: (main.shaderItem && main.shaderItem.visible && Plasmoid.configuration.grainAnimate) || ((main.shaderItem?.isAnimationRunning ?? false) && Plasmoid.configuration.grainAnimateChange)
        onRunningChanged: {
            if (!running) {
                shaderItem.time = 0;
            }
        }
        repeat: true
        interval: 33
        onTriggered: {
            if (shaderItem) {
                shaderItem.time += 0.033;
            }
        }
    }

    Plasmoid.contextualActions: [toggleEffectsAction, hideWidgetAction]

    function updateContextualActions() {
        removeContextualActions();
        if (contextualActionsEnabled) {
            if (containmentItem && "contextualActions" in containmentItem) {
                containmentItem.contextualActions = [...containmentItem.contextualActions, toggleEffectsAction, configureEffectsAction];
            }
        }
    }

    function removeContextualActions() {
        if (containmentItem && "contextualActions" in containmentItem) {
            containmentItem.contextualActions = containmentItem.contextualActions.filter(action => action && action.objectName !== "wallpaperEffectsAction");
        }
    }
}
