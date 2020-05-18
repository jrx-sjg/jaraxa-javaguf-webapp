<sam-limits-monitoring>
	<guf-linear-layout ref="container" orientation="vertical" class="{container: 1, empty: guf.ancestor(this, 'sam-limits-monitoring').isEmpty, course-view: guf.ancestor(this, 'sam-limits-monitoring').selectedView == app.LIMITS_MONITORING_VIEW.COURSE}">
		<div class="scrollable-content">
			<div class="header">{guf.i18n.get("app.limits_monitoring")}</div>
			<sam-limits-monitoring-header ref="sticky" data="{guf.ancestor(this, 'sam-limits-monitoring').limitsMonitoringData}" view="{guf.ancestor(this, 'sam-limits-monitoring').selectedView}" content="{guf.ancestor(this, 'sam-limits-monitoring').limitsMonitoringData.length > 0}"></sam-limits-monitoring-header>
			<sam-empty if="{!guf.ancestor(this, 'sam-limits-monitoring').filterApplied && !guf.ancestor(this, 'sam-limits-monitoring').loading}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.limits_monitoring_empty_text')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-limits-monitoring').filterApplied && guf.ancestor(this, 'sam-limits-monitoring').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-limits-monitoring').emptyData}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.limits_monitoring_no_data')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-limits-monitoring').limitsMonitoringData != null}">
				<sam-limits-monitoring-list-row each={item in guf.ancestor(this, 'sam-limits-monitoring').limitsMonitoringData} view="{guf.ancestor(this, 'sam-limits-monitoring').selectedView}" exceed="{guf.ancestor(this, 'sam-limits-monitoring').selectedExceed}" exceed-courses="{guf.ancestor(this, 'sam-limits-monitoring').selectedExceedCourses}"></sam-limits-monitoring-list-row>
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
		.guf-device-old-ios :scope > guf-linear-layout:not(.empty) {
			min-width: 850px;
		}
		.guf-device-old-ios :scope > guf-linear-layout.course-view:not(.empty) {
			min-width: 1250px;
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
		:scope > guf-linear-layout > div.scrollable-content > sam-limits-monitoring-header {
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
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-limits-monitoring-list-row {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-limits-monitoring-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script>
		var tag = this;
		var search = {
			value: "",
			studentIndex: -1,
			tag: null
		};
		tag.limitsMonitoringData = [];
		tag.selectedView = null;
		tag.selectedExceed = null;
		tag.selectedExceedCourses = null;
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
		tag.emptyData = false;

		function initListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-limits-monitoring-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].on("click", studentClickHandler);
			}
		}

		function removeListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-limits-monitoring-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].off("click", studentClickHandler);
			}
		}

		function initEvents() {
			tag.refs["container"].tags["sam-limits-monitoring-header"].on("apply", applyFilter);
			tag.refs["container"].tags["sam-limits-monitoring-header"].on("reset", resetFilter);
			tag.refs["container"].tags["sam-limits-monitoring-header"].on("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-limits-monitoring-header"].on("search", searchHandler);
			tag.refs["container"].tags["sam-limits-monitoring-header"].on("export-excel-click", exportExcelClickHandler);
			app.limitsMonitoring.on("updated", limitsMonitoringUpdatedHandler);
			initListEvents();
		}

		function removeEvents() {
			tag.refs["container"].tags["sam-limits-monitoring-header"].off("apply", applyFilter);
			tag.refs["container"].tags["sam-limits-monitoring-header"].off("reset", resetFilter);
			tag.refs["container"].tags["sam-limits-monitoring-header"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-limits-monitoring-header"].off("search", searchHandler);
			tag.refs["container"].tags["sam-limits-monitoring-header"].off("export-excel-click", exportExcelClickHandler);
			app.limitsMonitoring.off("updated", limitsMonitoringUpdatedHandler);
			removeListEvents();
		}

		function applyFilter(selectedView, selectedExceed, selectedExceedCourses) {
			app.limitsMonitoring.init();
			tag.loading = true;
			app.limitsMonitoring.load().then(function(data) {
				tag.filterApplied = true;
				tag.loading = false;
				tag.selectedView = selectedView;
				tag.selectedExceed = selectedExceed;
				tag.selectedExceedCourses = selectedExceedCourses;
				tag.update();
			}).catch(function() {
				tag.filterApplied = true;
				tag.loading = false;
				tag.update();
			});
			tag.update();
		}

		function resetFilter() {
			app.limitsMonitoring.release();
			tag.filterApplied = false;
			tag.selectedView = null;
			tag.selectedExceed = null;
			tag.selectedExceedCourses = null;
			tag.update();
		}

		function filterMinimizedHandler(minimized) {
		}

		function searchHandler(value) {
			if (search.tag != null) {
				search.tag.highlightText(null);
			}
			var searchData = tag.limitsMonitoringData;
			if (search.value != value) {
				search.value = value;
				search.studentIndex = -1;
				search.tag = null;
			}
			search.studentIndex++;
			var found = false;
			var fromBeginning = search.studentIndex == 0;
			while (!found && search.studentIndex < searchData.length) {
				found = studentMatchSearch(value, searchData[search.studentIndex]);
				if (!found) {
					search.studentIndex++;
				}
			}
			if (found) {
				search.tag = guf.tagsAsArray(tag.refs["container"].tags["sam-limits-monitoring-list-row"])[search.studentIndex];
				search.tag.highlightText(value.toLowerCase());
				search.tag.update();
				tag.trigger("scroll", search.tag.root.offsetTop - tag.refs["container"].refs["sticky"].getStickyHeight());
			} else if (fromBeginning) {
				guf.createDialog(guf.i18n.get("guf.search"), guf.i18n.get("app.search_not_found", value), guf.i18n.get("guf.ok"));
			} else {
				guf.createDialog(guf.i18n.get("guf.search"), guf.i18n.get("app.search_not_found_ask_beginning", value), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
					search.value = value;
					search.studentIndex = -1;
					search.tag = null;
					searchHandler(value);
				}, function() {
					// Do nothing
				});
			}
		}

		function studentMatchSearch(value, studentData) {
			var lowerValue = value.toLowerCase();
			var lowerFirstName = studentData.firstName.toLowerCase();
			var lowerLastName = studentData.lastName.toLowerCase();
			var lowerPreferredName = !!studentData.preferredName ? studentData.preferredName.toLowerCase() : "";
			var lowerId = (studentData.studentId + "").toLowerCase();
			return lowerFirstName.indexOf(lowerValue) != -1 || lowerLastName.indexOf(lowerValue) != -1 ||
				lowerPreferredName.indexOf(lowerValue) != -1 || lowerId.indexOf(lowerValue) != -1;
		}

		function exportExcelClickHandler() {
			var url = app.getBaseUrl() + "api/absencesdetail/export";
			var element = document.createElement('a');
			element.setAttribute('href', url);
			element.setAttribute('download', 'export.xls');
			element.style.display = 'none';
			document.body.appendChild(element);
			element.click();
			document.body.removeChild(element);
		}

		function studentClickHandler(studentData, itemTag) {
			tag.trigger("student-click", studentData, itemTag.opts.view);
		}

		function limitsMonitoringUpdatedHandler() {
			tag.update();
		}

		function scrollDeltaHandler(delta) {
			tag.trigger("scroll-delta", delta);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			tag.limitsMonitoringData = app.limitsMonitoring.get();
			removeListEvents();
			tag.isEmpty = tag.limitsMonitoringData.length === 0;
			tag.emptyData = tag.filterApplied && tag.limitsMonitoringData.length === 0;
		});

		tag.on("updated", function() {
			initListEvents();
		});
	</script>
</sam-limits-monitoring>