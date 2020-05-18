<sam-reporting-student-list-header>
	<div class="expand-column"></div>
	<div class="id-column">{guf.i18n.get('app.number').toUpperCase()}, {guf.i18n.get('app.name').toUpperCase()}</div>
	<div class="course-column">{guf.i18n.get('app.course').toUpperCase()}</div>
	<div class="total-absences-column flex1">{guf.i18n.get('app.total_absences').toUpperCase()}</div>
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
		:scope > .expand-column {
			width: 20px;
			min-width: 20px;
		}
		:scope > .id-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .course-column {
			width: 500px;
		}
		:scope > .total-absences-column {
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
</sam-reporting-student-list-header>