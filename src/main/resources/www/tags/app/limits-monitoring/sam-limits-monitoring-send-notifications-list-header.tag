<sam-limits-monitoring-send-notifications-list-header>
	<div class="level-column">{guf.i18n.get('app.level').toUpperCase()}</div>
	<div class="process-description-column flex1">{guf.i18n.get('app.process_description').toUpperCase()}</div>
	<div class="program-column">{guf.i18n.get('app.program').toUpperCase()}</div>
	<div class="course-column flex1">{guf.i18n.get('app.course').toUpperCase()}</div>
	<div class="warning-column">{guf.i18n.get('app.warning_absences').toUpperCase()}</div>
	<div class="warning-column">{guf.i18n.get('app.warning_courses').toUpperCase()}</div>
	<div class="latest-date-column">{guf.i18n.get('app.latest_date').toUpperCase()}</div>
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
			height: 40px;
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
		:scope > .level-column {
			width: 70px;
			min-width: 70px;
		}
		:scope > .process-description-column {
			width: 40px;
			min-width: 40px;
		}
		:scope > .program-column {
			min-width: 100px;
		}
		:scope > .course-column {
			width: 100px;
		}
		:scope > .warning-column {
			width: 80px;
			padding: 0 4px;
			text-align: center;
		}
		:scope > .latest-date-column {
			width: 80px;
			min-width: 80px;
			padding: 0 4px;
			text-align: center;
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
		tag.mixin('mdl');
	</script>
</sam-limits-monitoring-send-notifications-list-header>