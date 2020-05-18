<sam-roll-call-student>
	<guf-image class="avatar" imagesrc="{guf.ancestor(this, 'sam-roll-call-student').pictureUrl}" loadingsrc="{guf.ancestor(this, 'sam-roll-call-student').defaultPictureUrl}" errorsrc="{guf.ancestor(this, 'sam-roll-call-student').defaultPictureUrl}" width="80" height="120"></guf-image>
	<guf-linear-layout class="info-container" orientation="vertical">
		<div class="preferred-name flex1" ref="preferred-name">{guf.ancestor(this, 'sam-roll-call-student').highlightedPreferredName}</div>
		<div class="name flex2" ref="fullname">{guf.ancestor(this, 'sam-roll-call-student').highlightedFullName}</div>
		<guf-linear-layout orientation="horizontal">
			<div class="student-id flex1" ref="student-id">{guf.ancestor(this, 'sam-roll-call-student').highlightedStudentId}</div>
			<div class="flex1"></div>
			<i if="{guf.ancestor(this, 'sam-roll-call-student').hasComment}" class="comment material-icons">comment</i>
		</guf-linear-layout>
	</guf-linear-layout>
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
			border-radius: 8px;
			width: 300px;
			height: 120px;
			box-sizing: border-box;
			cursor: pointer;
			overflow: hidden;
		}
		:scope > .avatar {
			width: 80px;
			max-width: 80px;
			min-width: 80px;
		}
		:scope > .avatar img {
			object-fit: cover;
		}
		:scope > .info-container {
			padding: 10px;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .info-container > .preferred-name {
			font-size: 16px;
			font-weight: 600;
			color: @primary;
		}
		:scope > .info-container > .name {
			font-size: 15px;
			font-weight: 600;
			color: @lighttext;
		}
		:scope > .info-container > guf-linear-layout > .student-id {
			font-size: 13px;
			color: @lighttext;
		}
		:scope > .info-container > guf-linear-layout > .comment {
			color: @lighttext;
		}

		:scope.already-used {
			background-color: @lines;
		}

		:scope.selected {
			background-color: @primary;
			border-color: @primary;
		}
		:scope.selected > .info-container > .preferred-name {
			color: @textPrimary;
		}
		:scope.selected > .info-container > .name {
			color: @textPrimary;
		}
		:scope.selected > .info-container > guf-linear-layout > .student-id {
			color: @textPrimary;
		}
		:scope.selected > .info-container > guf-linear-layout > .comment {
			color: @textPrimary;
		}

		:scope span.highlight {
			color: @textPrimary;
			background-color: @primary;
		}
		:scope.selected span.highlight {
			color: @primary;
			background-color: @textPrimary;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var currentState = app.STUDENT_STATE.DEFAULT;
		var preferredNameLabel, fullNameLabel, studentIdLabel;

		tag.preferredName = tag.student.preferredName || tag.student.firstName;
		tag.fullName = tag.student.lastName + " " + tag.student.firstName;
		tag.studentId = tag.student.id;
		tag.highlightedPreferredName = tag.preferredName;
		tag.highlightedFullName = tag.fullName;
		tag.highlightedStudentId = tag.studentId;
		tag.hasComment = tag.student.comment ? tag.student.comment.length : false;
		tag.defaultPictureUrl = "./img/default.png";
		tag.pictureUrl = tag.student.pictureUrl ? app.getBaseUrl() + tag.student.pictureUrl : tag.defaultPictureUrl;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lighttext": "@lighttext",
			"lines": "@lines",
			"textPrimary": "@textPrimary"
		};
		tag.mixin('mdl');

		function clickHandler(e) {
			tag.trigger("click", tag, tag.student);
		}

		function initView() {
			preferredNameLabel = tag.tags["guf-linear-layout"].refs["preferred-name"];
			fullNameLabel = tag.tags["guf-linear-layout"].refs["fullname"];
			studentIdLabel = tag.tags["guf-linear-layout"].tags["guf-linear-layout"].refs["student-id"];
		}

		function initEvents() {
			tag.root.addEventListener("click", clickHandler);
		}

		function removeEvents() {
			tag.root.removeEventListener("click", clickHandler);
		}

		tag.select = function() {
			tag.root.classList.add("selected");
		};

		tag.deselect = function() {
			tag.root.classList.remove("selected");
		};

		tag.setState = function(newState) {
			if(newState != currentState) {
				currentState = newState;
				tag.root.classList.remove("selected");
				tag.root.classList.remove("already-used");
				switch(currentState) {
					case app.STUDENT_STATE.SELECTED:
						tag.root.classList.add("selected");
						break;
					case app.STUDENT_STATE.ALREADY_USED:
						tag.root.classList.add("already-used");
						break;
				}
			}
		};

		tag.getState = function() {
			return currentState;
		};

		tag.highlightText = function(value) {
			if (value == null) {
				tag.highlightedPreferredName = tag.preferredName;
				tag.highlightedFullName = tag.fullName;
				tag.highlightedStudentId = tag.studentId;
			} else {
				tag.highlightedPreferredName = app.highlightInString(tag.preferredName, value);
				tag.highlightedFullName = app.highlightInString(tag.fullName, value);
				tag.highlightedStudentId = app.highlightInString(tag.studentId, value);
			}
			preferredNameLabel.innerHTML = tag.highlightedPreferredName;
			fullNameLabel.innerHTML = tag.highlightedFullName;
			studentIdLabel.innerHTML = tag.highlightedStudentId;
		};

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-roll-call-student>