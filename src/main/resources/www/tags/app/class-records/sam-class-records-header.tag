<sam-class-records-header>
	<sam-class-records-filter ref="filter"></sam-class-records-filter>
	<sam-class-records-content ref="content" if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-class-records-header').opts,'content', true)}" data="{guf.ancestor(this, 'sam-class-records-header').opts.data}"></sam-class-records-content>
	<sam-class-records-list-header if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-class-records-header').opts,'content', true)}"></sam-class-records-list-header>
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

		:scope > sam-class-records-content {
			margin-top: 30px;
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
			tag.refs["filter"].on("go-out", goOutHandler);
			addStickyHandlers();
		});

		tag.on("before-unmount", function() {
			tag.refs["filter"].off("apply", applyFilter);
			tag.refs["filter"].off("reset", resetFilter);
			tag.refs["filter"].off("filter-minimized", filterMinimizedHandler);
			tag.refs["filter"].off("go-out", goOutHandler);
			removeStickyHandlers();
		});

		tag.on("update", function() {
			removeStickyHandlers();
		});

		tag.on("updated", function() {
			addStickyHandlers();
		});

		function applyFilter() {
			tag.trigger("apply");
		}

		function resetFilter() {
			tag.trigger("reset");
		}

		function filterMinimizedHandler(minimized) {
			tag.trigger("filter-minimized", minimized);
		}

		function submitClickHandler(aTag) {
			tag.trigger("submit-click", aTag);
		}

		function goOutHandler() {
			tag.trigger("go-out");
		}

		function addStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.on("submit-click", submitClickHandler);
			}
		}

		function removeStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.off("submit-click", submitClickHandler);
			}
		}
	</script>
</sam-class-records-header>