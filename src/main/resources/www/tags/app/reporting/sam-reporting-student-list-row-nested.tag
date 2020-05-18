<sam-reporting-student-list-row-nested>
	<div class="expand-column"></div>
	<div class="id-column"></div>
	<div class="course-column">{guf.ancestor(this, 'sam-reporting-student-list-row-nested').course}</div>
	<div class="total-absences-column flex1">{guf.ancestor(this, 'sam-reporting-student-list-row-nested').totalAbsences}</div>
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
			border-top: 1px solid @lines;
			height: 40px;
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
			border-right: 1px solid transparent;
		}
		:scope > .expand-column {
			width: 20px;
			min-width: 20px;
		}
		:scope > .id-column {
			width: 70px;
			min-width: 70px;
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

		tag.course = guf.i18n.get("app.course_with_max_abs", tag.item.name, tag.item.maxAbsences);
		tag.totalAbsences = tag.item.totalAbsences;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');
	</script>
</sam-reporting-student-list-row-nested>