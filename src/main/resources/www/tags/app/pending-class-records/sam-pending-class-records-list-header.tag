<sam-pending-class-records-list-header>
	<div class="year-column">{guf.i18n.get('app.year').toUpperCase()}</div>
	<div class="semester-column">{guf.i18n.get('app.semester').toUpperCase()}</div>
	<div class="program-column">{guf.i18n.get('app.program').toUpperCase()}</div>
	<div class="course-column">{guf.i18n.get('app.course').toUpperCase()}</div>
	<div class="class-column">{guf.i18n.get('app.class').toUpperCase()}</div>
	<div class="teacher-column flex1">{guf.i18n.get('app.teacher').toUpperCase()}</div>
	<div class="missing-week-column">{guf.i18n.get('app.week').toUpperCase()}</div>
	<div class="status-column">{guf.i18n.get('app.status').toUpperCase()}</div>
	<div class="actions-column"></div>
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
			height: 45px;
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
			padding-left: 16px;
			padding-right: 16px;
			border-right: 1px solid @background;
		}
		:scope > .year-column {
			width: 40px;
		}
		:scope > .semester-column {
			width: 70px;
		}
		:scope > .program-column {
			width: 65px;
		}
		:scope > .course-column {
			width: 300px;
		}
		:scope > .class-column {
			width: 60px;
		}
		:scope > .teacher-column {
			min-width: 150px;
		}
		:scope > .missing-week-column {
			width: 40px;
			text-align: center;
		}
		:scope > .status-column {
			width: 65px;
		}
		:scope > .actions-column {
			width: 50px;
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
</sam-pending-class-records-list-header>