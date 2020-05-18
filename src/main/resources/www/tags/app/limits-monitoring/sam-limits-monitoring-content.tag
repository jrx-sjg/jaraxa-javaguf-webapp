<sam-limits-monitoring-content>
	<guf-input ref="search-input" placeholder="{guf.i18n.get('guf.search')}" autocorrect="off" label="v2-outlined" trailing-icon="search" trailing-icon-fn="{guf.ancestor(this,'sam-limits-monitoring-content').search}"></guf-input>
	<div class="flex1"></div>
	<guf-button id="limits-monitoring-excel-button" ref="excel-button" type="icon" color="true" icon="table_chart" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
	<div class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-excel-button">{guf.i18n.get('app.export_excel')}</div>
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
		}
		:scope > guf-input {
			margin-top: -16px;
			margin-bottom: -20px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var searchInput;
		var exportExcelButton;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		function exportExcelClickHandler() {
			tag.trigger("export-excel-click", tag);
		}

		function maybeSearchHandler(value, event) {
			if ((event.key!==null && event.key==="enter") || event.keyCode === 13) {
				tag.search();
			}
		}

		tag.search = function() {
			tag.trigger("search", searchInput.getValue());
		};

		function initView() {
			searchInput = tag.refs["search-input"];
			exportExcelButton = tag.refs["excel-button"];
		}

		function initEvents() {
			searchInput.on("keyup", maybeSearchHandler);
			exportExcelButton.on("click", exportExcelClickHandler);
		}

		function removeEvents() {
			searchInput.off("keyup", maybeSearchHandler);
			exportExcelButton.off("click", exportExcelClickHandler);
		}

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("after-mount", function() {
			var nodes = tag.root.querySelectorAll(".mdl-tooltip");
			for(var i=0; i<nodes.length; i++) {
				componentHandler.upgradeElement(nodes[i]);
			}
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-limits-monitoring-content>