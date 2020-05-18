<sam-roll-call-absences-list-item>
	<div class="period">
		{item.startingHour}
		{item.endingHour}
	</div>
	<div class="absence">
		<i ref="absence" class="{material-icons:1, selected: item.state === app.ABSENCE_STATE.ABSENCE}">event_busy</i> 
	</div>
	<div class="late">
		<i ref="late" class="{material-icons:1, selected: item.state === app.ABSENCE_STATE.LATE}">access_time</i>
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
			width: 48px;
			text-align: center;
			user-select: none;
		}
		:scope.submitted {
			background-color: @lines;
		}
		:scope > .period {
			font-size: 13px;
			font-weight: 600;
			color: black;
			border-bottom: 1px solid @lines;
			padding: 4px;
			line-height: 1.4;
		}
		:scope > .absence {
			border-bottom: 1px solid @lines;
			padding: 6px;
			line-height: 0px;
		}
		:scope > .late {
			padding: 6px;
			line-height: 0px;
		}
		:scope > div > i.material-icons {
			cursor: default;
			font-size: 28px;
			color: @lighttext;
		}
		:scope.can-modify > div > i.material-icons {
			cursor: pointer;
		}
		:scope > div > i.material-icons.selected {
			color: @accent;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var canModify = false;
		if(tag.item.submitted && tag.item.canModifySubmitted) {
			canModify = true;
		} else if(!tag.item.submitted && tag.item.canModify) {
			canModify = true;
		}

		tag.relayEvents = ["absence-click", "late-click"];
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"background": "@background",
			"lighttext": "@lighttext",
			"accent": "@accent",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		function absenceClickHandler(e) {
			e.stopPropagation();
			if(canModify) {
				if(tag.item.state === app.ABSENCE_STATE.ABSENCE) {
					tag.item.state = app.ABSENCE_STATE.NONE;
				} else {
					tag.item.state = app.ABSENCE_STATE.ABSENCE;
				}
				tag.update();
				tag.trigger("absence-click", tag, tag.item);
			}
		}

		function lateClickHandler(e) {
			e.stopPropagation();
			if(canModify) {
				if(tag.item.state === app.ABSENCE_STATE.LATE) {
					tag.item.state = app.ABSENCE_STATE.NONE;
				} else {
					tag.item.state = app.ABSENCE_STATE.LATE;
				}
				tag.update();
				tag.trigger("late-click", tag, tag.item);
			}
		}

		function initEvents() {
			tag.refs["absence"].addEventListener("click", absenceClickHandler);
			tag.refs["late"].addEventListener("click", lateClickHandler);
		}

		function removeEvents() {
			tag.refs["absence"].removeEventListener("click", absenceClickHandler);
			tag.refs["late"].removeEventListener("click", lateClickHandler);
		}

		tag.on("mount", function() {
			initEvents();
			if(tag.item.submitted) {
				tag.root.classList.add("submitted");
			}
			if(canModify) {
				tag.root.classList.add("can-modify");
			}
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});

		tag.on("update", function() {
			if(tag.item.submitted && tag.item.state !== app.ABSENCE_STATE.NONE) {
				tag.root.classList.add("submitted");
			} else {
				tag.root.classList.remove("submitted");
			}
			canModify = false;
			if(tag.item.submitted && tag.item.canModifySubmitted) {
				canModify = true;
			} else if(!tag.item.submitted && tag.item.canModify) {
				canModify = true;
			}
			if(canModify) {
				tag.root.classList.add("can-modify-submitted");
			} else {
				tag.root.classList.remove("can-modify-submitted");
			}
		});
	</script>
</sam-roll-call-absences-list-item>