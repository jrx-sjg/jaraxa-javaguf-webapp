if (guf.isDefined("gufpopup") && guf.isDefined("opener.guf.electron")) {
	window.guf.electron = window.opener.guf.electron;
} else {
	guf.electron = {};
	guf.electron.init = function(config) {
		if (guf.device.isApp) {
			guf.electron = {};
			var autoLaunchCheckbox = null;

			function autoLaunchToggle(menuItem, browserWindow, event) {
				guf.electron.ipc.send('autolaunch-toggle', menuItem.checked);
			}

			function quitApp(menuItem, browserWindow, event) {
				guf.electron.ipc.send('window-command', {type: 'quit'});
			}

			guf.electron.setBadgeCount = function(badge) {
				guf.electron.ipc.send('badge-count', badge);
			}

			function initializeAutoLaunch() {
				try {
					guf.electron.ipc.on('autolaunch-msg', function(event, data) {
						if (autoLaunchCheckbox) {
							switch (data.type) {
								case "error":
									autoLaunchCheckbox.enabled = false;
									break;
								case "status":
									autoLaunchCheckbox.checked = data.status;
									break;
							}
						}
					});
					guf.electron.ipc.send('autolaunch-init');
				} catch (e) {
					console.error(e);
				}
			}

			try {
				guf.electron.ipc = require('electron').ipcRenderer;
				var osVersionString = require('os').release();
				var app = require('electron').remote.app;
				guf.electron.appPath = app.getAppPath();
				var firstDot = osVersionString.indexOf('.');
				if (firstDot != -1) {
					osVersionString = osVersionString.substring(0,firstDot);
				}
				guf.electron.osVersion = parseInt(osVersionString,10);
				if (guf.device.isWindows) {
					/* Tray icon only in Windows at the moment */
					var Tray = require('electron').remote.Tray;
					var Menu = require('electron').remote.Menu;
					guf.electron.tray = new Tray(guf.electron.appPath + config.tray.image);
					guf.electron.tray.setToolTip(config.tray.title);
					var contextMenu = Menu.buildFromTemplate([
						{id: 'autolaunch', label: guf.i18n.get("guf.launch_on_startup"), type: 'checkbox', click: autoLaunchToggle},
						{type: 'separator'},
						{id: 'quit', label: guf.i18n.get("guf.quit"), type: 'normal', click: quitApp}
					]);
					for (var i=0; i < contextMenu.items.length; i++) {
						if (contextMenu.items[i].id == 'autolaunch') {
							autoLaunchCheckbox = contextMenu.items[i];
						}
					}
					guf.electron.tray.setContextMenu(contextMenu);
					guf.electron.tray.on('double-click', function() {
						guf.electron.ipc.send('window-command', {type: 'show'});
					});
					initializeAutoLaunch();
				}
				guf.electron.ipc.on('window-status', function(event, data) {
					var status = data.status;
					guf.console.log("window-status electron event: ", data);
					switch (status) {
						case "show":
							guf.trigger("show");
							break;
						case "hide":
							guf.trigger("hide");
							break;
						default:
							guf.console.warn("window-status electron event '" + data + "' is not handled");
							break;
					}
				});
			} catch (e) {
				console.error(e);
			}			
		}
	};
}