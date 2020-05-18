<sam-import-file>
	<guf-linear-layout ref="column" orientation="vertical" class="column" v-align="center" h-align="center">
		<guf-linear-layout ref="container" orientation="horizontal" class="container" v-align="center" h-align="center">
			<div class="name">{guf.ancestor(this, 'sam-import-file').tableName}</div>
			<input name="{guf.ancestor(this, 'sam-import-file').tableName}" type="file" ref="file-input" accept=".csv,text/csv"></input>
			<guf-button ref="select-file" riiple="true" type="outline" color="true" dcss-text-color-disabled="@disabled">
				<i class="material-icons">cloud_upload</i>
				{guf.i18n.get('app.select_file')}
			</guf-button>
			<guf-chip ref="file-chip" deletable="true" hidden="{guf.ancestor(this, 'sam-import-file').currentFile == null}" text="{guf.ancestor(this, 'sam-import-file').currentFileName}"></guf-chip>
			<div ref="progresstext" hidden="{!guf.ancestor(this, 'sam-import-file').sending}">{guf.ancestor(this, 'sam-import-file').actionText}</div>
			<div class="progresscontainer" hidden="{!guf.ancestor(this, 'sam-import-file').sending}"><div ref="progress" style="width:{guf.ancestor(this, 'sam-import-file').progressWidth}; margin-left:{guf.ancestor(this, 'sam-import-file').progressMargin}; background-color:{guf.ancestor(this, 'sam-import-file').progressColor};"></div></div>
			<div hidden="{guf.ancestor(this, 'sam-import-file').sending}" class="flex1"></div>
			<guf-button ref="import-file" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled" disabled="true">{guf.i18n.get('app.import')}</guf-button>
		</guf-linear-layout>
		<guf-linear-layout ref="result" orientation="vertical" class="column" v-align="center" h-align="center" if="{guf.ancestor(this, 'sam-import-file').uploadResult != null}">
			<div if="{guf.isDefined("data.processedLines", guf.ancestor(this, 'sam-import-file').uploadResult)}"><b>{guf.i18n.get('app.message')}:</b> {guf.ancestor(this, 'sam-import-file').messageText}</div>
			<div class="margin" if="{guf.isDefined("data.invalidLine",guf.ancestor(this, 'sam-import-file').uploadResult)}"><b>{guf.i18n.get('app.invalid_line')}:</b> <tt>{guf.ancestor(this, 'sam-import-file').uploadResult.data.invalidLine}</tt></div>
			<div class="margin" if="{guf.isDefined("data.error", guf.ancestor(this, 'sam-import-file').uploadResult)}"><b>{guf.i18n.get('app.import_error')}:</b> {guf.ancestor(this, 'sam-import-file').uploadResult.data.error}</div>
			<div class="margin" if="{guf.isDefined("data.invalidFields",guf.ancestor(this, 'sam-import-file').uploadResult) && !guf.isEmptyObject(guf.ancestor(this, 'sam-import-file').uploadResult.data.invalidFields, true)}"><b>{guf.i18n.get('app.invalid_fields')}:</b>
				<ul>
					<li each="{item,index in guf.ancestor(this, 'sam-import-file').uploadResult.data.invalidFields}">
						<b>{index}</b>: {item}
					</li>
				</ul>
			</div>
		</guf-linear-layout>
		<guf-linear-layout if="{guf.ancestor(this, 'sam-import-file').uploadResult == null}" ref="info-last-execution" orientation="horizontal" v-align="left" h-align="bottom">
			<div class="last-execution-date">{guf.i18n.get("app.last_execution")}: {guf.ancestor(this, 'sam-import-file').lastExecutionDate}</div>
			<div class="last-execution-result">{guf.i18n.get("app.result")}: {guf.ancestor(this, 'sam-import-file').lastExecutionResult}</div>
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
			border: 1px solid @lines;
			border-radius: 10px;
			padding: 2px;
		}
		:scope > guf-linear-layout.column {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			border: 2px dashed #fff;
			border-radius: 10px;
			padding: 5px 5px 0;
		}
		:scope > guf-linear-layout.column > * {
			width: 100%;
		}
		:scope > guf-linear-layout.column.drag {
			background: @background;
			border-radius: 10px;
			border: 2px dashed @lines;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container {
			min-height: 32px;
			padding-bottom: 7px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > div.name {
			font-size: 16px;
			margin: 0px 12px;
			min-width: 300px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > input[ref="file-input"] {
			display:none;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > guf-button[ref="select-file"] i.material-icons {
			height:28px;
			margin-right:10px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > guf-chip[ref="file-chip"] {
			margin: 0px 12px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > guf-chip[ref="file-chip"] .mdl-chip__text {
			font-size:14px;			
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > div[ref=progresstext] {
			font:8pt;
			color:@darktext;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > div.progresscontainer {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			height:10px;
			background-color:@lines;
			margin-left:10px;
			margin-right:20px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > div.progresscontainer > div[ref=progress] {
			width:0px;
			height:100%;
		}
		:scope > guf-linear-layout.column > guf-linear-layout.container > guf-button[ref="import-file"] {
			maring-right:12px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="result"] {
			border-top: 1px solid @lines;
			padding:10px 10px 5px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="result"] > div {
			width:100%;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="result"] > div.margin {
			margin-top:10px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="result"] > div.margin > ul {
			margin: 0;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="info-last-execution"] {
			font-size: 12px;
			margin: 0 12px;
			border-top: 1px solid @lines;
			padding:10px 10px 5px;
		}
		:scope > guf-linear-layout.column > guf-linear-layout[ref="info-last-execution"] > div {
			color:@primary;
			margin: 0 12px;
		}
	</style>
	<script>
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"background": "@background",
			"darktext": "@darktext"
		};
		tag.mixin('mdl');
		tag.currentFile = null;
		tag.currentFileName = null;
		tag.sending = false;
		tag.progressWidth = "0%";
		tag.progressMargin = "0%";
		tag.progressColor = guf.dcss.theme.primary;
		tag.actionText = "";
		tag.messageText = "";
		tag.uploadResult = null;
		tag.lastExecutionDate = "-";
		tag.lastExecutionResult = "-";

		var dragZone = null;
		var selectFileBtn = null;
		var fileInput = null;
		var fileChip = null;
		var importFileBtn = null;
		var processingInterval = null;
		var processingProgress = 0;

		function dragNDropHandler(evt) {
			evt.preventDefault();
			evt.stopPropagation();
			switch (evt.type) {
				case "dragover":
				case "dragenter":
					dragZone.root.classList.add("drag");
					evt.dataTransfer.dropEffect = "copy";
					break;
				case "drop":
				case "dragleave":
				case "dragend":
					dragZone.root.classList.remove("drag");
					evt.dataTransfer.dropEffect = "none";
					break;
			}
			if (evt.type == "drop") {
				checkFileImport(evt.dataTransfer.files[0]);
			}
		}

		function selectFileClickHandler() {
			fileInput.click();
		}

		function resetState() {
			fileInput.value = "";
			tag.currentFile = null;
			tag.currentFileName = null;
			tag.sending = false;
			tag.uploadResult = null;
			updateTag();
		}

		function fileInputChangeHandler() {
			if (fileInput && fileInput.files && fileInput.files.length > 0) {
				checkFileImport(fileInput.files[0]);
				return;
			}
			resetState();
		}

		function deleteFileHandler() {
			resetState();
		}

		function uploadFileHandler() {
			var formData = new FormData();
			formData.append("file", tag.currentFile);
			var xhr = null;
			tag.sending = true;
			tag.progressColor = guf.dcss.theme.primary;
			sendAjaxCall = app.ajax.post("api/upload/files/" + tag.tableId, {
				fileUpload: true,
				auth: true,
				body: formData
			}, function(response) {
				guf.console.log("File Uploaded", response);
				xhr.upload.removeEventListener("progress", uploadProgressHandler);
				if (processingInterval != null) {
					guf.clearInterval(processingInterval);
					processingInterval = null;
				}
				tag.progressWidth = "100%";
				tag.progressMargin = "0%";
				if (response.success) {
					tag.actionText = guf.i18n.get("app.completed");
					tag.messageText = guf.i18n.get("app.import_success", [response.data.processedLines]);
					tag.progressColor = "#0C0";
				} else {
					tag.actionText = guf.i18n.get("guf.error");
					tag.messageText = guf.i18n.get("app.import_failure", [response.data.processedLines+1]);
					tag.progressColor = "#C00";
				}
				tag.uploadResult = response;
				var timestamp = guf.date(response.data.timestamp);
				if (timestamp.isValid()) {
					timestamp = timestamp.tz(guf.date.localTimeZone).format("L HH:mm:ss");
				} else {
					timestamp = "-";
				}
				tag.setLastExecutionDate(response.data.timestamp);
				tag.setLastExecutionResult((response.success) ? "OK" : "KO");
				updateTag();
			}, function(response) {
				guf.console.error("Error uploading", response);
				xhr.upload.removeEventListener("progress", uploadProgressHandler);
				if (processingInterval != null) {
					guf.clearInterval(processingInterval);
					processingInterval = null;
				}
				tag.actionText = guf.i18n.get("guf.error");
				tag.messageText = "";
				tag.progressWidth = "100%";
				tag.progressMargin = "0%";
				tag.progressColor = "#C00";
				tag.uploadResult = response;
				updateTag();
			}, null, false, 0);
			xhr = guf.ajax.getXhr(sendAjaxCall);
			xhr.upload.addEventListener("progress", uploadProgressHandler);
			updateTag();
		}

		function setLastExecutionData() {
			var lastExecutionData = opts.data;
			var extractData = lastExecutionData.filter(function(data) {
				return data.type == tag.tableId;
			});
			if (extractData.length > 0) {
				var timestamp = guf.date(extractData[0].timestamp);
				if (timestamp.isValid()) {
					timestamp = timestamp.tz(guf.date.localTimeZone).format("L HH:mm:ss");
				} else {
					timestamp = "-";
				}
				tag.setLastExecutionDate(timestamp);
				tag.setLastExecutionResult((extractData[0].result.success) ? "OK" : "KO");
			}
			tag.update();
		}

		function simulateProcessing() {
			processingProgress++;
			if (processingProgress > 95) {
				processingProgress = 0;
			}
			tag.progressMargin = processingProgress + "%";
			updateTag();
		}

		function uploadProgressHandler (e) {
			var pc = parseInt((e.loaded / e.total * 100));
			if(pc >= 100) {
				pc = 100;
				tag.progressWidth = "5%";
				tag.actionText = guf.i18n.get("app.processing");
				tag.messageText = "";
				processingProgress = 0;
				if (processingInterval == null) {
					processingInterval = guf.setInterval(simulateProcessing, 50);
				}
			} else {
				tag.progressWidth = pc + "%";
				tag.actionText = guf.i18n.get("app.uploading", tag.progressWidth);
				tag.messageText = "";
			}
			updateTag();
		}

		function checkFileImport(file) {
			tag.currentFileName = file.name;
			var fileParts = tag.currentFileName.split(".");
			var fileExtension = fileParts[fileParts.length - 1];
			if(fileExtension && fileExtension.toLowerCase() == "csv") {
				tag.currentFile = file;
				tag.sending = false;
				tag.uploadResult = null;
				updateTag();
			} else {
				guf.createSnackbar(guf.i18n.get("app.incompatible_file_type"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				resetState();
			}
		}

		function updateTag() {
			tag.update();
			if (tag.currentFile == null || tag.sending) {
				importFileBtn.disable();
			} else {
				importFileBtn.enable();
			}
			if (tag.currentFile != null) {
				selectFileBtn.disable();
			} else {
				selectFileBtn.enable();
			}
		}

		function initEvents() {
			selectFileBtn.on('click', selectFileClickHandler);
			dragZone.root.addEventListener('drag', dragNDropHandler);
			dragZone.root.addEventListener('dragstart', dragNDropHandler);
			dragZone.root.addEventListener('dragend', dragNDropHandler);
			dragZone.root.addEventListener('dragover', dragNDropHandler);
			dragZone.root.addEventListener('dragenter', dragNDropHandler);
			dragZone.root.addEventListener('dragleave', dragNDropHandler);
			dragZone.root.addEventListener('drop', dragNDropHandler);
			fileInput.addEventListener('change', fileInputChangeHandler);
			fileChip.on('delete-click', deleteFileHandler);
			importFileBtn.on('click', uploadFileHandler);
		}

		function removeEvents() {
			selectFileBtn.off('click', selectFileClickHandler);
			dragZone.root.removeEventListener('drag', dragNDropHandler);
			dragZone.root.removeEventListener('dragstart', dragNDropHandler);
			dragZone.root.removeEventListener('dragend', dragNDropHandler);
			dragZone.root.removeEventListener('dragover', dragNDropHandler);
			dragZone.root.removeEventListener('dragenter', dragNDropHandler);
			dragZone.root.removeEventListener('dragleave', dragNDropHandler);
			dragZone.root.removeEventListener('drop', dragNDropHandler);
			fileInput.removeEventListener('change', fileInputChangeHandler);
			fileChip.off('delete-click', deleteFileHandler);
			importFileBtn.off('click', uploadFileHandler);
		}

		function initReferences() {
			dragZone = tag.refs["column"];
			selectFileBtn = tag.refs["column"].refs["container"].refs["select-file"];
			fileInput = tag.refs["column"].refs["container"].refs["file-input"];
			fileChip = tag.refs["column"].refs["container"].refs["file-chip"];
			importFileBtn = tag.refs["column"].refs["container"].refs["import-file"];
		}

		tag.setLastExecutionDate = function(timestamp) {
			tag.lastExecutionDate = timestamp;
		}

		tag.setLastExecutionResult = function(result) {
			tag.lastExecutionResult = result;
		}

		tag.on("mount", function() {
			initReferences();
			initEvents();
			setLastExecutionData();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
		});
	</script>
</sam-import-file>