<sam-pending-class-records>
	<guf-linear-layout ref="container" orientation="vertical" class="{container: 1, empty: guf.ancestor(this, 'sam-pending-class-records').isEmpty}">
		<div class="scrollable-content">
			<div class="header">{guf.i18n.get("app.pending_class_records")}</div>
			<sam-pending-class-records-header ref="sticky" data="{guf.ancestor(this, 'sam-pending-class-records').pendingClassRecordsData}" content="{guf.ancestor(this, 'sam-pending-class-records').pendingClassRecordsData.length > 0}"></sam-pending-class-records-header>
			<sam-empty if="{!guf.ancestor(this, 'sam-pending-class-records').filterApplied && !guf.ancestor(this, 'sam-pending-class-records').loading}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.pending_class_records_empty_text')}"></sam-empty>
			<sam-empty if="{!guf.ancestor(this, 'sam-pending-class-records').filterApplied && guf.ancestor(this, 'sam-pending-class-records').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
			<sam-empty if="{guf.ancestor(this, 'sam-pending-class-records').filterApplied && guf.ancestor(this, 'sam-pending-class-records').pendingClassRecordsData.length === 0}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.pending_class_records_no_results_text')}"></sam-empty>
			<div ref="content" if="{guf.ancestor(this, 'sam-pending-class-records').pendingClassRecordsData != null}">
				<sam-pending-class-records-list-row each={item, index in guf.ancestor(this, 'sam-pending-class-records').pendingClassRecordsData}></sam-pending-class-records-list-row>
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
			min-width: 1200px;
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
		:scope > guf-linear-layout > div.scrollable-content > sam-pending-class-records-header {
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
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-pending-class-records-list-row {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > guf-linear-layout > div.scrollable-content > div[ref="content"] > sam-pending-class-records-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script>
		var tag = this;
		tag.pendingClassRecordsData = [];
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
		var CANT_CHANGE_STATUS = "CANT_CHANGE_STATUS";

		function initListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-pending-class-records-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].on("ignore-click", ignoreClickHandler);
				items[i].on("submit-click", submitClickHandler);
			}
		}

		function removeListEvents() {
			var items = guf.tagsAsArray(tag.refs["container"].tags["sam-pending-class-records-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].off("ignore-click", ignoreClickHandler);
				items[i].off("submit-click", submitClickHandler);
			}
		}

		function initEvents() {
			tag.refs["container"].tags["sam-pending-class-records-header"].on("apply", applyFilter);
			tag.refs["container"].tags["sam-pending-class-records-header"].on("reset", resetFilter);
			tag.refs["container"].tags["sam-pending-class-records-header"].on("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].on("submit-click", submitClickHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].on("export-excel-click", exportExcelClickHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].on("go-out", goOutHandler);
			initListEvents();
		}

		function removeEvents() {
			tag.refs["container"].tags["sam-pending-class-records-header"].off("apply", applyFilter);
			tag.refs["container"].tags["sam-pending-class-records-header"].off("reset", resetFilter);
			tag.refs["container"].tags["sam-pending-class-records-header"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].off("submit-click", submitClickHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].off("export-excel-click", exportExcelClickHandler);
			tag.refs["container"].tags["sam-pending-class-records-header"].off("go-out", goOutHandler);
			removeListEvents();
		}

		function applyFilter() {
			tag.loading = true;
			app.ajax.get("api/pendingclassrecords", {
			}, function(response, xhr) {
				tag.filterApplied = true;
				tag.loading = false;
				tag.pendingClassRecordsData = guf.utils.cloneObject(response.data);
				tag.update();
			}, function(response, xhr) {
				guf.console.error("Error getting pending class records", response);
				tag.filterApplied = true;
				tag.loading = false;
				tag.pendingClassRecordsData = [];
				tag.update();
			});
			tag.update();
		}

		function resetFilter() {
			tag.pendingClassRecordsData = [];
			tag.filterApplied = false;
			tag.update();
		}

		function isSameClassRecords(classRecordsA, classRecordsB) {
			if(classRecordsA.week != classRecordsB.week) {
				return false;
			}
			if(classRecordsA.year != classRecordsB.year) {
				return false;
			}
			if(classRecordsA.semester != classRecordsB.semester) {
				return false;
			}
			if(classRecordsA.program != classRecordsB.program) {
				return false;
			}
			if(classRecordsA.course != classRecordsB.course) {
				return false;
			}
			if(classRecordsA.className != classRecordsB.className) {
				return false;
			}
			if(classRecordsA.teacher != classRecordsB.teacher) {
				return false;
			}
			return true;
		}

		function filterMinimizedHandler(minimized) {
		}

		function ignoreClickHandler(rowTag, itemData) {
			rowTag.showOverlay();
			var params = {
				year: itemData.year,
				semester: itemData.semester,
				program: itemData.program,
				course: itemData.course,
				className: itemData.className,
				week: itemData.week,
				teacher: itemData.teacher,
				submitted: itemData.status === 2 ? 0 : 2
			};
			app.ajax.put("api/pendingclassrecords/save", params, function(response, xhr) {
				itemData.status = params.submitted;
				rowTag.hideOverlay();
			}, function(response, xhr) {
				var json = JSON.parse(xhr.response);
				if (json.message === CANT_CHANGE_STATUS) {
					cantChangeStatusMsg();
				}
				guf.console.error("Error ignoring pending class records details", response);
				rowTag.hideOverlay();
			});
		}

		function cantChangeStatusMsg() {
			guf.createDialog(
				guf.i18n.get("app.message"), 
				guf.i18n.get("app.cant_change_status_to_ignored"), 
				guf.i18n.get("guf.ok")
			);
		}

		function submitClickHandler(rowTag, itemData) {
			tag.trigger("submit-click", tag, itemData);
		}

		function exportExcelClickHandler() {
			var url = app.getBaseUrl() + "api/pendingclassrecords/export";
			var element = document.createElement('a');
			element.setAttribute('href', url);
			element.setAttribute('download', 'export.xls');
			element.style.display = 'none';
			document.body.appendChild(element);
			element.click();
			document.body.removeChild(element);
		}

		function scrollDeltaHandler(delta) {
			tag.trigger("scroll-delta", delta);
		}

		tag.updateItem = function(itemData) {
			for(var index = 0; index < tag.pendingClassRecordsData.length; index++) {
				if(isSameClassRecords(tag.pendingClassRecordsData[index], itemData)) {
					tag.pendingClassRecordsData[index].status = itemData.status;
					tag.update();
					break;
				}
			}
		};

		function goOutHandler() {
			tag.trigger("go-out");
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			removeListEvents();
			tag.isEmpty = tag.pendingClassRecordsData.length === 0;
		});

		tag.on("updated", function() {
			initListEvents();
		});
	</script>
</sam-pending-class-records>