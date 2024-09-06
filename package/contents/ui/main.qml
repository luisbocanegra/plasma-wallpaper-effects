import QtCore
import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import QtQuick.Effects

import "components" as Components

PlasmoidItem {
    id: main
    property bool onDesktop: plasmoid.location === PlasmaCore.Types.Floating
    property string iconName: onDesktop ? "icon" : "error"
    property string icon: Qt.resolvedUrl("../icons/" + iconName + ".svg").toString().replace("file://", "")
    property bool hideWidget: plasmoid.configuration.hideWidget
    property bool inEditMode: Plasmoid.containment.corona?.editMode ? true : false
    property bool widgetConfiguring: Plasmoid.userConfiguring
    property var activeEffects: effectsModel.activeEffects
    property var effectsHideBlur: plasmoid.configuration.effectsHideBlur.split(",").filter(Boolean)
    property var effectsShowBlur: plasmoid.configuration.effectsShowBlur.split(",").filter(Boolean)
    property bool effectHideBlur: effectsHideBlur.some(item => activeEffects.includes(item))
    property bool effectShowBlur: effectsShowBlur.some(item => activeEffects.includes(item))
    property bool showBlur: (windowModel.showBlur && isEnabled && !effectHideBlur) || effectShowBlur
    property int blurRadius: showBlur ? plasmoid.configuration.BlurRadius : 0
    property bool isLoaded: false
    property bool isEnabled: plasmoid.configuration.isEnabled
    property var effectsHideBorder: plasmoid.configuration.effectsHideBorder.split(",").filter(Boolean)
    property var effectsShowBorder: plasmoid.configuration.effectsShowBorder.split(",").filter(Boolean)
    property bool effectHideBorder: effectsHideBorder.some(item => activeEffects.includes(item))
    property bool effectShowBorder: effectsShowBorder.some(item => activeEffects.includes(item))
    property bool borderEnabled: (
            plasmoid.configuration.borderEnabled && isEnabled && !effectHideBorder
        ) || effectShowBorder
    property int borderColorMode: plasmoid.configuration.borderColorMode
    property int borderColorModeTheme: plasmoid.configuration.borderColorModeTheme
    property string borderColor: {
        if (borderColorMode === 0) {
            return plasmoid.configuration.borderColor
        } else {
            return themeColors[borderColorModeTheme]
        }
    }
    property int borderColorModeThemeVariant: plasmoid.configuration.borderColorModeThemeVariant
    property var borderColorScope: {
        return themeScopes[borderColorModeThemeVariant]
    }
    property int borderRadius: plasmoid.configuration.borderRadius
    property int borderMarginTop: plasmoid.configuration.borderMarginTop
    property int borderMarginBottom: plasmoid.configuration.borderMarginBottom
    property int borderMarginLeft: plasmoid.configuration.borderMarginLeft
    property int borderMarginRight: plasmoid.configuration.borderMarginRight
    property var effectsHideColorization: plasmoid.configuration.effectsHideColorization.split(",").filter(Boolean)
    property var effectsShowColorization: plasmoid.configuration.effectsShowColorization.split(",").filter(Boolean)
    property bool effectHideColorization: effectsHideColorization.some(item => activeEffects.includes(item))
    property bool effectShowColorization: effectsShowColorization.some(item => activeEffects.includes(item))
    property bool showColorEffects: (
            windowModel.showColorEffects && isEnabled && !effectHideColorization
        ) || effectShowColorization
    property real brightness: showColorEffects ? plasmoid.configuration.brightness : 0
    property real contrast: showColorEffects ? plasmoid.configuration.contrast : 0
    property real saturation: showColorEffects ? plasmoid.configuration.saturation : 0
    property real colorization: showColorEffects
        ? plasmoid.configuration.colorization
        : 0
    property int colorizationColorMode: plasmoid.configuration.colorizationColorMode
    property int colorizationColorModeTheme: plasmoid.configuration.colorizationColorModeTheme
    property string colorizationColor: {
        if (colorizationColorMode === 0) {
            return plasmoid.configuration.colorizationColor
        } else {
            return themeColors[colorizationColorModeTheme]
        }
    }
    property int colorizationColorModeThemeVariant: plasmoid.configuration.colorizationColorModeThemeVariant
    property var colorizationColorScope: {
        return themeScopes[colorizationColorModeThemeVariant]
    }
    property int animationDuration: plasmoid.configuration.animationDuration
    property real shadowBlur: plasmoid.configuration.shadowBlur
    property var wallpaperItem
    property var wallpaperPluginName
    property var rootItem: {
        let candidate = main.parent;
        while (candidate) {
            if (candidate.parent === null) {
                return candidate;
            }
            candidate = candidate.parent;
        }
        return null
    }
    property var blurItem: null
    property var roundedItem: null
    property var themeColors: [
        "textColor",
        "disabledTextColor",
        "highlightedTextColor",
        "activeTextColor",
        "linkColor",
        "visitedLinkColor",
        "negativeTextColor",
        "neutralTextColor",
        "positiveTextColor",
        "backgroundColor",
        "highlightColor",
        "activeBackgroundColor",
        "linkBackgroundColor",
        "visitedLinkBackgroundColor",
        "negativeBackgroundColor",
        "neutralBackgroundColor",
        "positiveBackgroundColor",
        "alternateBackgroundColor",
        "focusColor",
        "hoverColor"
    ]

    property var themeScopes: [
        "View",
        "Window",
        "Button",
        "Selection",
        "Tooltip",
        "Complementary",
        "Header"
    ]

    Plasmoid.backgroundHints: {
        if (main.inEditMode || !hideWidget) {
            return PlasmaCore.Types.DefaultBackground
        }
        else {
            return PlasmaCore.Types.NoBackground
        }
    }

    toolTipSubText: !onDesktop
        ? "⚠️ " + i18n("Wallpaper not found, this widget must be placed on the Desktop")
        : Plasmoid.metaData.description
    toolTipTextFormat: Text.RichText
    preferredRepresentation: compactRepresentation
    compactRepresentation: CompactRepresentation {
        icon: main.icon
        onDesktop: main.onDesktop
    }
    fullRepresentation: Item {}

    WindowModel {
        id: windowModel
        screenGeometry: Plasmoid.containment.screenGeometry
    }

    EffectsModel {
        id: effectsModel
        active: {
            return [
                effectsShowBlur, effectsHideBlur,
                effectsShowBorder, effectsHideBorder,
                effectsShowColorization, effectsHideColorization
                ].some(arr => arr.length > 0)
        }
    }

    function dumpProps(obj) {
        console.error("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        for (var k of Object.keys(obj)) {
            const val = obj[k]
            if (typeof val === 'function') continue
            if (k === 'metaData') continue
            print(k + "=" + val+"\n")
        }
    }

    property Component blurComponent: MultiEffect {
        property var target
        id: effect
        height: target.height
        width: target.width
        source: target
        visible: {
            return !(blurMax === 0 && brightness === 0 && contrast === 0
                && saturation === 0 && colorization === 0
            )
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
                return main.colorizationColor
            } else {
                return Kirigami.Theme[main.colorizationColor]
            }
        }
        Behavior on blurMax {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on brightness {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on contrast {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on saturation {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on colorization {
            NumberAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on colorizationColor {
            ColorAnimation {
                duration: animationDuration
                easing.type: Easing.InOutQuad
            }
        }
    }

    property Component roundedComponent: Rectangle {
        property var target
        anchors.fill: target
        id: overlayRectangle
        opacity: borderEnabled ? 1 : 0
        visible: opacity !== 0
        z: 1000
        Kirigami.Theme.colorSet: borderColorScope
        Kirigami.Theme.inherit: false
        color: {
            if (main.borderColor.startsWith("#")) {
                return main.borderColor
            } else {
                return Kirigami.Theme[main.borderColor]
            }
        }
        width: target.width
        height: target.height
        layer.enabled: true
        Rectangle {
            id: shadowRect
            anchors.fill: parent
            anchors.topMargin: borderMarginTop
            anchors.bottomMargin: borderMarginBottom
            anchors.leftMargin: borderMarginLeft
            anchors.rightMargin: borderMarginRight
            radius: borderEnabled ? borderRadius : 0
            color: parent.color
            border {
                color: Qt.rgba(Kirigami.Theme.highlightColor.r,Kirigami.Theme.highlightColor.g,Kirigami.Theme.highlightColor.b,0)
                width: 2
            }
            layer.enabled: true
            layer.effect: MultiEffect {
                source: shadowRect
                anchors.fill: shadowRect
                autoPaddingEnabled: true
                shadowBlur: main.shadowBlur
                shadowEnabled: true
                shadowVerticalOffset: 0
                shadowHorizontalOffset: 0
                shadowColor: "black"
            }
            Behavior on radius {
                NumberAnimation {
                    duration: 100
                }
            }
        }
        layer.effect: MultiEffect {
            maskEnabled: true
            maskInverted: true
            maskSpreadAtMax: 1
            maskSpreadAtMin: 1
            maskThresholdMin: 0.5
            maskSource: ShaderEffectSource {
                sourceItem: Item {
                    width: target.width
                    height: target.height
                    Rectangle {
                        anchors.fill: parent
                        anchors.topMargin: borderMarginTop
                        anchors.bottomMargin: borderMarginBottom
                        anchors.leftMargin: borderMarginLeft
                        anchors.rightMargin: borderMarginRight
                        radius: borderEnabled ? borderRadius -2: 0
                        Behavior on radius {
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

    function findBlurSource(element, root) {
        if (!element.children) return null
        var visibleChildren = element.children.filter(function(child) {
            return child.height === root.height && child.width === root.width && child.visible;
        });
        return visibleChildren[visibleChildren.length - 1]
    }

    function applyEffects() {
        if (!wallpaperItem) return
        var blurSource = findBlurSource(wallpaperItem, rootItem)
        if (blurSource) {
            blurItem = blurComponent.createObject(
                wallpaperItem,
                {
                    "target": blurSource
                }
            )
        }
        roundedItem = roundedComponent.createObject(
            wallpaperItem,
            { 
                "target" : wallpaperItem
            }
        )
    }

    function cleanupEffects() {
        if (blurItem) blurItem.destroy()
        if (roundedItem) roundedItem.destroy()
    }

    onWallpaperPluginNameChanged: {
        if (!isLoaded) return
        cleanupEffects()
        applyEffects()
    }

    function reloadWallpaper() {
        wallpaperItem = Plasmoid.containment.wallpaperGraphicsObject
        var tmp = wallpaperItem?.pluginName
        if (wallpaperPluginName !== tmp) {
            wallpaperPluginName = tmp
        }
    }

    Timer {
        id: reloadWallpaperTimer
        running: true
        repeat: true
        interval: 1000
        onTriggered: {
            // console.log(effectsModel.activeEffects);
            reloadWallpaper()
        }
    }

    Timer {
        id: startTimer
        running: false
        repeat: false
        interval: 10
        onTriggered: {
            isLoaded = true
            applyEffects()
        }
    }

    Component.onCompleted: {
        startTimer.start()
    }

    Connections {
        target: Qt.application
        function onAboutToQuit() {
            cleanupEffects()
        }
    }

    Component.onDestruction: {
        cleanupEffects()
    }
}
