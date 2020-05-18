<sam-reporting>
	<guf-linear-layout ref="container" orientation="vertical" class="{container: 1, empty: guf.ancestor(this, 'sam-reporting').isEmpty}">
		<div class="scrollable-content" ref="scrollable-content">
			<div class="header">{guf.i18n.get("app.reporting")}</div>
			<sam-reporting-header ref="sticky" data="{guf.ancestor(this, 'sam-reporting').reportingData}" view="{guf.ancestor(this, 'sam-reporting').selectedView}" content="{guf.ancestor(this, 'sam-reporting').reportingData.length > 0}"></sam-reporting-header>
			<sam-empty if="{!guf.ancestor(this, 'sam-reporting').filterApplied && !guf.ancestor(this, 'sam-reporting').loading}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.reporting_empty_text')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-reporting').filterApplied && guf.ancestor(this, 'sam-reporting').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-reporting').emptyData}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.limits_monitoring_no_data')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-reporting').reportingData != null && guf.ancestor(this, 'sam-reporting').selectedView === app.REPORTING_VIEW.STUDENT}">
				<sam-reporting-student-list-row ref="row" each={item in guf.ancestor(this, 'sam-reporting').reportingData} period="{guf.ancestor(this, 'sam-reporting').selectedPeriod}"></sam-reporting-student-list-row>
			</div>
			<div ref="content" if="{guf.ancestor(this, 'sam-reporting').reportingData != null && guf.ancestor(this, 'sam-reporting').selectedView === app.REPORTING_VIEW.CLASS_COURSE}">
				<sam-reporting-class-list-row ref="row" each={item in guf.ancestor(this, 'sam-reporting').reportingData} period="{guf.ancestor(this, 'sam-reporting').selectedPeriod}"></sam-reporting-class-list-row>
			</div>
			<div ref="content" if="{guf.ancestor(this, 'sam-reporting').reportingData != null && guf.ancestor(this, 'sam-reporting').selectedView === app.REPORTING_VIEW.DATE_WEEK}">
				<sam-reporting-date-list-row ref="row" each={item in guf.ancestor(this, 'sam-reporting').reportingData} period="{guf.ancestor(this, 'sam-reporting').selectedPeriod}"></sam-reporting-date-list-row>
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
			min-width: 1300px;
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
		:scope > guf-linear-layout > div.scrollable-content > sam-reporting-header {
			margin: 0 26px;
			position: -webkit-sticky;
			position: sticky;
			top: 0px;
			background: @lightestbackground;
			z-index: 1;
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
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > [ref="row"] {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > [ref="row"]:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script>
		var tag = this;
		tag.reportingData = [];
		tag.selectedView = null;
		tag.selectedPeriod = null;
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
			var items = [];
			if (tag.selectedView != null) {
				items = guf.tagsAsArray(tag.refs["container"].refs["row"]);
			}
			for (var i = 0; i < items.length; i++) {
				items[i].on("student-details-click", studentDetailsClickHandler);
			}
		}

		function removeListEvents() {
			var items = [];
			if (tag.selectedView != null) {
				items = guf.tagsAsArray(tag.refs["container"].refs["row"]);
			}
			for (var i=0; i<items.length; i++) {
				items[i].off("student-details-click", studentDetailsClickHandler);
			}
		}

		function initEvents() {
			tag.refs["container"].tags["sam-reporting-header"].on("apply", applyFilter);
			tag.refs["container"].tags["sam-reporting-header"].on("reset", resetFilter);
			tag.refs["container"].tags["sam-reporting-header"].on("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-reporting-header"].on("export-excel-click", exportExcelClickHandler);
			tag.refs["container"].tags["sam-reporting-header"].on("scroll-delta", scrollDeltaHandler);
		}

		function removeEvents() {
			tag.refs["container"].tags["sam-reporting-header"].off("apply", applyFilter);
			tag.refs["container"].tags["sam-reporting-header"].off("reset", resetFilter);
			tag.refs["container"].tags["sam-reporting-header"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-reporting-header"].off("export-excel-click", exportExcelClickHandler);
			tag.refs["container"].tags["sam-reporting-header"].off("scroll-delta", scrollDeltaHandler);
		}

		function applyFilter(selectedView, selectedPeriod) {
			var apiUrl = null;
			switch(selectedView) {
				case app.REPORTING_VIEW.STUDENT:
					apiUrl = "api/reporting/student";
					break;
				case app.REPORTING_VIEW.CLASS_COURSE:
					apiUrl = "api/reporting/courseClass";
					break;
				case app.REPORTING_VIEW.DATE_WEEK:
					apiUrl = "api/reporting/dateWeek";
					break;
			}
			if(apiUrl) {
				tag.loading = true;
				app.ajax.get(apiUrl, {
				}, function(response, xhr) {
					guf.console.log("reporting data", response);
					tag.filterApplied = true;
					tag.loading = false;
					tag.selectedView = selectedView;
					tag.selectedPeriod = selectedPeriod;
					tag.reportingData = guf.utils.cloneObject(response.data);
					tag.update();
				}, function(response, xhr) {
					guf.console.error("Error getting reporting", response);
					tag.loading = false;
					tag.update();
				});
				tag.update();
			}
		}

		function resetFilter() {
			tag.filterApplied = false;
			tag.selectedView = null;
			tag.selectedPeriod = null;
			tag.reportingData = [];
			tag.update();
		}

		function filterMinimizedHandler(minimized) {
		}

		function exportExcelClickHandler() {
			var url = app.getBaseUrl() + "api/reporting/export";
			var element = document.createElement('a');
			element.setAttribute('href', url);
			element.setAttribute('download', 'export.xls');
			element.style.display = 'none';
			document.body.appendChild(element);
			element.click();
			document.body.removeChild(element);
		}

		function studentClickHandler(studentData, itemTag) {
			tag.trigger("student-click", studentData);
		}

		function studentDetailsClickHandler(semester, studentId, year) {
			tag.trigger("student-details-click", semester, studentId, year);
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
			tag.emptyData = tag.filterApplied && tag.reportingData.length === 0;
			tag.isEmpty = tag.reportingData.length === 0;
			removeListEvents();
		});

		tag.on("updated", function() {
			initListEvents();
		});

	</script>
</sam-reporting>