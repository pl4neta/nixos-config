pragma Singleton
import QtQuick
import Quickshell.Services.Notifications

Item {
  id: root

  property var notifications: []
  property int totalCount: 0

  NotificationServer {
    id: server
    keepOnReload: false

    onNotification: function(notif) {
      notif.tracked = true
      const app = notif.appName || "Unknown"
      const idx = root.notifications.findIndex(g => g.appName === app)

      if (idx >= 0) {
        root.notifications[idx].count += 1
      } else {
        root.notifications.push({
          appName: app,
          count: 1,
          appIcon: notif.appIcon,
        })
      }

      // force reactivity
      root.notifications = [...root.notifications]
    }
  }

  function dismissApp(appName) {
    // Close all tracked notifications for this app
    for (let i = 0; i < server.trackedNotifications.count; i++) {
      const n = server.trackedNotifications.get(i)
      if (n.appName === appName) n.close()
    }
    root.notifications = root.notifications.filter(g => g.appName !== appName)
    root.totalCount = root.notifications.reduce((sum, g) => sum + g.count, 0)
  }

  function dismissAll() {
    for (let i = 0; i < server.trackedNotifications.count; i++) {
      server.trackedNotifications.get(i).close()
    }
    root.notifications = []
    root.totalCount = 0
  }
}
