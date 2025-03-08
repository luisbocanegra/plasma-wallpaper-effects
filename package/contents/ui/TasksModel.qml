import QtQuick
import org.kde.taskmanager 0.1 as TaskManager

Item {

    id: model
    property var screenGeometry

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
        screenGeometry: model.screenGeometry
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
    }
}

