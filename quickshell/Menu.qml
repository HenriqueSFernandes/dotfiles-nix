import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "MenuModel.js" as MenuModel

Rectangle {
  id: root

  implicitWidth: 520
  implicitHeight: Math.min(contentLayout.implicitHeight + 32, 640)
  color: Colors.panelBackground
  radius: 24
  border.color: Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.35)
  border.width: 1

  property bool opened: true
  property string filterText: ""
  property string activeMenu: "root"
  property var navStack: []
  property var items: ({})
  property var itemOrder: []
  property int selectedIndex: 0
  property bool appRowsLoaded: false
  property bool emojiRowsLoaded: false
  property var emojiList: []
  property var appUsage: ({})
  property bool windowsRowsLoaded: false
  property bool clipboardRowsLoaded: false
  property bool processRowsLoaded: false

  signal closed()

  onOpenedChanged: {
    if (opened) {
      root.openRoute("root");
      filterInput.forceActiveFocus();
    }
  }

  function item(id) {
    return root.items[id] || null;
  }

  function activeItem() {
    return item(root.activeMenu) || item("root") || {
      id: "root",
      parent: "",
      kind: "menu",
      icon: "",
      iconFont: "",
      label: "Menu",
      title: "",
      target: "",
      description: "",
      action: "",
      provider: "",
      aliases: [],
      order: 0
    };
  }

  function clearFilter() {
    root.filterText = "";
    if (filterInput) filterInput.text = "";
  }

  function openRoute(route) {
    var resolved = MenuModel.resolveRoute(root.items, root.itemOrder, route);
    var entry = item(resolved);
    if (!entry) resolved = "root";
    root.navStack = [];
    root.activeMenu = resolved;
    root.clearFilter();
    root.selectedIndex = 0;
    root.rebuildDisplay();
    root.loadProviderForMenu(resolved);
  }

  function goBack() {
    if (root.filterText !== "") {
      root.clearFilter();
      root.selectedIndex = 0;
      root.rebuildDisplay();
      return;
    }
    var current = item(root.activeMenu);
    if (!current || current.id === "root") {
      root.closed();
      return;
    }
    root.activeMenu = current.parent || "root";
    root.selectedIndex = 0;
    root.rebuildDisplay();
  }

  function runAction(command) {
    if (!command) return;
    actionProcess.command = ["bash", "-lc", command];
    actionProcess.running = true;
    root.closed();
  }

  function usageCount(appId) {
    return root.appUsage[appId] || 0;
  }

  function recordUsage(appId) {
    if (!appId) return;
    var next = {};
    for (var k in root.appUsage) next[k] = root.appUsage[k];
    next[appId] = (next[appId] || 0) + 1;
    root.appUsage = next;
    usageProcess.appId = appId;
    usageProcess.running = true;
  }

  function launchApp(appId) {
    var appEntry = DesktopEntries.byId(appId);
    if (appEntry) {
      appEntry.execute();
    } else {
      console.warn("Desktop entry not found:", appId);
    }
    root.recordUsage(appId);
    root.closed();
  }

  function activateRow(row) {
    if (!row) return;
    var entry = item(row.itemId);
    if (!entry) return;

    if (entry.kind === "menu" || entry.kind === "link") {
      var target = entry.kind === "link" ? entry.target : entry.id;
      root.navStack = root.navStack.concat([root.activeMenu]);
      root.activeMenu = target;
      root.clearFilter();
      root.selectedIndex = 0;
      root.loadProviderForMenu(target);
      root.rebuildDisplay();
    } else if (entry.kind === "app") {
      root.launchApp(entry.appId);
    } else if (entry.kind === "window") {
      root.runAction("hyprctl dispatch focuswindow address:" + entry.windowAddress);
    } else if (entry.kind === "clipboard") {
      root.runAction("cliphist decode " + entry.clipboardIndex + " | wl-copy");
    } else if (entry.kind === "process") {
      root.runAction("kill -9 " + entry.processPid);
    } else if (entry.kind === "emoji") {
      root.runAction("printf '%s' " + MenuModel.shellQuote(entry.action) + " | wl-copy");
    } else if (entry.action) {
      root.runAction(entry.action);
    }
  }

  function isMathExpression(query) {
    return /^[0-9+\-*/().\s%^]+$/.test(query) && /[0-9]/.test(query);
  }

  function evalMath(query) {
    try {
      // eslint-disable-next-line no-eval
      return eval(query);
    } catch (e) {
      return null;
    }
  }

  function buildDisplayRows() {
    var rows = [];
    var query = root.filterText.trim();

    if (query) {
      if (root.isMathExpression(query)) {
        var result = root.evalMath(query);
        if (result !== null && !Number.isNaN(result)) {
          var resultText = String(result);
          rows.push({
            itemId: "__calculator",
            kind: "action",
            icon: "󰃬",
            iconFont: "",
            appIcon: "",
            appId: "",
            label: resultText,
            target: "",
            detail: query + " = " + resultText,
            path: "",
            childCount: 0,
            action: "printf '%s' " + MenuModel.shellQuote(resultText) + " | wl-copy",
            provider: "",
            score: -10000,
            section: "calculator"
          });
        }
      }
      for (var i = 0; i < root.itemOrder.length; i++) {
        var entry = item(root.itemOrder[i]);
        if (!entry || entry.id === "root") continue;
        if (entry.kind === "emoji") continue;
        if (!MenuModel.matchesQuery(entry, query)) continue;
        var score = MenuModel.searchScore(root.items, entry, query);
        if (entry.kind === "app") score -= root.usageCount(entry.appId) * 100;
        rows.push(MenuModel.displayRow(root.items, root.itemOrder, entry, entry.description, score, "search"));
      }
      rows.sort(function (a, b) { return a.score - b.score; });
    } else {
      var isAppsMenu = activeItem().provider === "apps" || root.activeMenu === "apps";
      for (var j = 0; j < root.itemOrder.length; j++) {
        var child = item(root.itemOrder[j]);
        if (!child) continue;
        if (child.parent !== root.activeMenu) continue;
        rows.push(MenuModel.displayRow(root.items, root.itemOrder, child, child.description, 0, "drilldown"));
      }
      if (isAppsMenu) {
        rows.sort(function (a, b) {
          var ua = root.usageCount(a.appId);
          var ub = root.usageCount(b.appId);
          if (ua !== ub) return ub - ua;
          return a.label.toLowerCase().localeCompare(b.label.toLowerCase());
        });
      }
    }

    return rows;
  }

  function rebuildDisplay() {
    displayModel.clear();
    var rows = buildDisplayRows();
    for (var i = 0; i < rows.length; i++) {
      displayModel.append(rows[i]);
    }
    root.selectedIndex = rows.length > 0 ? 0 : -1;
  }

  function loadProviderForMenu(id) {
    var entry = item(id);
    if (!entry || !entry.provider) return;
    if (entry.provider === "apps") root.mergeAppRows();
    if (entry.provider === "emoji" && !root.emojiRowsLoaded) root.mergeEmojiRows();
    if (entry.provider === "windows" && !root.windowsRowsLoaded) windowsProcess.running = true;
    if (entry.provider === "clipboard" && !root.clipboardRowsLoaded) clipboardProcess.running = true;
    if (entry.provider === "processes" && !root.processRowsLoaded) processProcess.running = true;
  }

  function mergeAppRows() {
    var apps = DesktopEntries.applications.values;
    if (!apps || apps.length === 0) return;

    var appRows = [];
    for (var i = 0; i < apps.length; i++) {
      var app = apps[i];
      if (!app || !app.id) continue;
      var aliases = [];
      if (app.genericName) aliases.push(app.genericName);
      if (app.keywords && typeof app.keywords.join === "function") aliases = aliases.concat(app.keywords);
      appRows.push({
        id: "apps." + app.id,
        parent: "apps",
        kind: "app",
        icon: "",
        iconFont: "",
        appIcon: app.icon || "",
        appId: app.id,
        label: app.name || app.id,
        title: "",
        target: "",
        description: app.comment || app.genericName || "",
        action: "",
        provider: "",
        aliases: aliases,
        order: 0
      });
    }
    var merged = MenuModel.mergeAppRows(root.items, root.itemOrder, appRows);
    root.items = merged.items;
    root.itemOrder = merged.itemOrder;
    root.appRowsLoaded = true;
    if (root.opened) root.rebuildDisplay();
  }

  function mergeEmojiRows() {
    if (root.emojiRowsLoaded) return;
    var list = root.emojiList || [];

    var emojiRows = [];
    var takenIds = {};
    for (var i = 0; i < list.length; i++) {
      var em = list[i];
      if (!em || !em.e) continue;
      var baseId = "trigger.emoji." + MenuModel.slugify(em.k || em.e);
      var rowId = baseId;
      while (takenIds[rowId]) rowId += "-";
      takenIds[rowId] = true;

      emojiRows.push({
        id: rowId,
        parent: "trigger.emoji",
        kind: "emoji",
        icon: em.e,
        iconFont: "",
        appIcon: "",
        appId: "",
        label: em.e,
        title: "",
        target: "",
        description: em.k || "",
        action: em.e,
        provider: "",
        aliases: (em.k || "").split(/\s+/),
        order: i
      });
    }

    var merged = MenuModel.mergeAppRows(root.items, root.itemOrder, emojiRows);
    root.items = merged.items;
    root.itemOrder = merged.itemOrder;
    root.emojiRowsLoaded = true;
    if (root.opened) root.rebuildDisplay();
  }

  function mergeWindowRows(clients) {
    clients = clients || [];
    var windowRows = [];
    for (var i = 0; i < clients.length; i++) {
      var w = clients[i];
      if (!w || !w.address) continue;
      var cls = w.class || w.initialClass || "";
      var title = w.title || "";
      var label = title || cls || w.address;
      var description = cls && title !== cls ? cls : "";
      windowRows.push({
        id: "windows." + w.address,
        parent: "windows",
        kind: "window",
        icon: "",
        iconFont: "",
        appIcon: cls,
        appId: "",
        label: label,
        title: "",
        target: "",
        description: description,
        action: "",
        provider: "",
        aliases: [cls, title].filter(function (v) { return v; }),
        order: 0,
        windowAddress: w.address
      });
    }
    var merged = MenuModel.mergeAppRows(root.items, root.itemOrder, windowRows);
    root.items = merged.items;
    root.itemOrder = merged.itemOrder;
    root.windowsRowsLoaded = true;
    if (root.opened) root.rebuildDisplay();
  }

  function mergeClipboardRows(text) {
    var lines = String(text || "").split("\n");
    var rows = [];
    var seen = {};
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      if (!line) continue;
      var tab = line.indexOf("\t");
      if (tab < 0) continue;
      var idx = line.substring(0, tab).trim();
      var content = line.substring(tab + 1);
      if (!content || seen[idx] || content.indexOf("[[ binary data") >= 0) continue;
      seen[idx] = true;
      var preview = content.length > 80 ? content.substring(0, 80) + "…" : content;
      rows.push({
        id: "clipboard." + idx,
        parent: "clipboard",
        kind: "clipboard",
        icon: "󰅌",
        iconFont: "",
        appIcon: "",
        appId: "",
        label: preview,
        title: "",
        target: "",
        description: "Clipboard entry",
        action: "",
        provider: "",
        aliases: content.split(/\s+/),
        order: 0,
        clipboardIndex: idx,
        clipboardContent: content
      });
    }
    var merged = MenuModel.mergeAppRows(root.items, root.itemOrder, rows);
    root.items = merged.items;
    root.itemOrder = merged.itemOrder;
    root.clipboardRowsLoaded = true;
    if (root.opened) root.rebuildDisplay();
  }

  function mergeProcessRows(text) {
    var lines = String(text || "").split("\n");
    var rows = [];
    var seen = {};
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i].trim();
      if (!line) continue;
      var m = line.match(/^(\d+)\s+(\S+)(?:\s+(.*))?$/);
      if (!m) continue;
      var pid = parseInt(m[1], 10);
      var comm = m[2];
      var args = m[3] || "";
      if (seen[pid] || pid < 50 || args.indexOf("[") === 0) continue;
      seen[pid] = true;
      var label = comm;
      var detail = args ? "pid " + pid + " — " + args : "pid " + pid;
      rows.push({
        id: "processes." + pid,
        parent: "processes",
        kind: "process",
        icon: "󰓅",
        iconFont: "",
        appIcon: "",
        appId: "",
        label: label,
        title: "",
        target: "",
        description: detail,
        action: "",
        provider: "",
        aliases: [comm, args].filter(function (v) { return v; }),
        order: 0,
        processPid: pid
      });
    }
    rows.sort(function (a, b) { return a.label.toLowerCase().localeCompare(b.label.toLowerCase()); });
    var merged = MenuModel.mergeAppRows(root.items, root.itemOrder, rows);
    root.items = merged.items;
    root.itemOrder = merged.itemOrder;
    root.processRowsLoaded = true;
    if (root.opened) root.rebuildDisplay();
  }

  function nextSelectable(direction) {
    var count = displayModel.count;
    if (count === 0) return -1;
    return (root.selectedIndex + direction + count) % count;
  }

  Component.onCompleted: {
    root.openRoute("root");
  }

  FileView {
    id: menuFile
    path: Quickshell.shellDir + "/menu.jsonc"
    watchChanges: true
    onLoaded: {
      var parsed = MenuModel.parseMenuJsonc(text());
      var merged = MenuModel.mergeMenuSources(parsed, []);
      root.items = merged.items;
      root.itemOrder = merged.itemOrder;
      root.appRowsLoaded = false;
      root.emojiRowsLoaded = false;
      root.windowsRowsLoaded = false;
      root.clipboardRowsLoaded = false;
      root.processRowsLoaded = false;
      root.mergeAppRows();
      root.openRoute(root.activeMenu);
    }
  }

  FileView {
    id: emojiFile
    path: Quickshell.shellDir + "/emojis.json"
    watchChanges: true
    onLoaded: {
      try {
        root.emojiList = JSON.parse(text() || "[]");
      } catch (e) {
        console.warn("Failed to parse emojis.json:", e);
        root.emojiList = [];
      }
      root.emojiRowsLoaded = false;
    }
  }

  FileView {
    id: usageFile
    path: (Quickshell.env("XDG_STATE_HOME") || Quickshell.env("HOME") + "/.local/state") + "/ricky-menu/app-usage.json"
    watchChanges: true
    printErrors: false
    onLoaded: {
      try {
        root.appUsage = JSON.parse(text() || "{}");
      } catch (e) {
        root.appUsage = ({});
      }
      if (root.opened) root.rebuildDisplay();
    }
  }

  Connections {
    target: DesktopEntries
    function onApplicationsChanged() {
      root.mergeAppRows();
    }
  }

  Process {
    id: actionProcess
  }

  Process {
    id: usageProcess
    property string appId: ""
    command: ["bash", Quickshell.shellDir + "/record-usage.sh", appId]
  }

  Process {
    id: windowsProcess
    command: ["bash", "-lc", "hyprctl clients -j"]
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          var clients = JSON.parse(text || "[]");
          root.mergeWindowRows(clients);
        } catch (e) {
          console.warn("Failed to parse hyprctl clients:", e);
        }
      }
    }
  }

  Process {
    id: clipboardProcess
    command: ["bash", "-lc", "cliphist list"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.mergeClipboardRows(text || "");
      }
    }
  }

  Process {
    id: processProcess
    command: ["bash", "-lc", "ps -eo pid=,comm=,args="]
    stdout: StdioCollector {
      onStreamFinished: {
        root.mergeProcessRows(text || "");
      }
    }
  }

  ListModel {
    id: displayModel
  }

  // --- layout ----------------------------------------------------------------

  ColumnLayout {
    id: contentLayout
    anchors.fill: parent
    anchors.margins: 16
    spacing: 16

    // --- main content ---------------------------------------------------------
    ColumnLayout {
      id: mainContent
      Layout.fillWidth: true
      Layout.fillHeight: true
      spacing: 16

      // header
      RowLayout {
        Layout.fillWidth: true
        spacing: 8

        Rectangle {
            visible: root.activeMenu !== "root" || root.filterText !== ""
            implicitWidth: 32
            implicitHeight: 32
            radius: 8
            color: Colors.inputBackground
            opacity: 0.6

            Text {
              anchors.centerIn: parent
              text: "‹"
              color: Colors.foreground
              font.pointSize: 16
            }

            MouseArea {
              anchors.fill: parent
              onClicked: root.goBack()
            }
          }

        ColumnLayout {
          Layout.fillWidth: true
          spacing: 0

          Text {
            text: root.filterText.trim() !== "" ? "Search results" : (activeItem().title || activeItem().label || "Menu")
            color: Colors.foreground
            font.pointSize: 16
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
          }

          Text {
            property string crumb: MenuModel.pathFor(root.items, root.activeMenu)
            visible: root.activeMenu !== "root" && root.filterText.trim() === "" && crumb !== (activeItem().title || activeItem().label)
            text: crumb
            color: Colors.muted
            font.pointSize: 9
            elide: Text.ElideRight
            Layout.fillWidth: true
          }
        }

        Text {
          text: activeItem().icon || "󰍜"
          color: Colors.accent
          font.pointSize: 20
          font.family: "FiraCode Nerd Font Mono"
          Layout.alignment: Qt.AlignVCenter
        }
      }

      // search
      Rectangle {
        Layout.fillWidth: true
        implicitHeight: 44
        color: Colors.inputBackground
        radius: 12

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: 14
          anchors.rightMargin: 14
          spacing: 10

          Text {
            text: "󰍉"
            color: Colors.placeholder
            font.pointSize: 13
            font.family: "FiraCode Nerd Font Mono"
            Layout.alignment: Qt.AlignVCenter
          }

          Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            TextInput {
              id: filterInput
              anchors.fill: parent
              verticalAlignment: TextInput.AlignVCenter
              color: Colors.foreground
              font.pointSize: 12
              focus: true
              cursorVisible: true
              selectByMouse: true
              onTextChanged: {
                root.filterText = text;
                root.selectedIndex = 0;
                root.rebuildDisplay();
              }
              Keys.onUpPressed: {
                root.selectedIndex = root.nextSelectable(-1);
                event.accepted = true;
              }
              Keys.onDownPressed: {
                root.selectedIndex = root.nextSelectable(1);
                event.accepted = true;
              }
              Keys.onReturnPressed: {
                if (root.selectedIndex >= 0 && root.selectedIndex < displayModel.count) {
                  root.activateRow(displayModel.get(root.selectedIndex));
                }
                event.accepted = true;
              }
              Keys.onEscapePressed: {
                root.goBack();
                event.accepted = true;
              }
              Keys.onPressed: event => {
                if (event.key === Qt.Key_Backspace && filterInput.text === "") {
                  root.goBack();
                  event.accepted = true;
                }
              }
            }

            Text {
              anchors.fill: parent
              verticalAlignment: Text.AlignVCenter
              text: "Search apps, actions…"
              color: Colors.placeholder
              font.pointSize: 12
              visible: filterInput.text === ""
            }
          }
        }
      }

      // results list
      ListView {
        id: listView
        visible: displayModel.count > 0
        Layout.fillWidth: true
        Layout.fillHeight: true
        implicitHeight: Math.min(contentHeight, 420)
        model: displayModel
        clip: true
        currentIndex: root.selectedIndex
        onCurrentIndexChanged: root.selectedIndex = currentIndex
        spacing: 4

        delegate: Rectangle {
          required property int index
          required property string itemId
          required property string kind
          required property string icon
          required property string iconFont
          required property string appIcon
          required property string appId
          required property string label
          required property string target
          required property string detail
          required property string path
          required property int childCount
          required property string action
          required property string provider

          property bool isSelected: index === root.selectedIndex

          width: ListView.view.width
          height: rowLayout.implicitHeight + 18
          color: isSelected ? Colors.selectedBackground : "transparent"
          radius: 10

          Behavior on color { ColorAnimation { duration: 100 } }

          Rectangle {
            visible: isSelected
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 4
            color: Colors.accent
            radius: 2
          }

          MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
              root.selectedIndex = index;
              if (!isSelected) parent.color = Colors.hoverBackground;
            }
            onExited: {
              if (!isSelected) parent.color = "transparent";
            }
            onClicked: root.activateRow(displayModel.get(index))
          }

          RowLayout {
            id: rowLayout
            anchors.fill: parent
            anchors.margins: 8
            anchors.leftMargin: 14
            anchors.rightMargin: 14
            spacing: 12

            Rectangle {
              visible: icon !== "" || appIcon !== ""
              Layout.preferredWidth: 28
              Layout.preferredHeight: 28
              color: isSelected ? Qt.rgba(Colors.accent.r, Colors.accent.g, Colors.accent.b, 0.15) : Colors.inputBackground
              radius: 8

              Behavior on color { ColorAnimation { duration: 100 } }

              Text {
                anchors.centerIn: parent
                visible: icon !== ""
                text: icon
                color: isSelected ? Colors.accent : Colors.foreground
                font.pointSize: 13
                font.family: iconFont || "FiraCode Nerd Font Mono"
              }

              Loader {
                anchors.centerIn: parent
                active: appIcon !== ""
                sourceComponent: IconImage {
                  source: Quickshell.iconPath(appIcon)
                  implicitSize: 18
                }
              }
            }

            ColumnLayout {
              Layout.fillWidth: true
              spacing: 1

              Text {
                text: label
                color: isSelected ? Colors.selectedForeground : Colors.foreground
                font.pointSize: 12
                font.bold: isSelected
                elide: Text.ElideRight
                Layout.fillWidth: true
              }

              Text {
                visible: detail !== ""
                text: detail
                color: isSelected ? Colors.subtext1 : Colors.detailText
                font.pointSize: 9
                elide: Text.ElideRight
                Layout.fillWidth: true
              }
            }

            Text {
              visible: (kind === "menu" || kind === "link") && childCount > 0
              text: "›"
              color: isSelected ? Colors.accent : Colors.detailText
              font.pointSize: 16
              Layout.alignment: Qt.AlignVCenter
            }
          }
        }
      }

      Item {
        visible: displayModel.count === 0
        Layout.fillWidth: true
        Layout.fillHeight: true

        ColumnLayout {
          anchors.centerIn: parent
          spacing: 6

          Text {
            text: "󰍉"
            color: Colors.placeholder
            font.pointSize: 28
            font.family: "FiraCode Nerd Font Mono"
            Layout.alignment: Qt.AlignHCenter
          }

          Text {
            text: root.filterText !== "" ? "No results for \"" + root.filterText + "\"" : "No items"
            color: Colors.placeholder
            font.pointSize: 12
            Layout.alignment: Qt.AlignHCenter
          }
        }
      }

      // footer hints
      RowLayout {
        Layout.fillWidth: true
        spacing: 12

        Text {
          text: "↑↓ navigate"
          color: Colors.placeholder
          font.pointSize: 9
        }

        Text {
          text: "·"
          color: Colors.placeholder
          font.pointSize: 9
        }

        Text {
          text: "↵ activate"
          color: Colors.placeholder
          font.pointSize: 9
        }

        Text {
          text: "·"
          color: Colors.placeholder
          font.pointSize: 9
        }

        Text {
          text: "Esc back"
          color: Colors.placeholder
          font.pointSize: 9
        }

        Item { Layout.fillWidth: true }

        Text {
          text: displayModel.count + " items"
          color: Colors.placeholder
          font.pointSize: 9
        }
      }
    }
  }
}
