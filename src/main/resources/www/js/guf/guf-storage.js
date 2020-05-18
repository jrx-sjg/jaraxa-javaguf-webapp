(function(){
	
	// Routing stuff
	guf.storage = (function(){
		var LOCAL = 0;
		var SESSION = 1;
		var CURRENT = 2;

		var _currentStorage = LOCAL;
		var _prefix = "";

		function setPrefix(prefix) {
			_prefix = prefix;
		}

		function getPrefix() {
			return _prefix;
		}

		function setStorage(storage) {
			switch (storage) {
				case LOCAL:
					_currentStorage = LOCAL;
					break;
				case SESSION:
					_currentStorage = SESSION;
					break;
			}
		}

		function getStorageObj(storage) {
			if (storage != LOCAL && storage != SESSION) {
				storage = _currentStorage;
			}
			switch (storage) {
				case LOCAL:
					return window.localStorage;
				case SESSION:
					return window.sessionStorage;
			}			
		}

		function key(storage, key) {
			return getStorageObj(storage).key(key);
		}

		function setItem(storage, keyName, keyValue) {
			getStorageObj(storage).setItem(_prefix + keyName, keyValue);
		}

		function getItem(storage, keyName, defaultValue) {
			var result = getStorageObj(storage).getItem(_prefix + keyName);
			if (result === null && typeof(defaultValue) !== "undefined") {
				result = defaultValue;
			}
			return result;
		}

		function removeItem(storage, keyName) {
			getStorageObj(storage).removeItem(_prefix + keyName);
		}

		function clear(storage) {
			getStorageObj(storage).clear();
		}

		function size(storage) {
			return getStorageObj(storage).length;
		}

		return {
			LOCAL: LOCAL,
			SESSION: SESSION,
			CURRENT: CURRENT,
			setPrefix : setPrefix,
			getPrefix : getPrefix,
			setStorage : setStorage,
			key: key,
			setItem: setItem,
			getItem: getItem,
			removeItem: removeItem,
			clear: clear,
			size: size
		}
	})();
})();