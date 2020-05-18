<sam-roll-call-content-marked>
	<guf-linear-layout ref="selection-type-container" class="selection-type-container" orientation="horizontal">
		<guf-input ref="search-input" placeholder="{guf.i18n.get('guf.search')}" autocorrect="off" label="v2-outlined" trailing-icon="search" trailing-icon-fn="{guf.ancestor(this,'sam-roll-call-content-marked').search}"></guf-input>
		<div class="flex1"></div>
		<guf-button ref="save-all-button" type="flat" color="true" icon="save" dcss-border="1px solid @lines" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines">{guf.i18n.get('app.save_all')}</guf-button>
		<guf-button ref="submit-all-button" type="flat" color="true" icon="arrow_downward" dcss-border="1px solid @lines" dcss-background-disabled="transparent" dcss-text-color-disabled="@lines">{guf.i18n.get('app.submit_all')}</guf-button>
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
			position:relative;
			margin-top: -16px;
			margin-bottom: -30px;
		}
		:scope > .selection-type-container > guf-button {
			margin-left: 10px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		var saveAllButton, submitAllButton;
		var searchInput;
		var modifiedStudents = [];

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines"
		};
		tag.mixin('mdl', 'after-mount');

		function updateButtonsState() {
			var classTags = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			var data = [];
			for(var i=0; i<classTags.length; i++) {
				data.push(classTags[i].getData());
			}
			if(app.rollCall.canSaveAllAbsences(data)) {
				saveAllButton.enable();
			} else {
				saveAllButton.disable();
			}
			if(app.rollCall.canSubmitAllAbsences(data)) {
				submitAllButton.enable();
			} else {
				submitAllButton.disable();
			}
		}

		function saveAllClickHandler() {
			var classTags = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			var data = [];
			for(var i=0; i<classTags.length; i++) {
				data.push(classTags[i].getData());
			}
			app.rollCall.saveAllAbsences(data).then(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			}).catch(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			});
		}

		function submitAllClickHandler() {
			var classTags = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			var data = [];
			for(var i=0; i<classTags.length; i++) {
				data.push(classTags[i].getData());
			}
			app.rollCall.submitAllAbsences(data).then(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			}).catch(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			});
		}

		function studentDeleteClickHandler(classTag, classData, student, studentTag, absences) {
			app.rollCall.deleteAbsences(classData, student, absences).then(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			}).catch(function() {
			});
		}

		function studentSaveClickHandler(classTag, classData, student, studentTag, absences) {
			app.rollCall.saveAbsences(classData, [student], absences).then(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			}).catch(function() {
			});
		}

		function studentSubmitClickHandler(classTag, classData, student, studentTag, absences) {
			app.rollCall.submitAbsences(classData, student, absences).then(function() {
				guf.ancestor(tag, "sam-roll-call").update();
			}).catch(function() {
				studentTag.update();
			});
		}

		function studentAbsenceClickHandler(classTag, classData, student, studentTag, absences) {
			student.localAbsences = studentTag.getData().markedAbsences;
			updateButtonsState();
		}

		function studentLateClickHandler(classTag, classData, student, studentTag, absences) {
			student.localAbsences = studentTag.getData().markedAbsences;
			updateButtonsState();
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
			saveAllButton = tag.refs["selection-type-container"].refs["save-all-button"];
			submitAllButton = tag.refs["selection-type-container"].refs["submit-all-button"];
			searchInput = tag.refs["selection-type-container"].refs["search-input"];
		}

		function initClassEvents() {
			var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			for(var i=0; i<classes.length; i++) {
				classes[i].on("student-delete-click", studentDeleteClickHandler);
				classes[i].on("student-save-click", studentSaveClickHandler);
				classes[i].on("student-submit-click", studentSubmitClickHandler);
				classes[i].on("student-absence-click", studentAbsenceClickHandler);
				classes[i].on("student-late-click", studentLateClickHandler);
			}
		}

		function removeClassEvents() {
			var classes = guf.tagsAsArray(guf.ancestor(tag, "sam-roll-call").getClasses());
			for(var i=0; i<classes.length; i++) {
				classes[i].off("student-delete-click", studentDeleteClickHandler);
				classes[i].off("student-save-click", studentSaveClickHandler);
				classes[i].off("student-submit-click", studentSubmitClickHandler);
				classes[i].off("student-absence-click", studentAbsenceClickHandler);
				classes[i].off("student-late-click", studentLateClickHandler);
			}
		}

		function initEvents() {
			saveAllButton.on("click", saveAllClickHandler);
			submitAllButton.on("click", submitAllClickHandler);
			searchInput.on("keyup", maybeSearchHandler);
		}

		function removeEvents() {
			saveAllButton.off("click", saveAllClickHandler);
			submitAllButton.off("click", submitAllClickHandler);
			searchInput.off("keyup", maybeSearchHandler);
		}

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("after-mount", function() {
			initClassEvents();
			updateButtonsState();
		});

		tag.on("before-unmount", function() {
			removeEvents();
			removeClassEvents();
		});

		tag.on("update", function() {
			removeClassEvents();
		});

		tag.on("updated", function() {
			guf.setTimeout(function(){
				initClassEvents();
				updateButtonsState();
			},1);
		});
	</script>
</sam-roll-call-content-marked>