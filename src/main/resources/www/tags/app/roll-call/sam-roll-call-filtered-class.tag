<sam-roll-call-filtered-class>
	<!--<div ref="filter-resume" class="filter-resume">{guf.ancestor(this, 'sam-roll-call-filtered-class').getFilterResume(item)}</div>-->
	<sam-class-title>{guf.ancestor(this, 'sam-roll-call-filtered-class').getFilterResume(guf.ancestor(this, 'sam-roll-call-filtered-class').item)}</sam-class-title>
	<div class="students-list">
		<sam-roll-call-student ref="student" each={student in item.students} ></sam-roll-call-student>
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
			flex-wrap: wrap;
			margin: 0 auto;
		}
		:scope > .students-list > sam-roll-call-student {
			margin: 0px 10px 20px;
			border-radius: 8px;
		}

		@media screen and (max-width: 691px) {/* 639 + 52 (margins)*/
			:scope > .students-list {
				width: 320px;
			}
		}
		@media screen and (min-width: 692px) and (max-width: 1011px) {
			:scope > .students-list {
				width: 640px;
			}
		}
		@media screen and (min-width: 1012px) and (max-width: 1331px) {
			:scope > .students-list {
				width: 960px;
			}
		}
		@media screen and (min-width: 1332px) {
			:scope > .students-list {
				width: 1280px;
			}
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

		function studentClickHandler(studentTag, student) {
			tag.trigger("student-click", tag, tag.item, student, studentTag);
		}

		function initListEvents() {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].on("click", studentClickHandler);
			}
		}

		function removeListEvents() {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].off("click", studentClickHandler);
			}
		}

		tag.getFilterResume = function(item) {
			var separator = " / ";
			var result = item.period + separator + item.program + separator + item.course + separator + guf.i18n.get('app.class') + " " + item.className;
			return result;
		};

		tag.setStudentState = function(studentId, newState) {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				if(students[i].student.id === studentId) {
					students[i].setState(newState);
					break;
				}
			}	
		};

		tag.setStateForAll = function(newState) {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].setState(newState);
			}	
		};

		tag.resetStates = function() {
			var students = guf.tagsAsArray(tag.refs["student"]);
			for(var i=0; i<students.length; i++) {
				students[i].setState(app.rollCall.getStudentState(students[i].student));
			}	
		};

		tag.getStudentTag = function(index) {
			var studentTags = guf.tagsAsArray(tag.tags["sam-roll-call-student"]);
			return studentTags[index];
		};

		tag.on("mount", function() {
			initListEvents();
		});

		tag.on("before-unmount", function() {
			removeListEvents();
		});

	</script>
</sam-roll-call-filtered-class>