<sam-reporting-header>
	<sam-reporting-filter ref="filter"></sam-reporting-filter>
	<sam-reporting-content ref="content" if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-reporting-header').opts,'content', true)}" data="{guf.ancestor(this, 'sam-reporting-header').opts.data}"></sam-reporting-content>
	<sam-reporting-student-list-header if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-reporting-header').opts,'content', true) && guf.ancestor(this, 'sam-reporting-header').opts.view === app.REPORTING_VIEW.STUDENT}"></sam-reporting-student-list-header>
	<sam-reporting-class-list-header if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-reporting-header').opts,'content', true) && guf.ancestor(this, 'sam-reporting-header').opts.view === app.REPORTING_VIEW.CLASS_COURSE}"></sam-reporting-class-list-header>
	<sam-reporting-date-list-header if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-reporting-header').opts,'content', true) && guf.ancestor(this, 'sam-reporting-header').opts.view === app.REPORTING_VIEW.DATE_WEEK}"></sam-reporting-date-list-header>
	<style scoped type="dcss">
		:scope {
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
		}
		:scope > sam-reporting-content {
			margin-top: 20px;
			margin-bottom: 10px;
		}
	</style>
	<script>
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
		};
		tag.mixin('mdl');

		tag.on("mount", function() {
			tag.refs["filter"].on("apply", applyFilter);
			tag.refs["filter"].on("reset", resetFilter);
			tag.refs["filter"].on("filter-minimized", filterMinimizedHandler);
			addStickyHandlers();
		});

		tag.on("before-unmount", function() {
			tag.refs["filter"].off("apply", applyFilter);
			tag.refs["filter"].off("reset", resetFilter);
			tag.refs["filter"].off("filter-minimized", filterMinimizedHandler);
			removeStickyHandlers();
		});

		tag.on("update", function() {
			removeStickyHandlers();
		});

		tag.on("updated", function() {
			addStickyHandlers();
		});

		function applyFilter(selectedView, selectedPeriods) {
			tag.trigger("apply", selectedView, selectedPeriods);
		}

		function resetFilter() {
			tag.trigger("reset");
		}

		function filterMinimizedHandler(minimized) {
			tag.trigger("filter-minimized", minimized);
		}

		function exportExcelClickHandler(aTag) {
			tag.trigger("export-excel-click", aTag);
		}

		function addStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.on("export-excel-click", exportExcelClickHandler);
			}
		}

		function removeStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.off("export-excel-click", exportExcelClickHandler);
			}
		}
	</script>
</sam-reporting-header>