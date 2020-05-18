<sam-class-records-list-header>
	<div class="picture-column"></div>
	<div class="id-column">{guf.i18n.get('app.id').toUpperCase()}</div>
	<div class="student-column flex1">{guf.i18n.get('app.student').toUpperCase()}</div>
	<div class="day-column">{guf.i18n.get('app.monday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.tuesday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.wednesday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.thursday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.friday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.saturday_acronym')}</div>
	<div class="day-column">{guf.i18n.get('app.sunday_acronym')}</div>
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
		}
		:scope > .picture-column {
			width: 70px;
			border-right: 1px solid @background;
		}
		:scope > .id-column {
			width: 100px;
			border-right: 1px solid @background;
			margin-left: 16px;
		}
		:scope > .student-column {
			margin-left: 16px;
		}
		:scope > .day-column {
			width: 70px;
			border-left: 1px solid @background;
			align-items: center;
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
</sam-class-records-list-header>