(function(){
	
	// Routing stuff
	guf.route = (function(){
		
		var _collection;
		var _id;
		var _action;
		var _currentLocation = "";
		var _alreadyDone = false;

		function _route(collection, id, action, initial, _alreadyDone){
			_collection = collection;
			_id = id;
			_action = action;
			_currentLocation = getRoute();
			guf.console.log("routing to /" + 
				(typeof(collection) !== "undefined" ? collection : "") +
				(typeof(id) !== "undefined" ? "/" + id : "") +
				(typeof(action) !== "undefined" ? "/" + action : "") + 
				(initial ? " | initial" : "") +
				(_alreadyDone ? " | already done" : ""));
			if (!_alreadyDone) {
				guf.route.trigger("route", collection, id, action);
			}
		}

		function getRoute() {
			if (window.location.hash != '') {
				return window.location.hash.substring(1);
			} else {
				return "";
			}
		}
		
		function _init() {
			window.route(function(collection, id, action){
				_route(collection, id, action, false, _alreadyDone);
				_alreadyDone = false;
			});
			window.route.start();
			if (window.location.hash != '') {
				var splitted = window.location.hash.substring(1).split("/");
				if (splitted.length > 0) {
					_route(splitted[0], 
						splitted.length > 1 ? splitted[1] : undefined, 
						splitted.length > 2 ? splitted[2] : undefined,
						true,
						true);
				}
			}
			delete this.init;
		}
		return {
			init: _init,
			to : function(target, title, shouldReplace) { 
				if (target != _currentLocation) {
					_alreadyDone = true;
				}
				window.route(target, title, shouldReplace);
			},
			getCollection : function() { return _collection; },
			getId : function() { return _id; },
			getAction : function() { return _action; },
			get : getRoute,
			isAlreadyDone : function() { return _alreadyDone; }
		}
	})();
		
	riot.observable(guf.route);
	guf.route.init();
	
})();