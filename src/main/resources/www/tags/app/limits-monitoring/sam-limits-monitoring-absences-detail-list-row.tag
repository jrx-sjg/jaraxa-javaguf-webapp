<sam-limits-monitoring-absences-detail-list-row>
	<div class="date-column">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').date}</div>
	<div class="week-column">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').week}</div>
	<div class="teacher-column">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').teacher}</div>
	<div class="comment-column flex1">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').comment}</div>
	<div ref="period" each={period, index in guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').periods} class="{period-column: 1, absence: period}" index="{index}">{period ? period.absence : ""}</div>
	<div class="total-column">{guf.ancestor(this, 'sam-limits-monitoring-absences-detail-list-row').total}</div>
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
			min-height: 40px;
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
			border-right: 1px solid @background;
		}
		:scope > .date-column {
			width: 80px;
			min-width: 80px;
		}
		:scope > .week-column {
			width: 40px;
			min-width: 40px;
			text-align: center;
		}
		:scope > .teacher-column {
			width: 150px;
			min-width: 150px;
		}
		:scope > .comment-column {
			min-width: 120px;
		}
		:scope > .period-column {
			width: 16px;
			min-width: 16px;
			text-align: center;
			padding: 0 4px;
		}
		:scope > .period-column.absence {
			cursor: pointer;
		}
		:scope > .total-column {
			width: 40px;
			min-width: 40px;
			text-align: center;
			border-right: 0px;
		}

		@media screen and (max-width: 600px) {
			:scope {
				min-width: 726px;
			}
			:scope > div {
				font-size: 11px;
				line-height: 1.4;
				padding-left: 6px;
				padding-right: 6px;
			}
			:scope > .date-column {
				width: 60px;
				min-width: 60px;
				position: -webkit-sticky;
				position: sticky;
				left: 0;
				background: @lightestbackground;
			}
			:scope > .week-column {
				width: 30px;
				min-width: 30px;
				position: -webkit-sticky;
				position: sticky;
				left: 73px;
				background: @lightestbackground;
			}
			:scope > .teacher-column {
				min-width: 80px;
				max-width: 80px;
				position: -webkit-sticky;
				position: sticky;
				left: 116px;
				background: @lightestbackground;
			}
			:scope > .period-column {
				width: 10px;
				min-width: 10px;
				padding: 0 2px;
			}
			:scope > .period-column.absence {
			}
			:scope > .total-column {
				width: 35px;
				min-width: 35px;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var currentDialog = null;

		tag.date = tag.item.date ? moment(tag.item.date,"YYYY-MM-DD").format("L") : "";
		tag.week = tag.item.week;
		tag.teacher = tag.item.teacher;
		tag.comment = tag.item.comment;
		tag.total = tag.item.totalAbsencesInDay;
		tag.periods = new Array(20);
		for(var i=0; i<tag.item.absences.length; i++) {
			var absence = tag.item.absences[i];
			tag.periods[absence.index - 1] = absence;
		}

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');

		function showPeriod(period) {
			var periodText = period.startTime + " - " + period.endTime;
			var periodDom = document.createElement("sam-limits-monitoring-period-dialog");
			document.body.appendChild(periodDom);
			riot.compile(function(){
				var periodDialog = riot.mount(periodDom, "sam-limits-monitoring-period-dialog", {
					periodText: periodText,
					dismissible: true
				})[0];
				periodDialog.on("close", function(periodDialogTag) {
					periodDialog.unmount();
					currentDialog = null;
				});
				currentDialog = periodDialog;
			});
		}

		function periodClickHandler(event) {
			var index = event.target.getAttribute("index");
			if(tag.periods[index]) {
				showPeriod(tag.periods[index]);
			}
		}

		function initEvents() {
			var periods = guf.tagsAsArray(tag.refs["period"]);
			for(var i=0; i<periods.length; i++) {
				periods[i].addEventListener("click", periodClickHandler);
			}
		}

		function removeEvents() {
			var periods = guf.tagsAsArray(tag.refs["period"]);
			for(var i=0; i<periods.length; i++) {
				periods[i].removeEventListener("click", periodClickHandler);
			}
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
			if(currentDialog && currentDialog.isMounted) {
				currentDialog.unmount();
			}
		});
	</script>
</sam-limits-monitoring-absences-detail-list-row>