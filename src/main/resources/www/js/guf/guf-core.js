(function(){
	var autoIdCounter = 0;
    var snackbarContainerTag = null;
	guf = {};
	guf.ready = false;
	guf.timeouts = {};
	guf.intervals = {};
	riot.observable(guf);

	// Define method

	guf.define = function(obj) {
		var parts = obj.split(".");
		var currentObj = window;
		var currentObjString = '';
		for (var i = 0; i < parts.length; i++) {
			switch (typeof(currentObj[parts[i]])) {
				case "undefined":
					// Part not defined
					currentObj[parts[i]] = {};
					break;
				case "object":
					// Part already defined
					break;
				default:
					// Incompatible type
					throw "Cannot define '" + parts[i] +"' property into " + currentObjString;
			}
			currentObjString += (i > 0 ? '.' : '') + parts[i];
			currentObj = currentObj[parts[i]];
		}
	};

	guf.isDefined = function(obj, current) {
		try {
			var parts = obj.split(".");
			var currentObj = current || window;
			var currentObjString = '';
			for (var i = 0; i < parts.length; i++) {
				switch (typeof(currentObj[parts[i]])) {
					case "undefined":
						// Part not defined
						return false;
					case "object":
						if (currentObj[parts[i]] == null) {
							return false;
						}
						// Part already defined
						break;
					default:
						// Incompatible type
						return i == parts.length - 1;
				}
				currentObjString += (i > 0 ? '.' : '') + parts[i];
				currentObj = currentObj[parts[i]];
			}
			return true;
		} catch (e) {
			return false;
		}
	};

	guf.isEmptyObject = function(object, notObjectResult) {
		if (typeof(object) !== "object") {
			return typeof(notObjectResult) !== "undefined" ? notObjectResult : true;
		}
		for (var prop in object) {
			return false;
		}
		return true;
	};

	guf.getFieldValue = function(object, field) {
		var parts = field.split(".");
		var currentObj = object || window;
		var currentObjString = '';
		for (var i = 0; i < parts.length; i++) {
			switch (typeof(currentObj[parts[i]])) {
				case "undefined":
					// Part not defined
					return undefined;
				case "object":
					// Part already defined
					break;
				default:
					// Incompatible type
					if (i != parts.length - 1) {
						return undefined;
					}
			}
			currentObjString += (i > 0 ? '.' : '') + parts[i];
			currentObj = currentObj[parts[i]];
		}
		return currentObj;
	};

	guf.orderArrayByField = function(array, field, is_asc, filter) {
		var newArray = [];
		var length = array.length;
		var fieldType = "string";
		if(length) {
			for(var i = 0; i < length; i++) {
				if(array[i].hasOwnProperty(field)) {
					fieldType = typeof(array[i][field]);
					break;
				}
			}
		}
		var newLength = 0;
		var j = 0;
		for (var i = 0; i < length; i++) {
			j = 0;
			if(!filter || array[i].hasOwnProperty(field)) {
				newLength = newArray.length;
				if(fieldType === "string") {
					if (is_asc) {
						while (j < newLength && newArray[j][field].toLowerCase().localeCompare(array[i][field].toLowerCase()) <= 0) {
							j++;
						}
					} else {
						while (j < newLength && newArray[j][field].toLowerCase().localeCompare(array[i][field].toLowerCase()) >= 0) {
							j++;
						}
					}
				} else {
					if (is_asc) {
						while (j < newLength && newArray[j][field] <= array[i][field]) {
							j++;
						}
					} else {
						while (j < newLength && newArray[j][field] >= array[i][field]) {
							j++;
						}
					}
				}
				if (j >= newLength) {
					// Add at the end of the array
					newArray.push(array[i]);
				} else if(!filter || (fieldType === "string" && newArray[j][field].toLowerCase().localeCompare(array[i][field].toLowerCase()) != 0) ||
						(fieldType !== "string" && newArray[j][field] !== array[i][field])) {
					// Add at j pos
					newArray.splice(j, 0, array[i]);
				}
			}
		}
		return newArray;
	};

	guf.binaryFind = function(array, field, value, asc) {
		var minIndex = 0;
		var maxIndex = array.length - 1;
		var currentIndex;
		var currentElement;
		var length = array.length;

		if (asc === undefined || asc === null) {
			asc = true; // Ascending order by default
		}
		if(length === 0) {
			return {
				found: false,
				index: 0
			}
		}
		var fieldType = "string";
		if(length > 0) {
			for(var i = 0; i < length; i++) {
				if(array[i].hasOwnProperty(field)) {
					fieldType = typeof(array[i][field]);
					break;
				}
			}
		}
		var compareValue = value;
		if(fieldType === "string") {
			compareValue = value.toLowerCase();
		}
		while (minIndex <= maxIndex) {
			currentIndex = (minIndex + maxIndex) / 2 | 0;
			currentElement = array[currentIndex];
			guf.console.log("binaryFind step", minIndex, maxIndex, currentIndex, currentElement);
			if(fieldType === "string") {
				if (asc) {
					if (currentElement[field].toLowerCase().localeCompare(compareValue) == -1) {
						minIndex = currentIndex + 1;
					} else if (currentElement[field].toLowerCase().localeCompare(compareValue) == 1) {
						maxIndex = currentIndex - 1;
					} else {
						return { // Modification
							found: true,
							index: currentIndex
						};
					}
				} else {
					if (currentElement[field].toLowerCase().localeCompare(compareValue) == 1) {
						minIndex = currentIndex + 1;
					} else if (currentElement[field].toLowerCase().localeCompare(compareValue) == -1) {
						maxIndex = currentIndex - 1;
					} else {
						return { // Modification
							found: true,
							index: currentIndex
						};
					}					
				}
			} else {
				if (asc) {
					if (currentElement[field] < compareValue) {
						minIndex = currentIndex + 1;
					} else if (currentElement[field] > compareValue) {
						maxIndex = currentIndex - 1;
					} else {
						return { // Modification
							found: true,
							index: currentIndex
						};
					}
				} else {
					if (currentElement[field] > compareValue) {
						minIndex = currentIndex + 1;
					} else if (currentElement[field] < compareValue) {
						maxIndex = currentIndex - 1;
					} else {
						return { // Modification
							found: true,
							index: currentIndex
						};
					}					
				}
			}
		}
		if(fieldType === "string") {
			if (asc) {
				return { // Modification
					found: false,
					index: currentElement[field].toLowerCase().localeCompare(compareValue) == -1 ? currentIndex + 1 : currentIndex
				};
			} else {
				return { // Modification
					found: false,
					index: currentElement[field].toLowerCase().localeCompare(compareValue) == 1 ? currentIndex + 1 : currentIndex
				};				
			}
		} else {
			if (asc) {
				return { // Modification
					found: false,
					index: currentElement[field] < compareValue ? currentIndex + 1 : currentIndex
				};
			} else {
				return { // Modification
					found: false,
					index: currentElement[field] > compareValue ? currentIndex + 1 : currentIndex
				};				
			}
		}
	};

	// Auto ID

	guf.getAutoId = function(){
		return 'guf-' + autoIdCounter++
	};

	guf.setTimeout = function(fn, delay) {
		var timeoutId = window.setTimeout(function() {
			delete guf.timeouts[timeoutId];
			fn();
		}, delay);
		guf.timeouts[timeoutId] = fn;
		return timeoutId;
	};

	guf.clearTimeout = function(timeoutId) {
		window.clearTimeout(timeoutId);
		delete guf.timeouts[timeoutId];
	};

	guf.setInterval = function(fn, delay) {
		var timeoutId = window.setInterval(fn, delay);
		guf.intervals[timeoutId] = fn;
		return timeoutId;
	};

	guf.clearInterval = function(timeoutId) {
		window.clearInterval(timeoutId);
		delete guf.intervals[timeoutId];
	};

	guf.generateUuid = function() {
		var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
			var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
			return v.toString(16);
		});
		return uuid;
	};

	guf.arrayFill = function(O, value) {
		// Steps 1-2.
		if (O == null) {
			throw new TypeError('this is null or not defined');
		}

		// Steps 3-5.
		var len = O.length >>> 0;

		// Steps 6-7.
		var start = arguments[2];
		var relativeStart = start >> 0;

		// Step 8.
		var k = relativeStart < 0 ?
			Math.max(len + relativeStart, 0) :
			Math.min(relativeStart, len);

		// Steps 9-10.
		var end = arguments[3];
		var relativeEnd = end === undefined ?
			len : end >> 0;

		// Step 11.
		var final = relativeEnd < 0 ?
			Math.max(len + relativeEnd, 0) :
			Math.min(relativeEnd, len);

		// Step 12.
		while (k < final) {
			O[k] = value;
			k++;
		}

		// Step 13.
		return O;
	};

	// Tag parameters

	guf.param = (function(){
		return {
			boolean : function(value, defaultValue) {
				switch(typeof(value)) {
					case "boolean":
						return value;
					case "string":
						return value.toLowerCase() === 'true';
					default:
						return defaultValue;
				}
			},
			booleanExpr : function(opts, field, defaultValue) {
				switch(typeof(opts[field])) {
					case "boolean":
						return opts[field];
					case "string":
						return opts[field].toLowerCase() === 'true' || opts[field].toLowerCase() === field;
				}
				return defaultValue;
			},
			string : function(value, defaultValue) {
				switch(typeof(value)) {
					case "string":
						return value;
					case "number":
						return value.toString();
					default:
						return defaultValue;
				}				
			},
			number: function(value, defaultValue) {
				switch(typeof(value)) {
					case "string":
						return parseInt(value, 10);
					case "number":
						return value;
					default:
						return defaultValue;
				}				
			},
			float: function(value, defaultValue) {
				switch(typeof(value)) {
					case "string":
						return parseFloat(value);
					case "number":
						return value;
					default:
						return defaultValue;
				}				
			},
			numberOrString: function(value, defaultValue) {
				switch(typeof(value)) {
					case "string":
						return value;
					case "number":
						return value;
					default:
						return defaultValue;
				}				
			}
		}
	})();

	guf.extend = function(obj1,obj2){
		var obj3 = {};
		for (var attrname in obj1) { obj3[attrname] = obj1[attrname]; }
		for (var attrname in obj2) { obj3[attrname] = obj2[attrname]; }
		return obj3;
	};

	guf.ancestor = function(tag, selector) {
		if (tag && typeof(tag) === "object") {
			var match = true;
			if (typeof(selector) === "string") {
				match = tag.root.tagName.toLowerCase() == selector.toLowerCase();
			} else {
				for (var prop in selector) {
					var value = selector[prop];
					switch (prop) {
						case "ref":
							match = (tag.root.getAttribute("ref") == value);
							break;
						case "tag":
							match = (tag.root.tagName.toLowerCase() == value.toLowerCase());
							break;
					}
					if (!match) {
						break;
					}
				}
			}
			if (match) {
				return tag;
			} else {
				return guf.ancestor(guf.parent(tag), selector);
			}
		}
		return null;
	};

	guf.parent = function(tag) {
		if (tag.parent != null) {
			return tag.parent;
		} else if (tag["dynamic-parent"] != null) {
			return tag["dynamic-parent"];
		} else {
			return null;
		}
	};

	guf.appendChildTag = function(parentTag, domOrString, opts) {
		var dom = domOrString;
		var childTag = null;
		if (typeof(domOrString) === "string") {
			dom = document.createElement("div");
			dom.innerHTML = domOrString;
			dom = dom.childNodes[0];
		}
		parentTag.root.appendChild(dom);
		riot.compile(function() {
			childTag = riot.mount(dom, opts)[0];
			childTag["dynamic-parent"] = parentTag;
		});
		return childTag;
	};

	guf.tagsAsArray = function(tag) {
		var tagsArray;
		if (typeof(tag) === "undefined" || tag === null) {
			tagsArray = [];
		} else if (Array.isArray(tag)) {
			tagsArray = tag;
		} else {
			tagsArray = [tag];
		}
		return tagsArray;
	};

	guf.mount = function() {
		riot.compile(function() {
			try {
				var tags = riot.mount('*');
				guf.trigger('initial-mount', tags);
			} catch (e) {
				guf.console.error("While mounting initial tags", e);
			}
		});		
	}

	// Scrolling

	guf.disableMomentumScrolling = function (disable) {
		if (disable) document.body.classList.add("guf-momentum-disabled");
		else document.body.classList.remove("guf-momentum-disabled");
	};

	// URL parameters

	(function(){
		guf.urlParams = {};
		var params = window.location.search;
		if (params.length>0) {
			params = window.location.search.substring(1);
			var args = params.split('&');
			for (var i=0; i<args.length; i++) {
				var values = args[i];
				values = values.split('=');
				guf.urlParams[values[0]] = values.length > 1 ? values[1] : "";
			}
		}
	})();
	
	// RIOT Mixins

	riot.mixin('after-mount', {
		init: function(opts) {
			var self = this;
			this.on('mount', function() {
				guf.setTimeout(function(){
					self.trigger('after-mount');
				},0);
			});
		}
	});

	function RelayEvents() {
		function eventHandler() {
			var mainArguments = Array.prototype.slice.call(arguments);
			this.trigger.apply(this, mainArguments);
		}

		this.init = function(opts) {
			this.on("mount", function() {
				this._relayHandlers = {};
				this.relayEvents = [];
			});
		};
		this.addRelayHandlers = function(elementTag) {
			if(elementTag.relayEvents) {
				this.relayEvents = elementTag.relayEvents;
				var elemHandlers = this._relayHandlers[elementTag._riot_id];
				if(!elemHandlers) {
					elemHandlers = {};
				}
				for(var i = 0; i < elementTag.relayEvents.length; i++) {
					var currentEvent = elementTag.relayEvents[i];
					elemHandlers[currentEvent] = eventHandler.bind(this, currentEvent);
					elementTag.on(currentEvent, elemHandlers[currentEvent]);
				}
				this._relayHandlers[elementTag._riot_id] = elemHandlers;
			}
		};
		this.removeRelayHandlers = function(elementTag) {
			for(var elemId in this._relayHandlers) {
				if(elemId == elementTag._riot_id) {
					for(var event in this._relayHandlers[elemId]) {
						var handler = this._relayHandlers[elemId][event];
						elementTag.off(event, handler);
						delete this._relayHandlers[elemId][event];
					}
					delete this._relayHandlers[elemId];
					break;
				}
			}
		};
	}
	riot.mixin('relay-events', new RelayEvents());

	// Dialogs

	guf.createDialog = function(title, content, okText, nokText, okHandler, nokHandler) {
		var dialogDom = document.createElement("guf-alert");
		document.body.appendChild(dialogDom);
		var dialogTag = null;
		riot.compile(function(){
			 dialogTag = riot.mount(dialogDom, {
			 	title: title,
			 	content: content,
			 	ok: okText,
			 	nok: nokText
			 })[0];
			 dialogTag.on('ok', okHandler);
			 if (typeof(nokHandler) ===  "function") {
			 	dialogTag.on('nok', nokHandler);
			 }
		});
		return dialogTag;
	};

	guf.createHtmlDialog = function(title, content, okText, nokText, okHandler, nokHandler) {
		var dialogDom = document.createElement("guf-alert");
		document.body.appendChild(dialogDom);
		var dialogTag = null;
		riot.compile(function(){
			 dialogTag = riot.mount(dialogDom, {
			 	title: title,
			 	html: content,
			 	ok: okText,
			 	nok: nokText
			 })[0];
			 dialogTag.on('ok', okHandler);
			 if (typeof(nokHandler) ===  "function") {
			 	dialogTag.on('nok', nokHandler);
			 }
		});
		return dialogTag;
	};

	// Snackbars

    function checkSnackbarContainer(callback) {
        if (guf.getSnackbarContainer() == null) {
            var snackbarContainerDom = document.createElement("guf-snackbar-container");
            document.body.appendChild(snackbarContainerDom);
            riot.compile(function(){
                snackbarContainerTag = riot.mount(snackbarContainerDom, {})[0];
                callback();
            });
        } else {
            callback();
        }
    }

	guf.createSnackbar = function(content, btnText, btnHandler, timeout) {
		checkSnackbarContainer(function() {
	        var snackbarDom = document.createElement("guf-snackbar");
	        snackbarContainerTag.root.appendChild(snackbarDom);
	        riot.compile(function(){
	            var opts = {
	                content: content
	            };
	            if (btnText) {
	                opts.btnText = btnText;
	            }
	            if (timeout) {
	                opts.timeout = timeout;
	            }
	            var snackbarTag = riot.mount(snackbarDom, opts)[0];
	        	snackbarTag.on('action', btnHandler);
	    	});
	    });
	};

	guf.setSnackbarContainer = function(tag) {
		if (snackbarContainerTag != null) {
			snackbarContainerTag.unmount();
		}
		snackbarContainerTag = tag;
		snackbarContainerTag.one("unmount", function() {
			snackbarContainerTag = null;
		});
	};

	guf.getSnackbarContainer = function() {
		return snackbarContainerTag;
	};

	guf.openPopup = function(url, params) {
		return new Promise(function(resolve, reject) {
			guf.one("popup", function(mainTag) {
				var popupTag = mainTag;
				popupTag["window"] = popup;
				resolve(popupTag);
			});
			params.menubar = params.menubar || "no";
			params.status = params.status || "no";
			params.toolbar = params.toolbar || "no";
			params.top = ((params.center)?((screen.availHeight/2)-(params.height/2)):undefined) || screen.availTop;
			params.left = ((params.center)?((screen.availWidth/2)-(params.width/2)):undefined) || screen.availLeft;
			params.height = params.height || (screen.availHeight - 60);
			params.width = params.width || (screen.availWidth - 10)

			var popup = window.open(url, "_blank",
				"menubar=" + params.menubar +
				", status=" + params.status +
				", toolbar=" + params.toolbar +
				", top=" + params.top + 
				", left=" + params.left +
				", width=" + params.width +
				", height=" + params.height);
			if(popup == null) {
				reject("popup_blocked");
			}
		});
	};

	guf.async = function(u, c) {
	  	var d = document, t = 'script',
	      	o = d.createElement(t),
	      	s = d.getElementsByTagName(t)[0];
	  	o.src = u;
	  	if (c) { o.addEventListener('load', function (e) { c(null, e); }, false); }
	  	s.parentNode.insertBefore(o, s);
	}

	// Init

	document.addEventListener('deviceready', function() {
		if(guf.device.isIos) {
			if(guf.isDefined("cordova.plugins.iosrtc")) {
				// iosrtc plugin configuration
				cordova.plugins.iosrtc.registerGlobals();
			}
			// Fix for wrong iOS user agent
			var model = device.model;
			if(!guf.device.isPhone && ((model.indexOf("iPhone") != -1) || (model.indexOf("iPod") != -1))) {
				guf.device.isPhone = true;
				guf.device.isTablet = false;
				document.body.classList.add("guf-device-phone");
				document.body.classList.remove("guf-device-tablet");
				checkOrientation();
			} else if(!guf.device.isTablet && model.indexOf("iPad") != -1) {
				guf.device.isPhone = false;
				guf.device.isTablet = true;
				document.body.classList.remove("guf-device-phone");
				document.body.classList.add("guf-device-tablet");
				checkOrientation();
			}
		}
		guf.device.ready = true;
		guf.trigger('deviceready');
	});

	document.addEventListener('pause', function() {
		guf.define('guf.device');
		guf.device.paused = true;
		guf.trigger('pause');
		document.body.classList.add("guf-device-paused");
	});

	document.addEventListener('resume', function() {
		guf.define('guf.device');
		guf.device.paused = false;
		guf.trigger('resume');
		document.body.classList.remove("guf-device-paused");
	});

	guf.on("show", function() {
		guf.device.hidden = false;
	});

	guf.on("hide", function() {
		guf.device.hidden = true;
	});

	window.addEventListener('focus', function() {
		guf.define('guf.device');
		guf.device.focused = true;
		guf.trigger('focus');
		document.body.classList.add("guf-device-focused");
	});

	window.addEventListener('blur', function() {
		guf.define('guf.device');
		guf.device.focused = false;
		guf.trigger('blur');
		document.body.classList.remove("guf-device-focused");
	});	

	// IE additions
	if (guf.isDefined("bowser") && bowser.msie) {
		if (!Array.from) {
			Array.from = (function () {
				var toStr = Object.prototype.toString;
				var isCallable = function (fn) {
					return typeof fn === 'function' || toStr.call(fn) === '[object Function]';
				};
				var toInteger = function (value) {
					var number = Number(value);
					if (isNaN(number)) { return 0; }
					if (number === 0 || !isFinite(number)) { return number; }
					return (number > 0 ? 1 : -1) * Math.floor(Math.abs(number));
				};
				var maxSafeInteger = Math.pow(2, 53) - 1;
				var toLength = function (value) {
					var len = toInteger(value);
					return Math.min(Math.max(len, 0), maxSafeInteger);
				};

				// The length property of the from method is 1.
				return function from(arrayLike/*, mapFn, thisArg */) {
					// 1. Let C be the this value.
					var C = this;

					// 2. Let items be ToObject(arrayLike).
					var items = Object(arrayLike);

					// 3. ReturnIfAbrupt(items).
					if (arrayLike == null) {
						throw new TypeError("Array.from requires an array-like object - not null or undefined");
					}

					// 4. If mapfn is undefined, then let mapping be false.
					var mapFn = arguments.length > 1 ? arguments[1] : void undefined;
					var T;
					if (typeof mapFn !== 'undefined') {
						// 5. else
						// 5. a If IsCallable(mapfn) is false, throw a TypeError exception.
						if (!isCallable(mapFn)) {
							throw new TypeError('Array.from: when provided, the second argument must be a function');
						}

						// 5. b. If thisArg was supplied, let T be thisArg; else let T be undefined.
						if (arguments.length > 2) {
							T = arguments[2];
						}
					}

					// 10. Let lenValue be Get(items, "length").
					// 11. Let len be ToLength(lenValue).
					var len = toLength(items.length);

					// 13. If IsConstructor(C) is true, then
					// 13. a. Let A be the result of calling the [[Construct]] internal method of C with an argument list containing the single item len.
					// 14. a. Else, Let A be ArrayCreate(len).
					var A = isCallable(C) ? Object(new C(len)) : new Array(len);

					// 16. Let k be 0.
					var k = 0;
					// 17. Repeat, while k < len… (also steps a - h)
					var kValue;
					while (k < len) {
						kValue = items[k];
						if (mapFn) {
							A[k] = typeof T === 'undefined' ? mapFn(kValue, k) : mapFn.call(T, kValue, k);
						} else {
							A[k] = kValue;
						}
						k += 1;
					}
					// 18. Let putStatus be Put(A, "length", len, true).
					A.length = len;
					// 20. Return A.
					return A;
				};
			}());
		}
	}

	document.addEventListener("DOMContentLoaded", function() {
		document.body.classList.add("guf");
		guf.define('guf.device');
		guf.device.ready = false;
		guf.device.whenReady = function(handler) {
			if (guf.device.ready) {
				handler();
			} else {
				guf.one("deviceready", handler);
			}
		}
		guf.device.paused = false;
		guf.device.hidden = false;
		guf.device.focused = document.hasFocus();
		if (guf.isDefined("bowser")) {
			var bowserTablet = bowser.tablet && bowser.name != "Internet Explorer";
			guf.device.isMobile = !!(bowser.mobile || bowserTablet);
			guf.device.isTablet = !!bowserTablet;
			guf.device.isPhone = !!bowser.mobile;
			guf.device.isDesktop = !guf.device.isMobile;
			guf.device.isApp = guf.isDefined("process");
			guf.device.isBrowser = guf.device.isDesktop && !guf.device.isApp;
			guf.device.isIos = !!bowser.ios;
			guf.device.isAndroid = !!bowser.android;
			guf.device.isWindows = !!bowser.windows;
			guf.device.isMac = !!bowser.mac;
			guf.device.isLinux = !!bowser.linux;
			guf.device.isChrome = !!bowser.chrome;
			guf.device.version = bowser.version;
			guf.device.osVersion = bowser.osversion || null;
			guf.device.name = bowser.name;
			guf.device.normalizedName = bowser.name.toLowerCase().replace(" ","-");
			guf.device.screen = {};
			if (guf.isDefined("cordova")) {
				guf.device.platform = cordova.platformId;
			} else {
				guf.device.platform = "browser";
			}
			if (guf.device.isIos) {
				guf.device.os = "ios";
			} else if (guf.device.isAndroid) {
				guf.device.os = "android";
			} else if (guf.device.isWindows) {
				guf.device.os = "windows";
			} else if (guf.device.isMac) {
				guf.device.os = "mac";
			} else if (guf.device.isLinux) {
				guf.device.os = "linux";
			}
			guf.device.renderingEngine = "unknown";
			if (bowser.blink) {
				guf.device.renderingEngine = "blink";
			} else if (bowser.webkit) {
				guf.device.renderingEngine = "webkit";
			} else if (bowser.gecko) {
				guf.device.renderingEngine = "gecko";
			} else if (bowser.msie) {
				guf.device.renderingEngine = "msie";
			} else if (bowser.msedge) {
				guf.device.renderingEngine = "msedge";
			}
			document.body.classList.add("guf-os-" + guf.device.os);
			guf.device.olderVersionThan = function(version) {
				return (bowser.compareVersions([guf.device.osVersion, version]) == -1);
			};
			var isPortrait = function() {
				if (window.orientation !== undefined) {
					/**
					 * window.orientation is standard on mobile platforms
					 * -> https://compat.spec.whatwg.org/#windoworientation-interface
					 * -> https://developer.apple.com/documentation/webkitjs/domwindow/1632568-orientation
					 */
					switch (window.orientation) {
						case 0:
						case 180:
							return true;
						case 90:
						case -90:
							return false;
					}
				}
				return window.innerHeight > window.innerWidth;
			};
			guf.device.isPortrait = isPortrait;
			var checkScreenType = function() {
				var previousValue = guf.device.screen.wide;
				guf.device.screen.wide = (guf.device.isDesktop || (guf.device.isTablet && !isPortrait())) &&
						document.body.clientWidth > 1023;
				if (previousValue !== guf.device.screen.wide) {
					if (typeof(previousValue) !== "undefined") {
						guf.trigger("screen-size-changed", guf.device.screen.wide);
					}
					document.body.classList.remove(guf.device.screen.wide ? "guf-screen-narrow" : "guf-screen-wide");
					document.body.classList.add(guf.device.screen.wide ? "guf-screen-wide" : "guf-screen-narrow");
				}
			}
			if (guf.device.isMobile) {
				document.body.classList.add("guf-device-mobile");
				if (guf.device.isPhone) {
					document.body.classList.add("guf-device-phone");
				} else {
					document.body.classList.add("guf-device-tablet");
				}
				if (guf.device.isIos) {
					document.body.classList.add("guf-device-ios");
					document.documentElement.classList.add("guf-device-ios");
					if (guf.device.olderVersionThan("11.0")) {
						document.body.classList.add("guf-device-old-ios");
					}
				}

				var firstEvent = false;
				var firstEventTimeout = null;
				var checkOrientation = function() {
					guf.clearTimeout(firstEventTimeout);
					firstEventTimeout = null;
					document.body.classList.remove(isPortrait() ? "guf-orientation-landscape" : "guf-orientation-portrait");
					document.body.classList.add(isPortrait() ? "guf-orientation-portrait" : "guf-orientation-landscape");
					checkScreenType();
					guf.trigger('orientation-change', isPortrait());
					guf.trigger('orientation-changed', isPortrait());
				}
				var checkOrientationTimeout = function() {
					if (firstEventTimeout != null) {
						guf.clearTimeout(firstEventTimeout);
					}
					firstEventTimeout = guf.setTimeout(function(){
						firstEvent = false;
						firstEventTimeout = null;
					},1000);
				}

				if(guf.device.isIos) {
					window.addEventListener("orientationchange", checkOrientation, false);
				} else {
					window.addEventListener("orientationchange", function() {
						if (firstEvent == "resize") {
							firstEvent = false;
							checkOrientation();
						} else if (!firstEvent) {
							firstEvent = "orientation";
							checkOrientationTimeout();
						}
					}, false);
					window.addEventListener("resize", function() {
						if (firstEvent == "orientation") {
							firstEvent = false;
							checkOrientation();
						} else if (!firstEvent) {
							firstEvent = "resize";
							checkOrientationTimeout();
						}
						checkScreenType();
					}, false);
				}
				checkOrientation();
			} else {
				window.addEventListener("resize", checkScreenType);
				checkScreenType();
				document.body.classList.add("guf-device-desktop");
			}
		} else {
			throw "Bowser dependency is missing. Please add it to the project in order to use guf";
		}
		// Capabilities

		function dragNDropHandler(evt) {
			evt.preventDefault();
			evt.stopPropagation();
			evt.dataTransfer.dropEffect = "none";
		}

		function testDragNDropUpload() {
			var div = document.createElement('div');
			var result = (('draggable' in div) || ('ondragstart' in div && 'ondrop' in div)) && 'FormData' in window && 'FileReader' in window;
			if (result) {
				document.body.addEventListener('drag', dragNDropHandler);
				document.body.addEventListener('dragstart', dragNDropHandler);
				document.body.addEventListener('dragend', dragNDropHandler);
				document.body.addEventListener('dragover', dragNDropHandler);
				document.body.addEventListener('dragenter', dragNDropHandler);
				document.body.addEventListener('dragleave', dragNDropHandler);
				document.body.addEventListener('drop', dragNDropHandler);
			}
			return result;
		}

		guf.device.capabilities = {};
		guf.device.capabilities.screenShare = (guf.device.normalizedName == "chrome" || guf.device.normalizedName == "firefox") && !guf.device.isMobile;
		guf.device.capabilities.dragNDropUpload = guf.device.isDesktop && testDragNDropUpload();

		document.body.classList.add("guf-browser-" + guf.device.normalizedName);
		document.body.classList.add("guf-rendering-engine-" + guf.device.renderingEngine);
		// Riot mount
		guf.ready = true;
		guf.trigger('ready');
		if (guf.isDefined("guf-automount")) {
			guf.mount();
		}
		guf.one('deviceready', function() {
			if (!guf.isDefined("device")) {
				guf.define("guf.device");
			}
			guf.device.id = guf.storage.getItem(guf.storage.LOCAL, "guf.device.id");
			if (guf.isDefined("device")) {
				guf.device.manufacturer = device.manufacturer;
			}
			if (guf.device.isDesktop) {
				if (guf.device.id == null) {
					guf.device.id = guf.generateUuid();
					guf.console.log("Generating UUID for device ID: " + guf.device.id);
					guf.storage.setItem(guf.storage.LOCAL, "guf.device.id", guf.device.id);
				}
			} else {
				guf.device.id = device.uuid;
			}
		});
	});

})();