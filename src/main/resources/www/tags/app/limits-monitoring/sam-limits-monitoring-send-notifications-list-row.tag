<sam-limits-monitoring-send-notifications-list-row>
	<div class="level-column">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').level}</div>
	<div class="process-description-column flex1">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').processDescription}</div>
	<div class="program-column">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').program}</div>
	<div class="course-column flex1">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').course}</div>
	<div class="warning-column">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').warningAbsences}</div>
	<div class="warning-column">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').warningCourses}</div>
	<div class="latest-date-column">{guf.ancestor(this, 'sam-limits-monitoring-send-notifications-list-row').latestDate}</div>
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
			border-top: 0;
			height: 40px;
			cursor: pointer;
		}
		:scope.selected {
			background-color: @primary;
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
		:scope.selected > div {
			color: white;
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

		tag.level = tag.item.level;
		tag.processDescription = tag.item.processDescription;
		tag.program = tag.item.program;
		tag.course = tag.item.course;
		tag.warningAbsences = tag.item.warningAbsences;
		tag.warningCourses = tag.item.warningCourses;
		tag.latestDate = tag.item.latestNotificationDate ? moment(tag.item.latestNotificationDate,"YYYY-MM-DD").format("L") : "";

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"accent": "@accent",
			"background": "@background",
			"lines": "@lines",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');

		function clickHandler(e) {
			if(tag.root.classList.contains("selected")) {
				tag.root.classList.remove("selected");
				tag.trigger("deselected", tag, tag.item);
			} else {
				tag.root.classList.add("selected");
				tag.trigger("selected", tag, tag.item);
			}
		}

		function initEvents() {
			tag.root.addEventListener("click", clickHandler);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", clickHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-limits-monitoring-send-notifications-list-row>