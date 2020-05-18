<sam-roll-call-header>
	<sam-roll-call-filter ref="filter"></sam-roll-call-filter>
	<sam-roll-call-content ref="content" if="{guf.param.booleanExpr(guf.ancestor(this, 'sam-roll-call-header').opts,'content', true)}"></sam-roll-call-content>
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
		:scope > sam-roll-call-content {
			margin-top: 30px;
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

		tag.studentClickHandler = function(classTag, classData, student, studentTag) {
			var content = tag.tags["guf-sticky-header"].refs["content"];
			if (content) {
				content.studentClickHandler(classTag, classData, student, studentTag);
			}
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

		function applyFilter() {
			tag.trigger("apply");
		}

		function resetFilter() {
			tag.trigger("reset");
		}

		function searchHandler(value) {
			if (!!value) tag.trigger("search", value);
		}

		function filterMinimizedHandler(minimized) {
			tag.trigger("filter-minimized", minimized);
		}

		function addStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.on("selector", selectorHandler);
				content.on("search", searchHandler);
			}
		}

		function removeStickyHandlers() {
			var content = tag.refs["content"];
			if (content) {
				content.off("selector", selectorHandler);
				content.off("search", searchHandler);
			}
		}

		function selectorHandler(selector) {
			tag.trigger("selector", selector);
		}
	</script>
</sam-roll-call-header>