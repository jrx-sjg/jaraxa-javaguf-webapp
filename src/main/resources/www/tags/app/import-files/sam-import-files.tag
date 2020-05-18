<sam-import-files>
	<guf-linear-layout ref="container" orientation="vertical" class="container">
		<div class="header">{guf.i18n.get("app.import_files")}</div>
		<sam-empty if="{guf.ancestor(this, 'sam-import-files').loading}" class="flex1" src="img/loading.gif" text="{guf.i18n.get('app.loading_data')}"></sam-empty>
		<guf-linear-layout if="{!guf.ancestor(this, 'sam-import-files').loading}" ref="table" orientation="vertical">
			<sam-import-file each={tableId, tableName in app.TABLE} data="{guf.ancestor(this,'sam-import-files').lastExecutionData}"></sam-import-file>
		</guf-linear-layout>
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
		}
		:scope > guf-linear-layout > div.header {
			color: @primary;
			font-family: chronicle-deck, serif;
			font-size: 22px;
			height: 24px;
			font-weight:600;
			margin: 26px;
		}
		:scope > guf-linear-layout > guf-linear-layout[ref="table"] {
			border: 1px solid @lines;
			border-radius: 10px;
			margin: 0 26px 20px;
			padding: 40px 10px;
		}
		:scope > guf-linear-layout > guf-linear-layout[ref="table"] > sam-import-file {
			margin-bottom: 20px;
		}
	</style>
	<script>
		var tag = this;
		tag.lastExecutionData = [];
		tag.loading = true;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function loadLastExecutionData() {
			var loadLastExecutionDataPromise = new Promise(function(resolve, reject) {
				app.ajax.get("api/upload", {
				}, function(response, xhr) {
					if (response.success) {
						resolve(response.data);
					} else {
						resolve(false);
					}
				}, function(response, xhr) {
					guf.console.error("Error getting last execution data", response);
					reject();
				});
			});

			loadLastExecutionDataPromise.then(function(result) {
				tag.loading = false;
				tag.lastExecutionData = result;
				tag.update();
			});
		}

		tag.on("mount", function() {
			loadLastExecutionData();
		});

		tag.on("before-unmount", function() {
		});

		tag.on("update", function() {
		});
	</script>
</sam-import-files>