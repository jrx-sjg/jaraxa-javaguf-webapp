<sam-roll-call-marked-student>
	<div class="left-column flex1">
		<div class="profile flex1">
			<guf-image class="avatar" imagesrc="{guf.ancestor(this, 'sam-roll-call-marked-student').pictureUrl}" loadingsrc="{guf.ancestor(this, 'sam-roll-call-marked-student').defaultPictureUrl}" errorsrc="{guf.ancestor(this, 'sam-roll-call-marked-student').defaultPictureUrl}" width="60" height="60"></guf-image>
			<guf-linear-layout class="info-container" orientation="vertical">
				<div class="preferred-name flex1" ref="preferred-name">{guf.ancestor(this, 'sam-roll-call-marked-student').preferredName}</div>
				<div class="name flex1" ref="fullname">{guf.ancestor(this, 'sam-roll-call-marked-student').fullName}</div>
				<div class="student-id flex1" ref="student-id">{guf.ancestor(this, 'sam-roll-call-marked-student').studentId}</div>
			</guf-linear-layout>
		</div>
		<div class="toolbar">
			<guf-button ref="delete-button" type="flat" color="true" icon="delete_outline" dcss-background="@lighttext" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines">{guf.i18n.get('guf.delete')}</guf-button>
			<div class="flex1"></div>
			<guf-button ref="save-button" type="flat" color="true" icon="save" dcss-background="@primary" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines">{guf.i18n.get('guf.save')}</guf-button>
			<guf-button ref="submit-button" type="flat" color="true" icon="arrow_downward" dcss-background="@primary" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines">{guf.i18n.get('app.submit')}</guf-button>
		</div>
	</div>
	<sam-roll-call-absences-list ref="absences-list" class="absences-list" periods={app.rollCall.getAbsences(guf.ancestor(this, 'sam-roll-call-marked-student').student)}></sam-roll-call-absences-list>
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
			border: 1px solid @lines;
			border-radius: 8px;
			box-sizing: border-box;
			overflow: hidden;
		}
		:scope > .left-column {
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
			border-right: 1px solid @lines;
		}
		:scope > .left-column > .profile {
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
			align-items: center;
			border-bottom: 1px solid @lines;
			padding-left: 20px;
		}
		:scope > .left-column > .profile > .avatar img {
			object-fit: cover;
			border: 1px solid @lines;
			border-radius: 50%;
		}
		:scope > .left-column > .profile > .info-container {
			padding: 10px;
		}
		:scope > .left-column > .profile > .info-container > .preferred-name {
			font-size: 16px;
			font-weight: 600;
			color: @primary;
		}
		:scope > .left-column > .profile > .info-container > .name {
			font-size: 15px;
			font-weight: 600;
			color: @lighttext;
		}
		:scope > .left-column > .profile > .info-container > .student-id {
			font-size: 13px;
			color: @lighttext;
		}
		:scope > .left-column > .toolbar {
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
			align-items: center;
			height: 40px;
		}
		:scope > .absences-list {
			border: 0px;
			border-radius: 0px;
		}

		:scope span.highlight {
			color: @textPrimary;
			background-color: @primary;
		}		
	</style>
	<script type="text/javascript">
		var tag = this;
		var currentState = app.STUDENT_STATE.DEFAULT;
		var deleteButton, saveButton, submitButton, absencesList;
		var preferredNameLabel, fullNameLabel, studentIdLabel;
		var highlightedText = null;

		tag.preferredName = tag.student.preferredName || tag.student.firstName;
		tag.fullName = tag.student.lastName + " " + tag.student.firstName;
		tag.studentId = tag.student.id;
		tag.highlightedPreferredName = tag.preferredName;
		tag.highlightedFullName = tag.fullName;
		tag.highlightedStudentId = tag.studentId;
		tag.defaultPictureUrl = "./img/default.png";
		tag.pictureUrl = tag.student.pictureUrl ? app.getBaseUrl() + tag.student.pictureUrl : tag.defaultPictureUrl;
		tag.periods = opts.periods || [];
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lighttext": "@lighttext",
			"lines": "@lines",
			"background": "@background",
			"textPrimary": "@textPrimary"
		};
		tag.mixin('mdl', 'after-mount');

		function updateButtonsState() {
			var serverAbsences = app.rollCall.getServerAbsences(tag.student);
			var currentAbsences = absencesList.getData();
			if(app.rollCall.canDeleteAbsences(serverAbsences, currentAbsences)) {
				deleteButton.enable();
			} else {
				deleteButton.disable();
			}
			if(app.rollCall.canSaveAbsences(serverAbsences, currentAbsences)) {
				saveButton.enable();
			} else {
				saveButton.disable();
			}
			if(app.rollCall.canSubmitAbsences(serverAbsences, currentAbsences)) {
				submitButton.enable();
			} else {
				submitButton.disable();
			}
		}

		function deleteButtonClickHandler(e) {
			guf.console.log("deleteButtonClickHandler");
			tag.trigger("delete-click", tag, tag.student, absencesList.getData());
		}

		function saveButtonClickHandler(e) {
			tag.trigger("save-click", tag, tag.student, absencesList.getData());
		}

		function submitButtonClickHandler(e) {
			guf.console.log("submitButtonClickHandler");
			tag.trigger("submit-click", tag, tag.student, absencesList.getData());
		}

		function absenceClickHandler(itemTag, absencesData) {
			guf.console.log("absenceClickHandler", absencesList.getData());
			updateButtonsState();
			tag.trigger("absence-click", tag, tag.student, absencesData);
		}

		function lateClickHandler(itemTag, absencesData) {
			guf.console.log("lateClickHandler", absencesList.getData());
			updateButtonsState();
			tag.trigger("late-click", tag, tag.student, absencesData);
		}

		function initView() {
			deleteButton = tag.refs["delete-button"];
			saveButton = tag.refs["save-button"];
			submitButton = tag.refs["submit-button"];
			absencesList = tag.tags["sam-roll-call-absences-list"];
			preferredNameLabel = tag.tags["guf-linear-layout"].refs["preferred-name"];
			fullNameLabel = tag.tags["guf-linear-layout"].refs["fullname"];
			studentIdLabel = tag.tags["guf-linear-layout"].refs["student-id"];			
		}

		function initEvents() {
			deleteButton.on("click", deleteButtonClickHandler);
			saveButton.on("click", saveButtonClickHandler);
			submitButton.on("click", submitButtonClickHandler);
			absencesList.on("absence-click", absenceClickHandler);
			absencesList.on("late-click", lateClickHandler);
		}

		function removeEvents() {
			deleteButton.off("click", deleteButtonClickHandler);
			saveButton.off("click", saveButtonClickHandler);
			submitButton.off("click", submitButtonClickHandler);
			absencesList.off("absence-click", absenceClickHandler);
			absencesList.off("late-click", lateClickHandler);
		}

		tag.getData = function() {
			var student = guf.utils.cloneObject(tag.student);
			student.markedAbsences = absencesList.getData();
			return student;
		};

		tag.highlightText = function(value) {
			highlightedText = value;
			if (value == null) {
				tag.highlightedPreferredName = tag.preferredName;
				tag.highlightedFullName = tag.fullName;
				tag.highlightedStudentId = tag.studentId;
			} else {
				tag.highlightedPreferredName = app.highlightInString(tag.preferredName, value);
				tag.highlightedFullName = app.highlightInString(tag.fullName, value);
				tag.highlightedStudentId = app.highlightInString(tag.studentId, value);
			}
			preferredNameLabel.innerHTML = tag.highlightedPreferredName;
			fullNameLabel.innerHTML = tag.highlightedFullName;
			studentIdLabel.innerHTML = tag.highlightedStudentId;
		};

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("after-mount", function() {
			updateButtonsState();
		});

		tag.on("updated", function() {
			absencesList.setData(app.rollCall.getAbsences(tag.student));
			updateButtonsState();
			tag.highlightText(highlightedText);
		});
	</script>
</sam-roll-call-marked-student>