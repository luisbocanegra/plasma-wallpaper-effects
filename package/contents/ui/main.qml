import QtCore
import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects
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
    property bool showBlur: windowModel.showBlur && isEnabled
    property int blurRadius: showBlur ? plasmoid.configuration.BlurRadius : 0
    property bool isLoaded: false
    property bool isEnabled: plasmoid.configuration.isEnabled
    property bool borderEnabled: plasmoid.configuration.borderEnabled && isEnabled
    property int borderColorMode: plasmoid.configuration.borderColorMode
    property int borderColorModeTheme: plasmoid.configuration.borderColorModeTheme
    property string borderColor: {
        if (borderColorMode === 0) {
            return plasmoid.configuration.borderColor
        } else {
            Kirigami.Theme.colorSet = borderColorScope
            Kirigami.Theme.inherit = false
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
    property var wallpaperItem: Plasmoid.containment.wallpaperGraphicsObject
    property string wallpaperPluginName: wallpaperItem?.pluginName
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
        Kirigami.Theme.textColor,
        Kirigami.Theme.disabledTextColor,
        Kirigami.Theme.highlightedTextColor,
        Kirigami.Theme.activeTextColor,
        Kirigami.Theme.linkColor,
        Kirigami.Theme.visitedLinkColor,
        Kirigami.Theme.negativeTextColor,
        Kirigami.Theme.neutralTextColor,
        Kirigami.Theme.positiveTextColor,
        Kirigami.Theme.backgroundColor,
        Kirigami.Theme.highlightColor,
        Kirigami.Theme.activeBackgroundColor,
        Kirigami.Theme.linkBackgroundColor,
        Kirigami.Theme.visitedLinkBackgroundColor,
        Kirigami.Theme.negativeBackgroundColor,
        Kirigami.Theme.neutralBackgroundColor,
        Kirigami.Theme.positiveBackgroundColor,
        Kirigami.Theme.alternateBackgroundColor,
        Kirigami.Theme.focusColor,
        Kirigami.Theme.hoverColor
    ]

    property var themeScopes: [
        Kirigami.Theme.View,
        Kirigami.Theme.Window,
        Kirigami.Theme.Button,
        Kirigami.Theme.Selection,
        Kirigami.Theme.Tooltip,
        Kirigami.Theme.Complementary,
        Kirigami.Theme.Header
    ]

    Plasmoid.backgroundHints: {
        if (main.inEditMode || !hideWidget) {
            return PlasmaCore.Types.DefaultBackground
        }
        else {
            return PlasmaCore.Types.NoBackground
        }
    }

    toolTipSubText: !onDesktop ? "⚠️ Wallpaper not found, this widget must be placed on the Desktop" : Plasmoid.metaData.description
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

    function dumpProps(obj) {
        console.error("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        for (var k of Object.keys(obj)) {
            const val = obj[k]
            if (typeof val === 'function') continue
            if (k === 'metaData') continue
            print(k + "=" + val+"\n")
        }
    }

    property Component blurComponent: Rectangle {
        color:"transparent"
        id: blurRect
        height: target.height
        width: target.width
        property var target
        FastBlur {
            anchors.fill: parent
            radius: blurRadius
            source: target
            Behavior on radius {
                NumberAnimation {
                    duration: 300
                }
            }
        }
    }

    property Component roundedComponent: Item {
        property var target
        property var root
        anchors.fill: target
        opacity: borderEnabled ? 1 : 0
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
        Rectangle {
            id: overlayRectangle
            color: borderColor
            width: target.width
            height: target.height
            layer.enabled: true
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
                            radius: borderEnabled ? borderRadius : 0
                            Behavior on radius {
                                NumberAnimation {
                                    duration: 300
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function findBlurSource(element, root) {
        var visibleChildren = element.children.filter(function(child) {
            return child.height === root.height && child.width === root.width && child.visible;
        });
        return visibleChildren[visibleChildren.length - 1]
    }

    function applyEffects() {
        var blurSource = findBlurSource(wallpaperItem, rootItem)
        blurItem = blurComponent.createObject(
            wallpaperItem,
            {
                "target": blurSource
            }
        )
        roundedItem = roundedComponent.createObject(
            wallpaperItem,
            { 
                "target" : wallpaperItem,
                "root":rootItem
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
