(function(){
	var DEFAULT_TYPE = "default";

	var SelectionModel = function() {
		riot.observable(this);
		this._selection = new Object();
	};

	SelectionModel.prototype.constructor = SelectionModel;

	SelectionModel.prototype.selectItem = function(itemId, types) {
		var selection = this._selection;
		var types = types || [DEFAULT_TYPE];
		if(typeof selection[itemId] === "undefined") {
			selection[itemId] = new Array();
		}
		for(var typeIndex in types) {
			var type = types[typeIndex];
			if(selection[itemId].indexOf(type) == -1) {
				selection[itemId].push(type);
			}
		}
		this.trigger("select-item", itemId, types);
	};

	SelectionModel.prototype.deselectItem = function(itemId, types) {
		var selection = this._selection;
		if(types) {
			if(typeof selection[itemId] !== "undefined") {
				for(var typeIndex in types) {
					var type = types[typeIndex];
					var index = selection[itemId].indexOf(type);
					if(index != -1) {
						selection[itemId].splice(index, 1);
						if(selection[itemId].length == 0) {
							delete selection[itemId];
						}
					}
				}
			}
		} else {
			if(typeof selection[itemId] !== "undefined") {
				delete selection[itemId];
			}
		}
		this.trigger("deselect-item", itemId, types);
	};

	SelectionModel.prototype.clearSelection = function(types) {
		var selection = this._selection;
		if(types) {
			for(var itemId in selection) {
				var itemSelection = selection[itemId];
				for(var typeIndex in types) {
					var type = types[typeIndex];
					var index = selection[itemId].indexOf(type);
					if(index != -1) {
						selection[itemId].splice(index, 1);
						if(selection[itemId].length == 0) {
							delete selection[itemId];
						}
					}
				}
			}
		} else {
			this._selection = new Object();
		}
		this.trigger("clear-selection", types);
	};

	SelectionModel.prototype.isSelected = function(itemId) {
		var selection = this._selection;
		return typeof selection[itemId] !== "undefined";
	};

	SelectionModel.prototype.getSelectionTypes = function(itemId) {
		var selection = this._selection;
		if(typeof selection[itemId] !== "undefined") {
			return selection[itemId].slice(0); // returns a copy of selection types
		}
		return null;
	};

	SelectionModel.prototype.getSelectedIds = function(types) {
		var result = new Array();
		var selection = this._selection;
		if(types) {
			for(var itemId in selection) {
				var itemSelection = selection[itemId];
				for(var typeIndex in types) {
					var type = types[typeIndex];
					var index = selection[itemId].indexOf(type);
					if(index != -1) {
						result.push(itemId);
						break;
					}
				}
			}
		} else {
			for(var itemId in selection) {
				result.push(itemId);
			}
		}
		return result;
	};

	SelectionModel.prototype.getId = function(itemData) {
		throw new Error("getId method must be implemented in " + this.constructor.name);
	};

	window.GufSelectionModel = SelectionModel;
})();