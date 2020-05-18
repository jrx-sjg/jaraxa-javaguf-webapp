(function(){
	var GufRecipientsSelection = function() {
		GufSelectionModel.prototype.constructor.apply(this);
	};

	GufRecipientsSelection.prototype = Object.create(GufSelectionModel.prototype);

	GufRecipientsSelection.prototype.constructor = GufRecipientsSelection;

	GufRecipientsSelection.prototype.getId = function(itemData) {
		return itemData.id;
	};

	window.GufRecipientsSelection = GufRecipientsSelection;
})();