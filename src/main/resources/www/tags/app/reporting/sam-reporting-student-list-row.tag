<sam-reporting-student-list-row>
	<guf-linear-layout ref="main-level" orientation="horizontal">
		<div class="expand-column"><i ref="expand" class="material-icons noselect">keyboard_arrow_right</i></div>
		<div class="id-column flex1" ref="student-data" >{guf.ancestor(this, 'sam-reporting-student-list-row').studentId}</div>
	</guf-linear-layout>
	<div if="{guf.ancestor(this, 'sam-reporting-student-list-row').expanded}" class="nested-container">
		<sam-reporting-student-list-row-nested each={item in guf.ancestor(this, 'sam-reporting-student-list-row').item.details}></sam-reporting-student-list-row-nested>
	</div>
	<style scoped type="dcss">
		:scope {
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
			border: 1px solid @lines;
			border-top: 0;
		}
		:scope > guf-linear-layout[ref="main-level"] {
			height: 40px;
		}
		:scope > guf-linear-layout[ref="main-level"] > div {
			color: @accent;
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
		:scope > guf-linear-layout[ref="main-level"] > .expand-column {
			color: @primary;
			width: 20px;
			min-width: 20px;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i {
			transition: transform 0.2s;
			transform: rotate(0deg);
			cursor: pointer;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i.expanded {
			transform: rotate(90deg);
		}
		:scope > guf-linear-layout[ref="main-level"] > .id-column {
			border-right: 0px;
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.expanded = false;

		tag.studentId = tag.item.lastName + " " + tag.item.firstName + " (" + tag.item.studentId + ")";

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"accent": "@accent",
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');

		function expandClickHandler() {
			tag.expanded = !tag.expanded;
			if(tag.expanded) {
				tag.refs["main-level"].refs["expand"].classList.add("expanded");
			} else {
				tag.refs["main-level"].refs["expand"].classList.remove("expanded");
			}
			tag.update();
		}

		function showLimitsMonitoringFromStudent() {
			var selectedPeriod = tag.opts.period;
			if (typeof selectedPeriod !== 'undefined') {
				if (Array.isArray(selectedPeriod)) {
					period = extractYearAndSemester(selectedPeriod[0]);
				} else {
					period = extractYearAndSemester(selectedPeriod);
				}
			}
			tag.trigger("student-details-click", period.semester, tag.item.studentId, period.year);
		}

		function extractYearAndSemester(period) {
			var split = period.split('.');

			return (split[0] != "") ? {year: split[0], semester:split[1]} : {year:"", semester: ""};
		}

		function initEvents() {
			tag.refs["main-level"].refs["expand"].addEventListener("click", expandClickHandler);
			tag.refs["main-level"].refs["student-data"].addEventListener("click", showLimitsMonitoringFromStudent);
		}

		function removeEvents() {
			tag.refs["main-level"].refs["expand"].removeEventListener("click", expandClickHandler);
			tag.refs["main-level"].refs["student-data"].removeEventListener("click", showLimitsMonitoringFromStudent);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-reporting-student-list-row>