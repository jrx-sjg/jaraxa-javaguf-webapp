<sam-class-records>
	<guf-linear-layout ref="container" orientation="vertical" class="{container: 1, empty: guf.ancestor(this, 'sam-class-records').isEmpty}">
		<div class="scrollable-content">
			<div class="header">{guf.i18n.get("app.class_records")}</div>
			<sam-class-records-header ref="sticky" data="{guf.ancestor(this, 'sam-class-records').classRecordsData}" content="{guf.ancestor(this, 'sam-class-records').classRecordsData != null && guf.ancestor(this, 'sam-class-records').classRecordsData.classrecords.length > 0}"></sam-class-records-header>
			<sam-empty if="{!guf.ancestor(this, 'sam-class-records').filterApplied && !guf.ancestor(this, 'sam-class-records').loading}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.class_records_empty_text')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-class-records').filterApplied && guf.ancestor(this, 'sam-class-records').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-class-records').filterApplied && guf.ancestor(this, 'sam-class-records').classRecordsData != null && guf.ancestor(this, 'sam-class-records').classRecordsData.classrecords.length === 0}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.class_records_no_absences_text')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-class-records').filterApplied && guf.ancestor(this, 'sam-class-records').classRecordsData == null}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.class_records_no_results_text')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-class-records').classRecordsData != null}">
				<sam-class-records-list-row each={classrecords in guf.ancestor(this, 'sam-class-records').classRecordsData.classrecords}></sam-class-records-list-row>
			</div>
		</div>
	</guf-linear-layout>
	<style scoped type="dcss">
		:scope {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > guf-linear-layout.container {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			display: block;
		}
		:scope > guf-linear-layout.empty {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
		}
		:scope > guf-linear-layout.empty > div.scrollable-content {
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
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > guf-linear-layout > div.scrollable-content > div.header {
			color: @primary;
			font-family: chronicle-deck, serif;
			font-size: 22px;
			height: 24px;
			font-weight:600;
			margin: 26px;
		}
		:scope > guf-linear-layout > div.scrollable-content > sam-class-records-header {
			margin: 0 26px;
			position: -webkit-sticky;
			position: sticky;
			top: 0px;
			background: @lightestbackground;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] {
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
			margin-bottom: 20px;
		}
		body.guf-rendering-engine-webkit :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-gecko :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-msedge :scope > guf-linear-layout > div.scrollable-content > div[ref="content"],
		body.guf-rendering-engine-msie :scope > guf-linear-layout > div.scrollable-content > div[ref="content"] {
			margin-bottom: 0px;
			padding-bottom: 20px;
		}		
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > * {
			margin: 0 26px;			
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-class-records-list-row {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-class-records-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script>
		var tag = this;
		tag.classRecordsData = null;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');
		tag.isEmpty = true;
		tag.loading = false;
		tag.filterApplied = false;

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			tag.isEmpty = tag.classRecordsData == null || tag.classRecordsData.classrecords.length === 0;
		});

		tag.getClasses = function() {
			return tag.refs["container"].refs["class"];
		};

		function initEvents() {
			tag.refs["container"].tags["sam-class-records-header"].on("apply", applyFilter);
			tag.refs["container"].tags["sam-class-records-header"].on("reset", resetFilter);
			tag.refs["container"].tags["sam-class-records-header"].on("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-class-records-header"].on("submit-click", submitClickHandler);
			tag.refs["container"].tags["sam-class-records-header"].on("go-out", goOutHandler);
		}

		function removeEvents() {
			tag.refs["container"].tags["sam-class-records-header"].off("apply", applyFilter);
			tag.refs["container"].tags["sam-class-records-header"].off("reset", resetFilter);
			tag.refs["container"].tags["sam-class-records-header"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-class-records-header"].off("submit-click", submitClickHandler);
			tag.refs["container"].tags["sam-class-records-header"].off("go-out", goOutHandler);
		}

		function applyFilter() {
			tag.loading = true;
			app.ajax.get("api/classrecords", {
			}, function(response, xhr) {
				guf.console.log("classrecords results", response.data);
				tag.filterApplied = true;
				tag.loading = false;
				tag.classRecordsData = guf.utils.cloneObject(response.data);
				tag.update();
			}, function(response, xhr) {
				guf.console.error("Error getting class records", response);
				tag.filterApplied = true;
				tag.loading = false;
				tag.classRecordsData = null;
				tag.update();
			});
			tag.update();
		}

		function resetFilter() {
			tag.classRecordsData = null;
			tag.filterApplied = false;
			tag.update();
		}

		function filterMinimizedHandler(minimized) {
		}

		function submitClickHandler() {
			app.ajax.put("api/classrecords/submit", {
			}, function(response, xhr) {
				guf.console.log("classrecords submit results", response.data);
				// replicate server logic. Keep updated!
				tag.classRecordsData.canSubmit = false;
				tag.classRecordsData.submitted = 1;
				tag.update();
			}, function(response, xhr) {
				guf.console.error("Error submitting class records", response);
				tag.update();
			});
		}

		function goOutHandler() {
			tag.trigger("go-out");
		}		

	</script>	
</sam-class-records>