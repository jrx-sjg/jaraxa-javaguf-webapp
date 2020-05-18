<sam-limits-monitoring-notification-list>
	<guf-linear-layout orientation="horizontal" class="header">
		<div class="title-column flex1">{guf.i18n.get('app.notification').toUpperCase()}</div>
		<div class="date-column">{guf.i18n.get('app.date').toUpperCase()}</div>
		<div class="notification-column"><i class="material-icons-outlined">mail</i></div>
		<div class="meeting-column"><i class="material-icons-outlined">people</i></div>
	</guf-linear-layout>
	<sam-limits-monitoring-notification-list-row each={notification in guf.ancestor(this, 'sam-limits-monitoring-notification-list').notifications}></sam-limits-monitoring-notification-list-row>
	<style scoped type="dcss">
		:scope {
			border: 1px solid @lines;
			border-radius: 10px;
		}
		:scope > .header {
			border-bottom: 1px solid @lines;
			color: @primary;
			height: 35px;
		}
		:scope > .header > div {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			justify-content: center;
			border-right: 1px solid @background;
			padding: 0px 10px;
		}
		:scope > .header > .date-column {
			width: 80px;
			text-align: center;
		}
		:scope > .header > .notification-column {
			width: 50px;
			text-align: center;
		}
		:scope > .header > .meeting-column {
			width: 50px;
			text-align: center;
			border-right: 0;
		}
		:scope > sam-limits-monitoring-notification-list-row:not(:last-child) {
			border-bottom: 1px solid @background;
		}

		@media screen and (max-width: 600px) {
			:scope > .header > div {
				font-size: 13px;
				padding: 0 6px;
			}
			:scope > .header > .title-column {
				min-width: 100px;
			}
			:scope > .header > .date-column {
				min-width: 60px;
				width: 60px;
			}
			:scope > .header > .notification-column {
				width: 30px;
			}
			:scope > .header > .meeting-column {
				width: 30px;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.notifications = opts.notifications || [];

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl', 'relay-events');

		function initListEvents() {
			var items = guf.tagsAsArray(tag.tags["sam-limits-monitoring-notification-list-row"]);
			for(var i=0; i<items.length; i++) {
				tag.addRelayHandlers(items[i]);
			}
		}

		function removeListEvents() {
			var items = guf.tagsAsArray(tag.tags["sam-limits-monitoring-notification-list-row"]);
			for(var i=0; i<items.length; i++) {
				tag.removeRelayHandlers(items[i]);
			}
		}

		function initEvents() {
			initListEvents();
		}

		function removeEvents() {
			removeListEvents();
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			tag.notifications = opts.notifications || [];
			removeListEvents();
		});

		tag.on("updated", function() {
			initListEvents();
		});
	</script>
</sam-limits-monitoring-notification-list>