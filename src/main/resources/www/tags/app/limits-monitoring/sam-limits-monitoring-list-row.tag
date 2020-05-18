<sam-limits-monitoring-list-row>
	<div class="picture-column"><guf-image class="avatar" imagesrc="{guf.ancestor(this, 'sam-limits-monitoring-list-row').pictureUrl}" loadingsrc="{guf.ancestor(this, 'sam-limits-monitoring-list-row').defaultPictureUrl}" errorsrc="{guf.ancestor(this, 'sam-limits-monitoring-list-row').defaultPictureUrl}" width="70" height="80"></guf-image></div>
	<div class="id-column">
		<div ref="id-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').highlightedStudentId}</div>
	</div>
	<div class="student-column flex1">
		<div ref="student-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').highlightedStudentName}</div>
	</div>
	<div if="{opts.view !== app.LIMITS_MONITORING_VIEW.SCHOOL}" class="program-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').program}</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.COURSE}" class="course-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').course}</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.COURSE}" class="class-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').className}</div>
	<div class="absences-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').absences}</div>
	<div class="absences-left-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').absencesLeft}</div>
	<div class="exceed-column">
		<span class="{contract: guf.ancestor(this, 'sam-limits-monitoring-list-row').exceed === app.EXCEED_WARNING.CONTRACT}">{guf.ancestor(this, 'sam-limits-monitoring-list-row').exceed}</span>
	</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.SCHOOL}" class="exceed-courses-column">{guf.ancestor(this, 'sam-limits-monitoring-list-row').exceedCourses}</div>
	<div class="notification-column"><i if="{guf.ancestor(this, 'sam-limits-monitoring-list-row').notification}" class="material-icons">check_circle_outline</i></div>
	<div class="meeting-column"><i if="{guf.ancestor(this, 'sam-limits-monitoring-list-row').meeting}" class="material-icons-outlined">check_circle_outline</i></div>
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
			height: 80px;
			overflow: hidden;
			cursor: pointer;
		}
		:scope > div {
			color: @lighttext;
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
			justify-content: center;
			font-size: 14px;
			padding-left: 10px;
			padding-right: 10px;
			border-right: 1px solid @background;
		}
		:scope > .picture-column {
			width: 70px;
			min-width: 70px;
			padding: 0;
		}
		:scope > .picture-column > guf-image img {
			object-fit: cover;
			overflow: hidden;
		}
		:scope > .id-column {
			width: 60px;
			min-width: 60px;
		}
		:scope > .student-column {
			min-width: 200px;
			color: @darktext;
			text-decoration: underline;
		}
		:scope > .program-column {
			width: 65px;
			min-width: 65px;
			text-align: center;
		}
		:scope > .course-column {
			width: 300px;
			min-width: 300px;
		}
		:scope > .class-column {
			width: 60px;
			min-width: 60px;
			text-align: center;
		}
		:scope > .absences-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .max-absences-retake-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
			color: @accent;
		}
		:scope > .late-adjustment-column {
			width: 90px;
			min-width: 90px;
			text-align: center;
		}
		:scope > .absences-left-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .exceed-column {
			width: 24px;
			min-width: 24px;
			text-align: center;
		}
		:scope > .exceed-column > .contract {
			color: @accent;
			font-weight: bold;
		}
		:scope > .exceed-column > .material-icons {
			color: @accent;
		}
		:scope > .exceed-courses-column {
			width: 24px;
			min-width: 24px;
			text-align: center;
		}
		:scope > .notification-column {
			width: 24px;
			min-width: 24px;
			color: @accent;
			text-align: center;
		}
		:scope > .meeting-column {
			width: 24px;
			min-width: 24px;
			border-right: 0px;
			color: @accent;
			text-align: center;
		}
		:scope span.highlight {
			color: @textPrimary;
			background-color: @primary;
		}
		:scope > .student-column span.highlight {
			text-decoration: underline;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var studentNameColumn = null;
		var studentIdColumn = null;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"accent": "@accent",
			"background": "@background",
			"darktext": "@darktext",
			"lighttext": "@lighttext",
			"lines": "@lines",
			"textPrimary": "@textPrimary"
		};
		tag.mixin('mdl');

		tag.defaultPictureUrl = "./img/default.png";
		tag.pictureUrl = tag.item.picture ? app.getBaseUrl() + tag.item.picture : tag.defaultPictureUrl;
		tag.studentId = tag.item.studentId;
		tag.studentName = tag.item.lastName + " " + tag.item.firstName;
		if(tag.item.preferredName.length > 0) {
			tag.studentName += " (" + tag.item.preferredName + ")";
		}
		tag.program = tag.item.program;
		tag.course = tag.item.course;
		tag.className = tag.item.className;
		tag.absences = tag.item.totalAbsences;
		tag.maxAbsencesRetake = tag.item.retakeAbsences;
		tag.lateAdjustment = tag.item.lateAdjustment;
		tag.absencesLeft = tag.item.absencesLeft;
		tag.exceed = tag.item.exceed;
		tag.exceedCourses = tag.item.exceedCourses;
		tag.notification = tag.item.notification;
		tag.meeting = tag.item.meeting;
		tag.highlightedStudentName = tag.studentName;
		tag.highlightedStudentId = tag.studentId;

		function clickHandler() {
			tag.trigger("click", tag.item, tag);
		}

		function initView() {
			studentNameColumn = tag.refs["student-column"];
			studentIdColumn = tag.refs["id-column"];
		}

		function initEvents() {
			tag.root.addEventListener("click", clickHandler);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", clickHandler);
		}

		tag.highlightText = function(value) {
			if (value == null) {
				tag.highlightedStudentName = tag.studentName;
				tag.highlightedStudentId = tag.studentId;
			} else {
				tag.highlightedStudentName = app.highlightInString(tag.studentName, value);
				tag.highlightedStudentId = app.highlightInString(tag.studentId, value);
			}
			studentNameColumn.innerHTML = tag.highlightedStudentName;
			studentIdColumn.innerHTML = tag.highlightedStudentId;
		};

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-limits-monitoring-list-row>