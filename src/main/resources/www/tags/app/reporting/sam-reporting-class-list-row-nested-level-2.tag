<sam-reporting-class-list-row-nested-level-2>
	<guf-linear-layout ref="main-level" orientation="horizontal">
		<div class="blank-column"></div>
		<div class="expand-column"><i ref="expand" class="material-icons noselect">keyboard_arrow_right</i></div>
		<div class="student-column flex1" ref="student-data">{guf.ancestor(this, 'sam-reporting-class-list-row-nested-level-2').student}</div>
		<div class="total-column">{guf.ancestor(this, 'sam-reporting-class-list-row-nested-level-2').total}</div>
		<div class="tail-column"></div>
	</guf-linear-layout>
	<div if="{guf.ancestor(this, 'sam-reporting-class-list-row-nested-level-2').expanded}" class="nested-container">
		<sam-reporting-class-list-row-nested-level-3 each={item in guf.ancestor(this, 'sam-reporting-class-list-row-nested-level-2').item.absencesDetails}></sam-reporting-class-list-row-nested-level-3>
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
			border-top: 1px solid @lines;
		}
		:scope > guf-linear-layout[ref="main-level"] {
			height: 40px;
		}
		:scope > guf-linear-layout[ref="main-level"] > div {
			color: blue;
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
		:scope > guf-linear-layout[ref="main-level"] > .blank-column {
			width: 161px;
			min-width: 161px;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column {
			color: @primary;
			width: 20px;
			min-width: 20px;
			border-color: @background;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i {
			transition: transform 0.2s;
			transform: rotate(0deg);
			cursor: pointer;
		}
		:scope > guf-linear-layout[ref="main-level"] > .expand-column > i.expanded {
			transform: rotate(90deg);
		}
		:scope > guf-linear-layout[ref="main-level"] > .student-column {
			min-width: 402px;
			cursor: pointer;
		}
		:scope > guf-linear-layout[ref="main-level"] > .total-column {
			width: 60px;
			min-width: 60px;
			text-align: center;
			color: @lighttext;
		}
		:scope > guf-linear-layout[ref="main-level"] > .tail-column {
			width: 499px;
			min-width: 499px;
			padding: 0px;
			border-right: 0px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.expanded = false;

		tag.student = tag.item.lastName + " " + tag.item.firstName + " (" + tag.item.id + ")";
		tag.total = tag.item.total;

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
			tag.trigger("student-details-click", period.semester, tag.item.id, period.year);
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
</sam-reporting-class-list-row-nested-level-2>