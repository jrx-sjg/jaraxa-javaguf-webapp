<sam-pending-class-records-content>
	<div class="flex1"></div>
	<guf-button id="pending-class-records-excel-button" ref="excel-button" type="icon" color="true" icon="table_chart" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
	<div class="mdl-tooltip mdl-tooltip--large" for="pending-class-records-excel-button">{guf.i18n.get('app.export_excel')}</div>
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
	</style>
	<script type="text/javascript">
		var tag = this;

		var exportExcelButton;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		function exportExcelClickHandler() {
			tag.trigger("export-excel-click", tag);
		}

		function initView() {
			exportExcelButton = tag.refs["excel-button"];
		}

		function initEvents() {
			exportExcelButton.on("click", exportExcelClickHandler);
		}

		function removeEvents() {
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
</sam-pending-class-records-content>