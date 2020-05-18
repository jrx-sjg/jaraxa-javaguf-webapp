if (guf.isDefined("gufpopup") && guf.isDefined("opener.guf.console")) {
	guf.console = window.opener.guf.console;
} else {
	(function(){
		function Level(name, id, method, fgColor, bgColor) {
			this.name = name;
			this.id = id;
			this.method = method;
			this.fgColor = fgColor;
			this.bgColor = bgColor;
		}

		Level.prototype.css = function() {
			return "background-color: " + this.bgColor + "; color:" + this.fgColor;
		}

		var OFF = new Level('OFF', 0, null, "", "");
		var ALERT = new Level('ALERT', 1, "error", "White", "Purple");
		var CRITICAL = new Level('CRITICAL', 2, "error", "White", "DarkRed");
		var ERROR = new Level('ERROR', 3, "error", "White", "#ee0000");
		var WARN = new Level('WARN', 4, "warn", "Black", "Orange");
		var INFO = new Level('INFO', 5, "info", "Black", "LightSeaGreen");
		var LOG = new Level('LOG', 6, "log", "Black", "LightSkyBlue");
		var DEBUG = new Level('DEBUG', 7, "log", "Black", "Lavender");

		var STACKTRACE_REGEXP = /^(\S*)\s\(?(.*):(\d+):(\d+)\)?$/i;
		var STACKTRACE_NO_PLACE_REGEXP = /^(.*):(\d+):(\d+)$/i;
		var locationPrefix = null;

		function Console() {
			var self = this;
			this.stackedLogs = [];
			this.localLevel = DEBUG;
			this.remoteLevel = OFF;
			this.showLevel = false;
			this.stacktraceLocalLevel = ERROR;
			this.showTime = false;
			this.meta = {};
			guf.on('guf-loaded',function() {
				if (guf.isDefined('guf.websocket')) {
					guf.websocket.on('onWsOpen',function(){
						for (var i = 0; i < self.stackedLogs.length; i++) {
							guf.websocket.sendMessage("log", self.stackedLogs[i], function(result){
							});
						}
						self.stackedLogs = [];
					});
				}
			});
		}

		function resetCss() {
			return "background-color:inherit; color:inherit";
		}

		function calculateLocationPrefix() {
			if (locationPrefix == null) {
				locationPrefix = window.location.protocol + "//" + window.location.host + window.location.pathname;
			}
		}

		function flattenize(subtree, name, target, seen) {
			switch (typeof(subtree)) {
				case "string":
				case "number":
				case "boolean":
					target[name] = subtree;
					break;
				case "function":
					// Just ignore
					break;
				case "object":
					subtree = JSON.parse(JSON.prune(subtree));
					for (var prop in subtree) {
						var fullname = (name != "" ? name + "_" + prop : prop);
						flattenize(subtree[prop], fullname, target, seen);
					}
					break;
				case "array":
					for (var i = 0; i < subtree.length; i++) {
						var fullname = name + "-" + i;
						flattenize(subtree[i], fullname, target, seen);	 
					}
					break;
				default:
					console.error("Invalid field type '" + typeof(subtree) + "' found for " + name + " field in tree");
					break;
			}
		}

		function padLeft(nr, n, str){
			return Array(n-String(nr).length+1).join(str||'0')+nr;
		}

		Console.prototype.commonLog = function(level, args) {
			var theStack = new Error();
			var stackArray = new Array();
			var stackString = "";
			var hasAdditionalMeta = args.length > 0 && typeof(args[0]) == "object";
			var additionalMeta = {};
			args = Array.from(args);
			if (hasAdditionalMeta) {
				additionalMeta = args[0];
				args = args.slice(1);
			}

			calculateLocationPrefix();
			if ( ! theStack.stack ) {
				try {
					// IE requires the Error to actually be throw or else the Error's 'stack' property is undefined.
					throw theStack;
				} catch (otherStack) {
					if (otherStack.stack) {
						theStack = otherStack;
					}
				}
			}
			if (theStack.stack) {
				stackArray = theStack.stack.replace(/^\s+at\s+/gm, '')
					.replace(/\@/gm, ' ')
					.replace(/^Object.<anonymous>\s*\(/gm, '{anonymous}()@')
					.split(/\r\n|\n/);
				var removedConsole = false;
				while (!removedConsole && stackArray.length > 0) {
					if (stackArray[0].indexOf("Console.") == 0 || stackArray[0].trim() === "Error") {
						stackArray.shift();
					} else {
						removedConsole = true;
					}
				}
				for (var i=0; i<stackArray.length; i++) {
					if (stackArray[i].trim().length != 0) {
						try {
							var result = null;
							result = STACKTRACE_REGEXP.exec(stackArray[i]);
							if (result == null) {
								result = STACKTRACE_NO_PLACE_REGEXP.exec(stackArray[i]);
								if (result != null) {
									result.splice(1,0,"");
								}
							}
							var place = result[1];
							var file = result[2];
							var line = result[3];
							var character = result[4];
							if (file.indexOf(locationPrefix) == 0) {
								file = file.substring(locationPrefix.length);
							}
							if (place == "") {
								place = file;
							}
							stackString += (i != 0 ? "\n" : "") + place + "\t" + file + " (line " + line + ", character " + character + ")";
						} catch (e) {}
					}
				}
			}
			// Local stuff
			if (level.id <= this.localLevel.id) {
				var newArgs = Array.from(args);
				var firstArg = newArgs[0];
				var message = "";
				var firstArgIsString = (typeof(firstArg) === "string");

				if (this.showLevel || level.id <= this.stacktraceLocalLevel.id) {
					message += "%c[" + level.name + "]%c ";
				}
				if (this.showTime) {
					var now = new Date(); 
					message += padLeft(now.getHours(),2,'0') + ":"
						+ padLeft(now.getMinutes(),2,'0') + ":"
						+ padLeft(now.getSeconds(),2,'0') + "."
						+ padLeft(now.getMilliseconds(),3,'0') + " ";
				}
				if (firstArgIsString) {
					// String
					message += firstArg;
					newArgs[0] = message;
				} else {
					// Object
					newArgs.unshift(message);
				}
				if (this.showLevel || level.id <= this.stacktraceLocalLevel.id) {
					newArgs.splice(1,0,level.css());
					newArgs.splice(2,0,resetCss());
				}
				if (level.id <= this.stacktraceLocalLevel.id) {
					if (guf.device.normalizedName == "firefox") {
						var fn = window.console[level.method];
						if(typeof fn === "function") {
							fn.apply(window.console,newArgs);
							console.trace();
						}
					} else {
						window.console.trace.apply(window.console,newArgs);
					}
				} else {
					var fn = window.console[level.method];
					if(typeof fn === "function") {
						fn.apply(window.console,newArgs);
					}
				}
			}
			// Remote stuff
			if (level.id <= this.remoteLevel.id && guf.isDefined('guf.websocket')) {
				var firstArg = args[0];
				var firstArgIsString = (typeof(firstArg) === "string");
				var extra = firstArgIsString ? args.slice(1) : args;
				var message = firstArgIsString ? firstArg : "";
				var meta = {};
			 	flattenize(guf.extend(guf.extend(this.meta, {
					timestamp: (new Date()).toISOString(),
					stacktrace: stackString,
					extra: extra
				}), additionalMeta),"",meta);
				var data = {
					source: 'js',
					level: level.id,
					message: message,
					meta: meta
				};
				if (guf.websocket.isConnected()) {
					guf.websocket.sendMessage("log", data, function(result){
					});
				} else {
					this.stackedLogs.push(data);
				}
			}
		};

		Console.prototype.alert = function() {
			this.commonLog(ALERT, arguments);
		};

		Console.prototype.critical = function() {
			this.commonLog(CRITICAL, arguments);
		};

		Console.prototype.error = function() {
			this.commonLog(ERROR, arguments);
		};

		Console.prototype.warn = function() {
			this.commonLog(WARN, arguments);
		};

		Console.prototype.info = function() {
			this.commonLog(INFO, arguments);
		};

		Console.prototype.log = function() {
			this.commonLog(LOG, arguments);
		};

		Console.prototype.debug = function() {
			this.commonLog(DEBUG, arguments);
		};

		Console.prototype.configure = function(localLevel, remoteLevel, showLevel, stacktraceLocalLevel, showTime) {
			this.localLevel = localLevel;
			this.remoteLevel = remoteLevel;
			this.showLevel = showLevel;
			this.stacktraceLocalLevel = stacktraceLocalLevel;
			this.showTime = showTime
		}

		Console.prototype.updateMeta = function(addMeta, removeMeta) {
			if (typeof(removeMeta) !== "undefined") {
				if (removeMeta === true) {
					this.clearMeta();
				} else {
					for (var prop in removeMeta) {
						delete this.meta[prop];
					}
				}
			}
			for (var prop in addMeta) {
				this.meta[prop] = addMeta[prop];
			}
		}

		Console.prototype.clearMeta = function() {
			this.meta = {};
		}

		guf.console = new Console();
		guf.console.level = {
			OFF: OFF,
			ALERT: ALERT,
			CRITICAL: CRITICAL,
			ERROR: ERROR,
			WARN: WARN,
			INFO: INFO,
			LOG: LOG,
			DEBUG: DEBUG
		};

	})();
}