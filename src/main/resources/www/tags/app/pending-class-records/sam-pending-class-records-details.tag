<sam-pending-class-records-details>
	<div class="actions">
		<guf-button ref="back-button" type="flat" color="true" icon="arrow_back" icon-outlined="true" dcss-border="1px solid @lines">{guf.i18n.get('guf.back')}</guf-button>
		<guf-button ref="submit-button" type="flat" color="true" icon="arrow_downward" icon-outlined="true" dcss-border="1px solid @lines" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines" disabled="true">{guf.i18n.get('app.submit')}</guf-button>
	</div>
	<sam-class-title ref="title" anchor="false" if="{guf.ancestor(this, 'sam-pending-class-records-details').classRecordsData != null}">{guf.ancestor(this, 'sam-pending-class-records-details').classTitle}</sam-class-title>
	<sam-class-records-list-header if="{guf.ancestor(this, 'sam-pending-class-records-details').classRecords.length > 0}"></sam-class-records-list-header>
	<div ref="content" class="content flex1" if="{guf.ancestor(this, 'sam-pending-class-records-details').classRecordsData != null}">
		<sam-empty if="{guf.ancestor(this, 'sam-pending-class-records-details').classRecords.length == 0}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.class_records_no_absences_text')}"></sam-empty>
		<div class="list-block" if="{guf.ancestor(this, 'sam-pending-class-records-details').classRecords.length > 0}">
			<sam-class-records-list-row each={classrecords in guf.ancestor(this, 'sam-pending-class-records-details').classRecords}></sam-class-records-list-row>
		</div>
	</div>
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
			background-color: @lightestbackground;
			padding: 26px;
		}
		:scope > .content {
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
			overflow: auto;
		}
		:scope > .content > .list-block {
		}
		:scope > .content > .list-block > sam-class-records-list-row {
			border: 1px solid @lines;
			border-top: 0px;
		}
		:scope > .content > .list-block > sam-class-records-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
		:scope > .actions {
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
			justify-content: flex-end;
			overflow: auto;
			margin-bottom: 16px;
		}
		:scope > .actions > guf-button {
			margin-left: 16px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var filter = opts.filter;
		var submitButton = null;

		tag.classRecordsData = null;
		tag.classRecords = [];
		tag.classTitle = "";
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');

		function getFilterResume(item) {
			if(item != null) {
				var separator = " / ";
				var result = item.period + separator + item.program + separator + item.course + separator + guf.i18n.get('app.class') + " " + item.className;
				return result;
			} else {
				return "";
			}
		}

		function getDetails() {
			tag.loading = true;
			var params = {
				year: filter.year,
				semester: filter.semester,
				program: filter.program,
				course: filter.course,
				className: filter.className,
				week: filter.week
			};
			app.ajax.get("api/pendingclassrecords/details", params, function(response, xhr) {
				guf.console.log("pendingclassrecords details results", response.data);
				tag.loading = false;
				tag.classRecordsData = guf.utils.cloneObject(response.data);
				tag.classTitle = getFilterResume(tag.classRecordsData);
				tag.classRecords = tag.classRecordsData.classrecords;
				if(tag.classRecordsData.canSubmit) {
					submitButton.enable();
				} else {
					submitButton.disable();
				}
				tag.update();
			}, function(response, xhr) {
				guf.console.error("Error getting pending class records details", response);
			});
			tag.update();
		}

		function backClickHandler() {
			tag.trigger("back-click", tag, tag.classRecordsData);
		}

		function submitClickHandler() {
			submitButton.disable();
			var params = {
				year: filter.year,
				semester: filter.semester,
				program: filter.program,
				course: filter.course,
				className: filter.className,
				week: filter.week,
				teacher: filter.teacher,
				submitted: 1
			};
			app.ajax.put("api/pendingclassrecords/save", params, function(response, xhr) {
				guf.console.log("pendingclassrecords save details results", response.data);
				params.status = 1;
				tag.trigger("submitted", tag, params);
			}, function(response, xhr) {
				guf.console.error("Error saving pending class records details", response);
				submitButton.enable();
			});
		}

		function initView() {
			submitButton = tag.refs["submit-button"];
		}

		function initEvents() {
			tag.refs["back-button"].on("click", backClickHandler);
			submitButton.on("click", submitClickHandler);
		}

		function removeEvents() {
			tag.refs["back-button"].off("click", backClickHandler);
			submitButton.off("click", submitClickHandler);
		}

		tag.on("mount", function() {
			initView();
			initEvents();
			getDetails();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-pending-class-records-details>