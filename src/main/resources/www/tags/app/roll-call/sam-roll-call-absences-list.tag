<sam-roll-call-absences-list>
	<sam-roll-call-absences-list-item ref="period" each="{item in periods}" class="column">
	</sam-roll-call-absences-list-item>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			border: 1px solid @lines;
			border-radius: 8px;
			overflow: hidden;
		}
		:scope > .column {
			width: 48px;
		}
		:scope > .column + .column {
			border-left: 1px solid @lines;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.periods = opts.periods || [];

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": "@background",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};
		tag.mixin('mdl', 'relay-events');

		function initEvents() {
			var items = guf.tagsAsArray(tag.refs["period"]);
			for(var i = 0; i < items.length; i++) {
				var item = items[i];
				tag.addRelayHandlers(item);
			}
		}

		function removeEvents() {
			var items = guf.tagsAsArray(tag.refs["period"]);
			for(var i = 0; i < items.length; i++) {
				var item = items[i];
				tag.removeRelayHandlers(item);
			}
		}

		function createPeriodsFromData(data) {
			var periods = [];
			for(var i=0; i<data.length; i++) {
				var period = {
					startingHour: data[i].startingHour,
					endingHour: data[i].endingHour,
					state: data[i].state,
					submitted: data[i].submitted,
					canModify: data[i].canModify,
					canModifySubmitted: data[i].canModifySubmitted
				};
				periods.push(period);
			}
			return periods;
		}

		tag.setData = function(data) {
			removeEvents();
			tag.periods = [];
			tag.update();
			tag.periods = createPeriodsFromData(data);
			tag.update();
			initEvents();
		};

		tag.getData = function() {
			return guf.utils.cloneObject(tag.periods);
		};

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-roll-call-absences-list>