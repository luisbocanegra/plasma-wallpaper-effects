/*
 *  Copyright 2018 Rog131 <samrog131@hotmail.com>
 *  Copyright 2019 adhe   <adhemarks2@gmail.com>
 *  Copyright 2024 Luis Bocanegra <luisbocanegra17b@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick
import org.kde.taskmanager 0.1 as TaskManager

Item {

    id: wModel
    property var screenGeometry
    property int blurMode: plasmoid.configuration.BlurMode
    property int grainMode: plasmoid.configuration.GrainMode
    property bool showBlur: false
    property bool showGrain: false
    property int colorEffectsMode: plasmoid.configuration.colorEffectsMode
    property bool showColorEffects: false
    property bool maximizedExists: false
    property bool visibleExists: false
    property bool activeExists: false
    property var abstractTasksModel: TaskManager.AbstractTasksModel
    property var isMaximized: abstractTasksModel.IsMaximized
    property var isActive: abstractTasksModel.IsActive
    property var isWindow: abstractTasksModel.IsWindow
    property var isFullScreen: abstractTasksModel.IsFullScreen
    property var isMinimized: abstractTasksModel.IsMinimized
    property bool activeScreenOnly: plasmoid.configuration.CheckActiveScreen

    Connections {
        target: plasmoid.configuration
        function onValueChanged() {
            updateWindowsinfo()
        }
    }

    function updateBlur() {
        let shouldBlur = true
        switch(blurMode) {
            case 0:
                shouldBlur = maximizedExists
                break
            case 1:
                shouldBlur = activeExists
                break
            case 2:
                shouldBlur = visibleExists
                break
            case 3:
                shouldBlur = true
                break
            case 4:
                shouldBlur = false
        }
        showBlur = shouldBlur
    }

    function updateGrain() {
        let shouldGrain = true
        switch(grainMode) {
            case 0:
                shouldGrain = maximizedExists
                break
            case 1:
                shouldGrain = activeExists
                break
            case 2:
                shouldGrain = visibleExists
                break
            case 3:
                shouldGrain = true
                break
            case 4:
                shouldGrain = false
        }
        showGrain = shouldGrain
    }

    function updateColorEffect() {
        let show = true
        switch(colorEffectsMode) {
            case 0:
                show = maximizedExists
                break
            case 1:
                show = activeExists
                break
            case 2:
                show = visibleExists
                break
            case 3:
                show = true
                break
            case 4:
                show = false
        }
        showColorEffects = show
    }

    TaskManager.VirtualDesktopInfo {
        id: virtualDesktopInfo
    }

    TaskManager.ActivityInfo {
        id: activityInfo
        readonly property string nullUuid: "00000000-0000-0000-0000-000000000000"
    }

    TaskManager.TasksModel {
        id: tasksModel
        sortMode: TaskManager.TasksModel.SortVirtualDesktop
        groupMode: TaskManager.TasksModel.GroupDisabled
        virtualDesktop: virtualDesktopInfo.currentDesktop
        activity: activityInfo.currentActivity
        screenGeometry: wModel.screenGeometry
        filterByVirtualDesktop: true
        filterByScreen: activeScreenOnly
        filterByActivity: true
        filterMinimized: true

        onActiveTaskChanged: {
            updateWindowsinfo()
        }
        onDataChanged: {
            updateWindowsinfo()
        }
        onCountChanged: {
            updateWindowsinfo()
        }
    }

    function updateWindowsinfo() {
        let activeCount = 0
        let visibleCount = 0
        let maximizedCount = 0
        for (var i = 0; i < tasksModel.count; i++) {
            const currentTask = tasksModel.index(i, 0)
            if (currentTask === undefined) continue
            if (tasksModel.data(currentTask, isWindow) && !tasksModel.data(currentTask, isMinimized)) {
                visibleCount+=1
                if (tasksModel.data(currentTask, isMaximized) || tasksModel.data(currentTask, isFullScreen)) maximizedCount+=1
                if (tasksModel.data(currentTask, isActive)) activeCount+=1
            }
        }

        visibleExists = visibleCount > 0
        maximizedExists = maximizedCount > 0
        activeExists = activeCount > 0
        updateBlur()
        updateGrain()
        updateColorEffect()
    }
}

