(function(){
	guf.define('guf.debug');

	function add() {
		var debugObj = guf.debug;
		var length = arguments.length;
		for (var i = 0; i < length - 2; i++) {
			if (typeof(debugObj[arguments[i]]) == "undefined") {
				debugObj[arguments[i]] = {};
			}
			debugObj = debugObj[arguments[i]];
		}
		if (typeof(debugObj[arguments[length - 2]]) == "undefined") {
			debugObj[arguments[length - 2]] = [];
		}
		debugObj = debugObj[arguments[length - 2]];
		debugObj.push(arguments[length - 1]);
	}

	function recursiveRemove(debugObj, args) {
		if (args.length > 0) {
			var first = args.shift();
			var lastElement = args.length == 0;
			if (typeof(debugObj[first]) != "undefined") {
				recursiveRemove(debugObj[first], args);
			}
			var count = 0;
			for (var prop in debugObj[first]) {
				count++;
			}
			if (count == 0 || lastElement) {
				delete debugObj[first];
			}
		}
	}

	function remove() {
		var debugObj = guf.debug;
		recursiveRemove(debugObj, Array.from(arguments));
	}

	function clear() {
		//FIXME
	}

	guf.debug = {
		add : add,
		remove : remove,
		clear : clear
	};
})();