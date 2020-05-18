<sam-limits-monitoring-header>
	<sam-limits-monitoring-filter ref="filter"></sam-limits-monitoring-filter>
	<sam-limits-monitoring-content ref="content" if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-limits-monitoring-header').opts,'content', true)}" data="{guf.ancestor(this, 'sam-limits-monitoring-header').opts.data}"></sam-limits-monitoring-content>
	<sam-limits-monitoring-list-header if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-limits-monitoring-header').opts,'content', true)}" view="{guf.ancestor(this, 'sam-limits-monitoring-header').opts.view}"></sam-limits-monitoring-list-header>
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
		:scope > sam-limits-monitoring-content {
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

		tag.getStickyHeight = function() {
			return tag.root.offsetHeight;
		};

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

		function applyFilter(selectedView, selectedExceed, selectedExceedCourses) {
			tag.trigger("apply", selectedView, selectedExceed, selectedExceedCourses);
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

		function searchHandler(value) {
			if (!!value) tag.trigger("search", value);
		}

		function addStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.on("search", searchHandler);
				content.on("export-excel-click", exportExcelClickHandler);
			}
		}

		function removeStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.off("search", searchHandler);
				content.off("export-excel-click", exportExcelClickHandler);
			}
		}
	</script>
</sam-limits-monitoring-header>