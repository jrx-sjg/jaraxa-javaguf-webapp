(function(){
	var DataProvider = function() {
	};

	DataProvider.prototype.constructor = DataProvider;

	// returns a requestId
	// callback will have 2 params: total number of rows and current block data
	DataProvider.prototype.requestDataBlock = function(initial, size, callback) {
		throw new Error("requestDataBlock method must be implemented in " + this.constructor.name);
	};

	DataProvider.prototype.cancelRequest = function(requestId) {
		throw new Error("cancelRequest method must be implemented in " + this.constructor.name);
	};

	window.GufDataProvider = DataProvider;
})();