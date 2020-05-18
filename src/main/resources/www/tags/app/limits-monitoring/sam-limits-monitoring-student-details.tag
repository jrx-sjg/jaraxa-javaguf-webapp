<sam-limits-monitoring-student-details>
	<div class="header">{guf.i18n.get('app.student_details').toUpperCase()}</div>
	<guf-linear-layout orientation="horizontal" class="content">
		<guf-image class="avatar" ref="avatar" imagesrc="{guf.ancestor(this, 'sam-limits-monitoring-student-details').pictureUrl}" loadingsrc="{guf.ancestor(this, 'sam-limits-monitoring-student-details').defaultPictureUrl}" errorsrc="{guf.ancestor(this, 'sam-limits-monitoring-student-details').defaultPictureUrl}" width="80" height="80"></guf-image>
		<div class="list">
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.student_id')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').studentId}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.student_name')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').studentName}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.campus')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').campus}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.period')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').period}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.program')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').program}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item item-title="{guf.i18n.get('app.student_class')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').studentClass}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item if="{guf.ancestor(this, 'sam-limits-monitoring-student-details').showAbsencesLeft}" item-title="{guf.i18n.get('app.absences_left')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').absencesLeft}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item if="{guf.ancestor(this, 'sam-limits-monitoring-student-details').showMaxAbsencesRetake}" item-title="{guf.i18n.get('app.max_absences_retake')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').maxAbsencesRetake}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item if="{guf.ancestor(this, 'sam-limits-monitoring-student-details').showAdjustmentLate}" item-title="{guf.i18n.get('app.adjustment_late_arrival')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').adjustmentLateArrival}"></sam-limits-monitoring-student-detail-item>
			<sam-limits-monitoring-student-detail-item if="{guf.ancestor(this, 'sam-limits-monitoring-student-details').showMaxAbsencesContract}" item-title="{guf.i18n.get('app.max_absences_contract')}" item-content="{guf.ancestor(this, 'sam-limits-monitoring-student-details').maxAbsencesContract}"></sam-limits-monitoring-student-detail-item>
		</div>
	</guf-linear-layout>
	<style scoped type="dcss">
		:scope {
			border: 1px solid @lines;
			border-radius: 10px;
		}
		:scope > .header {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			align-items: center;
			border-bottom: 1px solid @lines;
			color: @primary;
			padding: 0px 10px;
			height: 35px;
		}
		:scope > .content {
			padding: 10px;
		}
		:scope > .content > guf-image {
			width: 80px;
			height: 80px;
			margin-right: 10px;
		}
		:scope > .content > guf-image img {
			object-fit: cover;
			overflow: hidden;
			border-radius: 50%;
		}
		:scope > .content > .list > sam-limits-monitoring-student-detail-item {
			margin-bottom: 4px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		setContentData();

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function formatMultiValueText(values) {
			var resultText = "";
			if (!values) {
				return resultText;
			}
			for (var i = 0; i < values.length; i++) {
				if (i > 0) {
					resultText += ", ";
				}
				resultText += values[i];
			}
			return resultText;
		}

		function setContentData() {
			var student = opts.student || {};

			tag.defaultPictureUrl = "./img/default.png";
			tag.pictureUrl = student.picture ? app.getBaseUrl() + student.picture : tag.defaultPictureUrl;

			student = student.sectionStudentDetails || {};
			tag.studentName = student.studentLastName + " " + student.studentFirstName;
			if(student.studentPreferredName && student.studentPreferredName.length > 0) {
				tag.studentName += " (" + student.studentPreferredName + ")";
			}
			tag.studentId = student.studentId;
			tag.studentClass = formatMultiValueText(student.classes);
			tag.campus = student.campus;
			tag.period = student.period;
			tag.program = formatMultiValueText(student.programs || []) ;
			tag.showAbsencesLeft = guf.isDefined("absencesLeft", student) ? true : false;
			tag.absencesLeft = student.absencesLeft;
			tag.showMaxAbsencesRetake = app.hasRole(app.ROLE.LRM_ADMIN) ? true : false;
			tag.maxAbsencesRetake = student.maxAbsencesRetake;
			tag.showAdjustmentLate = app.hasRole(app.ROLE.LRM_ADMIN) ? true : false;
			tag.adjustmentLateArrival = student.maxLateAdjustment;
			tag.showMaxAbsencesContract = app.hasRole(app.ROLE.LRM_ADMIN) ? true : false;
			tag.maxAbsencesContract = student.maxAbsencesContract;
		}

		tag.on("update", function() {
			setContentData();
			tag.tags["guf-linear-layout"].refs["avatar"].setImage(tag.pictureUrl);
		});
	</script>
</sam-limits-monitoring-student-details>