<sam-reporting-date-list-row-nested>
	<div class="blank-column"></div>
	<div class="date-column">{guf.ancestor(this, 'sam-reporting-date-list-row-nested').date}</div>
	<div class="week-column">{guf.ancestor(this, 'sam-reporting-date-list-row-nested').week}</div>
	<div class="teacher-column flex1">{guf.ancestor(this, 'sam-reporting-date-list-row-nested').teacher}</div>
	<div class="total-column">{guf.ancestor(this, 'sam-reporting-date-list-row-nested').total}</div>
	<div each={absence in guf.ancestor(this, 'sam-reporting-date-list-row-nested').item.absences} class="period-column">{absence}</div>
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
		:scope > .blank-column {
			width: 111px;
			min-width: 111px;
		}
		:scope > .date-column {
			width: 70px;
			min-width: 70px;
		}
		:scope > .week-column {
			width: 50px;
			min-width: 50px;
			text-align: center;
		}
		:scope > .teacher-column {
			min-width: 220px;
			word-break: break-word;
		}
		:scope > .total-column {
			width: 70px;
			min-width: 70px;
			text-align: center;
		}
		:scope > .period-column {
			width: 16px;
			min-width: 16px;
			text-align: center;
			padding: 0 4px;
		}
		:scope > .period-column:last-child {
			border-right: 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.date = moment(tag.item.date,"YYYY-MM-DD").format("L");
		tag.week = tag.item.week;
		tag.teacher = tag.item.teacher;
		tag.total = tag.item.totalAbsences;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');
	</script>
</sam-reporting-date-list-row-nested>