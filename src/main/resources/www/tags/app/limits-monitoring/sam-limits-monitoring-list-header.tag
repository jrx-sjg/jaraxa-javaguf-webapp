<sam-limits-monitoring-list-header>
	<div class="picture-column"></div>
	<div class="id-column">{guf.i18n.get('app.id').toUpperCase()}</div>
	<div class="student-column flex1">{guf.i18n.get('app.student').toUpperCase()}</div>
	<div if="{opts.view !== app.LIMITS_MONITORING_VIEW.SCHOOL}" class="program-column">{guf.i18n.get('app.program').toUpperCase()}</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.COURSE}" class="course-column">{guf.i18n.get('app.course').toUpperCase()}</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.COURSE}" class="class-column">{guf.i18n.get('app.class').toUpperCase()}</div>
	<div class="absences-column">{guf.i18n.get('app.absences').toUpperCase()}</div>
	<div class="absences-left-column">{guf.i18n.get('app.absences_left').toUpperCase()}</div>
	<div id="exceed-column" class="exceed-column"><i class="material-icons">sentiment_very_dissatisfied</i></div>
	<div class="mdl-tooltip mdl-tooltip--large" for="exceed-column">{guf.i18n.get('app.exceed')}</div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.SCHOOL}" id="exceed-courses-column"><i class="material-icons">school</i></div>
	<div if="{opts.view === app.LIMITS_MONITORING_VIEW.SCHOOL}" class="mdl-tooltip mdl-tooltip--large" for="exceed-courses-column">{guf.i18n.get('app.exceed_courses')}</div>
	<div id="notification-column" class="notification-column"><i class="material-icons-outlined">mail</i></div>
	<div class="mdl-tooltip mdl-tooltip--large" for="notification-column">{guf.i18n.get('app.notification')}</div>
	<div id="meeting-column" class="meeting-column"><i class="material-icons-outlined">thumb_up</i></div>
	<div class="mdl-tooltip mdl-tooltip--large" for="meeting-column">{guf.i18n.get('app.meeting')}</div>
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
			height: 60px;
			border-top-left-radius: 10px;
			border-top-right-radius: 10px;
		}
		:scope > div {
			color: @primary;
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
		:scope > .id-column {
			width: 60px;
			min-width: 60px;
		}
		:scope > .student-column {
			min-width: 200px;
		}
		:scope > .program-column {
			width: 65px;
			min-width: 65px;
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
		}
		:scope > .exceed-courses-column {
			width: 24px;
			min-width: 24px;
		}
		:scope > .notification-column {
			width: 24px;
			min-width: 24px;
		}
		:scope > .meeting-column {
			width: 24px;
			min-width: 24px;
			border-right: 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		tag.on("after-mount", function() {
			var nodes = tag.root.querySelectorAll(".mdl-tooltip");
			for(var i=0; i<nodes.length; i++) {
				componentHandler.upgradeElement(nodes[i]);
			}
		});		

	</script>
</sam-limits-monitoring-list-header>