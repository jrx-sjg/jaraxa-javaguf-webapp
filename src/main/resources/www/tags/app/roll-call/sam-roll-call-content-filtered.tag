<sam-roll-call-content-filtered>
	<guf-linear-layout ref="selection-type-container" class="selection-type-container" orientation="horizontal">
		<guf-button ref="multi-select" type="icon" icon="people" color="true" dcss-text-color="@lines" dcss-text-color-toggled="@primary"></guf-button>
		<guf-button ref="single-select" type="icon" icon="person" color="true" dcss-text-color="@lines" dcss-text-color-toggled="@primary"></guf-button>
		<guf-input ref="search-input" placeholder="{guf.i18n.get('guf.search')}" autocorrect="off" label="v2-outlined" trailing-icon="search" trailing-icon-fn="{guf.ancestor(this,'sam-roll-call-content-filtered').search}"></guf-input>
		<div class="flex1"></div>
		<guf-button ref="select-button" type="flat" color="true" icon="check" dcss-border="1px solid @lines" dcss-text-color="@primary" dcss-text-color-disabled="@lines" dcss-background-disabled="transparent" disabled="true">{guf.i18n.get('app.select')}</guf-button>
	</guf-linear-layout>
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
		}
		:scope > .selection-type-container {
			padding: 0 26px;
			margin-bottom: 20px;
		}
		:scope > .selection-type-container > guf-input[ref="search-input"] {
			position: relative;
			margin-top: -16px;
			margin-bottom: -30px;
		}
		:scope > .class-container {
			margin: 0 26px 20px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var SELECTION_TYPE = {
			SINGLE: "single",
			MULTIPLE: "multiple"
		};

		var multiSelectButton, singleSelectButton;
		var selectButton;
		var currentSelectionType = SELECTION_TYPE.SINGLE;
		var searchInput;
		var currentSelection = {};
		var currentClass;
		var currentDialog = null;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		function updateSelectButtonState() {
			if(currentSelectionType === SELECTION_TYPE.MULTIPLE && Object.keys(currentSelection).length > 0) {
				selectButton.enable();
			} else {
				selectButton.disable();
			}
		}

		function resetSelection() {
			var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			for(var i=0; i<classes.length; i++) {
				classes[i].resetStates();
			}
			currentSelection = {};
			updateSelectButtonState();
		}

		function addStudentToSelection(student) {
			if(!currentSelection[student.id]) {
				currentSelection[student.id] = student;
			}
		}

		function removeStudentFromSelection(student) {
			if(currentSelection[student.id]) {
				delete currentSelection[student.id];
			}
		}

		function getArrayFromCurrentSelection() {
			var result = [];
			for(var index in currentSelection) {
				result.push(currentSelection[index]);
			}
			return result;
		}

		function blockOtherClasses(selectedClass) {
			if(Object.keys(currentSelection).length == 1) {
				currentClass = selectedClass;
				var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
				for(var i=0; i<classes.length; i++) {
					if(classes[i].item.className !== selectedClass.className) {
						classes[i].setStateForAll(app.STUDENT_STATE.ALREADY_USED);
					}
				}
			}
		}

		function unblockOtherClasses(selectedClass) {
			if(Object.keys(currentSelection).length == 0) {
				currentClass = null;
				var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
				for(var i=0; i<classes.length; i++) {
					classes[i].resetStates();
				}
			}
		}

		function showAbsencesDialog(classData, studentsData) {
			var infoMessage = "";
			if(classData.classRecordSubmitted) {
				infoMessage = guf.i18n.get('app.cant_change_absences');
			} else if(studentsData[0].blockedByExceptionRollCall) {
				infoMessage = guf.i18n.get('app.blocked_by_exception_roll_call_message');
			}
			var absencesDom = document.createElement("sam-roll-call-absences-dialog");
			document.body.appendChild(absencesDom);
			riot.compile(function(){
				var absencesDialog = riot.mount(absencesDom, "sam-roll-call-absences-dialog", {
					title: studentsData.length > 1 ? guf.i18n.get('app.students_selected', studentsData.length) : studentsData[0].firstName + " " + studentsData[0].lastName,
					infoMessage: infoMessage,
					showOk: !classData.classRecordSubmitted && !studentsData[0].blockedByExceptionRollCall,
					showComment: studentsData.length === 1
				})[0];
				absencesDialog.setData(app.rollCall.getAbsences(studentsData[0]), studentsData[0].comment);
				absencesDialog.on("nok", function(absencesDialogTag) {
					absencesDialogTag.unmount();
					currentDialog = null;
				});
				absencesDialog.on("ok", function(absencesDialogTag, absencesData, comment) {
					app.rollCall.saveAbsences(classData, studentsData, absencesData, comment).then(function() {
						absencesDialog.unmount();
						currentDialog = null;
						tag.update();
					}).catch(function() {

					});
				});
				currentDialog = absencesDialog;
			});
		}

		function multiSelectClickHandler(e, button) {
			if(!button.isToggled()) {
				button.toggle();
				singleSelectButton.toggle();
				currentSelectionType = SELECTION_TYPE.MULTIPLE;
				resetSelection();
			}
		}

		function singleSelectClickHandler(e, button) {
			if(!button.isToggled()) {
				button.toggle();
				multiSelectButton.toggle();
				currentSelectionType = SELECTION_TYPE.SINGLE;
				resetSelection();
			}
		}

		function selectButtonClickHandler(e, button) {
			var students = getArrayFromCurrentSelection();
			showAbsencesDialog(currentClass, students);
		}

		function studentClickHandler(classTag, classData, student, studentTag) {
			if(currentSelectionType === SELECTION_TYPE.SINGLE) {
				// FIXME open absences modal view
				showAbsencesDialog(classData, [student]);
			} else if(currentSelectionType === SELECTION_TYPE.MULTIPLE) {
				switch(studentTag.getState()) {
					case app.STUDENT_STATE.DEFAULT:
						classTag.setStudentState(student.id, app.STUDENT_STATE.SELECTED);
						addStudentToSelection(student);
						blockOtherClasses(classData);
						break;
					case app.STUDENT_STATE.SELECTED:
						classTag.setStudentState(student.id, app.STUDENT_STATE.DEFAULT);
						removeStudentFromSelection(student);
						unblockOtherClasses(classData);
						break;
				}
				updateSelectButtonState();
			} else {
				guf.console.error("Error - unknown selection type");
			}
		}

		function maybeSearchHandler(value, event) {
			if ((event.key!==null && event.key==="enter") || event.keyCode === 13) {
				tag.search();
			}
		}

		tag.search = function() {
			tag.trigger("search", searchInput.getValue());
		};

		function initView() {
			multiSelectButton = tag.refs["selection-type-container"].refs["multi-select"];
			singleSelectButton = tag.refs["selection-type-container"].refs["single-select"];
			selectButton = tag.refs["selection-type-container"].refs["select-button"];
			searchInput = tag.refs["selection-type-container"].refs["search-input"];
		}

		function initClassEvents() {
			var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			for(var i=0; i<classes.length; i++) {
				classes[i].on("student-click", studentClickHandler);
			}
		}

		function removeClassEvents() {
			var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			for(var i=0; i<classes.length; i++) {
				classes[i].off("student-click", studentClickHandler);
			}
		}

		function initEvents() {
			multiSelectButton.on("click", multiSelectClickHandler);
			singleSelectButton.on("click", singleSelectClickHandler);
			selectButton.on("click", selectButtonClickHandler);
			searchInput.on("keyup", maybeSearchHandler);
		}

		function removeEvents() {
			multiSelectButton.off("click", multiSelectClickHandler);
			singleSelectButton.off("click", singleSelectClickHandler);
			selectButton.off("click", selectButtonClickHandler);
			searchInput.off("keyup", maybeSearchHandler);
		}

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
			removeClassEvents();
			if(currentDialog && currentDialog.isMounted) {
				currentDialog.unmount();
			}
		});

		tag.on("after-mount", function() {
			initClassEvents();
			singleSelectButton.setToggle(true);
			resetSelection();
		});

		tag.on("update", function() {
			removeClassEvents();
		});

		tag.on("updated", function() {
			guf.setTimeout(function(){
				initClassEvents();
				resetSelection();
			},1);
		});
	</script>
</sam-roll-call-content-filtered>