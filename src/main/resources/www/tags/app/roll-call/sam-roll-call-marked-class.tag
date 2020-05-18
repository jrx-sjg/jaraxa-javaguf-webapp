<sam-roll-call-marked-class>
	<!--<div ref="filter-resume" class="filter-resume">{guf.ancestor(this, 'sam-roll-call-marked-class').getFilterResume(item)}</div>-->
	<sam-class-title>{guf.ancestor(this, 'sam-roll-call-marked-class').getFilterResume(guf.ancestor(this, 'sam-roll-call-marked-class').item)}</sam-class-title>
	<div class="students-list">
		<sam-roll-call-marked-student ref="student" each={student in item.students} periods={item.timePeriods}></sam-roll-call-marked-student>
	</div>
	<style scoped type="dcss">
		:scope {
		}
		:scope > .filter-resume {
			padding: 6px 0px;
			margin-bottom: 20px;
			color: @primary;
			text-align: center;
			text-transform: uppercase;
			font-size: 14px;
			font-weight: 600;
			border-top: 2px solid @primary;
			border-bottom: 2px solid @primary;
		}
		:scope > sam-class-title {
			position: -webkit-sticky;
			position: sticky;
			top: 190px;
			background: @lightestbackground;
			z-index: 1;
		}
		:scope.filter-maximized > sam-class-title {
			top: 308px;
		}
		:scope.filter-maximized.advanced-user > sam-class-title {
			top: 333px;
		}
		:scope > .students-list {
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
		}
		:scope > .students-list > sam-roll-call-marked-student {
			margin-bottom: 20px;
			border-radius: 8px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground"
		};
		tag.mixin('mdl');

		function deleteClickHandler(studentTag, student, absences) {
			tag.trigger("student-delete-click", tag, tag.item, student, studentTag, absences);
		}

		function saveClickHandler(studentTag, student, absences) {
			tag.trigger("student-save-click", tag, tag.item, student, studentTag, absences);
		}

		function submitClickHandler(studentTag, student, absences) {
			tag.trigger("student-submit-click", tag, tag.item, student, studentTag, absences);
		}

		function absenceClickHandler(studentTag, student, absences) {
			tag.trigger("student-absence-click", tag, tag.item, student, studentTag, absences);
		}

		function lateClickHandler(studentTag, student, absences) {
			tag.trigger("student-late-click", tag, tag.item, student, studentTag, absences);
		}

		function initEvents() {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].on("delete-click", deleteClickHandler);
				students[i].on("save-click", saveClickHandler);
				students[i].on("submit-click", submitClickHandler);
				students[i].on("absence-click", absenceClickHandler);
				students[i].on("late-click", lateClickHandler);
			}
		}

		function removeEvents() {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].off("delete-click", deleteClickHandler);
				students[i].off("save-click", saveClickHandler);
				students[i].off("submit-click", submitClickHandler);
				students[i].off("absence-click", absenceClickHandler);
				students[i].off("late-click", lateClickHandler);
			}
		}

		tag.getFilterResume = function(item) {
			var separator = " / ";
			var result = item.period + separator + item.program + separator + item.course + separator + guf.i18n.get('app.class') + " " + item.className;
			return result;
		};

		tag.getData = function() {
			var studentTags = guf.tagsAsArray(tag.refs["student"]);
			var result = guf.utils.cloneObject(tag.item);
			var students = [];
			for(var i=0; i<studentTags.length; i++) {
				students.push(studentTags[i].getData());
			}
			result.students = students;
			return result;
		};

		tag.getStudentTag = function(index) {
			var studentTags = guf.tagsAsArray(tag.tags["sam-roll-call-marked-student"]);
			return studentTags[index];
		};

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-roll-call-marked-class>