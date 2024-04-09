import QtCore
import QtQuick
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects

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

    Plasmoid.backgroundHints: {
        if ((main.inEditMode || main.widgetConfiguring) || !hideWidget) {
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
    }

    function cleanupEffects() {
        if (blurItem) blurItem.destroy()
    }

    onWallpaperPluginNameChanged: {
        if (!isLoaded) return
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
