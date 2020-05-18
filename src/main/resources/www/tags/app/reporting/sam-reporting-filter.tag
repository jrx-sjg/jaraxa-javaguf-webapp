<sam-reporting-filter>
	<div ref="container" class="container">
		<guf-linear-layout ref="container-maximized" class="container-maximized" orientation="vertical">
			<guf-linear-layout ref="filter-title" orientation="horizontal" v-align="center">
				<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-top" orientation="horizontal" v-align="center">
				<guf-combo-box ref="period-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.period')}"></guf-combo-box>
				<guf-combo-box ref="teacher-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.teacher')}" item-tag="sam-teacher-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="program-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.program')}"></guf-combo-box>
				<guf-combo-box ref="course-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.course')}" item-tag="sam-class-combo-box-item"></guf-combo-box>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-bottom" orientation="horizontal" v-align="center">
				<guf-combo-box ref="class-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.class')}"></guf-combo-box>
				<guf-combo-box ref="week-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.week')}"></guf-combo-box>
				<guf-combo-box ref="view-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.view')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<div class="flex1"></div>
			</guf-linear-layout>
			<guf-linear-layout ref="actions" class="actions" orientation="horizontal" h-align="right">
				<guf-button ref="reset-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled">{guf.i18n.get('app.reset_filter')}</guf-button>
				<guf-button ref="apply-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled">{guf.i18n.get('app.apply_filter')}</guf-button>
			</guf-linear-layout>
			<div ref="overlay" class="overlay hidden"></div>
		</guf-linear-layout>
		<guf-linear-layout ref="container-minimized" class="container-minimized" orientation="horizontal" v-align="center">
			<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			<div class="spacer"></div>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.period')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentPeriodText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.class')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentClassText()}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.teacher')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentTeacherText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.week')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentWeekText()}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.program')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentProgramText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.view')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentView}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.course')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-reporting-filter').currentCourseText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center" class="empty">
				</guf-linear-layout>
			</guf-linear-layout>
			<div class="spacer"></div>
		</guf-linear-layout>
	</div>
	<guf-button ref="minimize-button" class="minimize-button" type="icon" icon="keyboard_arrow_up" toggled-icon="keyboard_arrow_down" dcss-text-color="#000000" dcss-text-color-toggled="#000000" dcss-height="24px" toggled="false"></guf-button>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-flow: row;
			-moz-flex-flow: row;
			-ms-flex-flow: row;
			flex-flow: row;
			position: relative;
		}
		:scope > .container {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			margin-top: 12px;
			border: 1px solid @lines;
			border-radius: 10px;
			min-height: 230px;
			max-height: 230px;
			transition: min-height 0.2s, max-height 0.2s;
			padding: 10px;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-flow: row;
			-moz-flex-flow: row;
			-ms-flex-flow: row;
			flex-flow: row;
			position: relative;
		}
		:scope > .container.minimized {
			min-height: 32px;
			max-height: 32px;
		}
		:scope > .container > .container-maximized {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .container:not(.minimized) > .container-minimized {
			display: none;
		}
		:scope > .container.minimized > .container-maximized {
			display: none;
		}
		:scope > .container > .container-maximized > .overlay {
			position: absolute;
			top: 0;
			bottom: 0;
			left: 0;
			right: 0;
			border-radius: 10px;
			background-color: rgba(0, 0, 0, 0.15);
			z-index: 2;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-title"] {
			margin-bottom: 6px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-title"] > i.material-icons {
			margin-right: 10px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-combo-box,
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-bottom"] > guf-combo-box {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			margin-right: 16px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-combo-box:last-child {
			margin-right: 0px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="actions"] > guf-button {
			margin-left: 16px;
		}
		:scope > .container > .container-minimized {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			cursor: pointer;
			overflow: hidden;
		}
		:scope > .container > .container-minimized > i.material-icons {
			margin-right: 10px;
		}
		:scope > .container > .container-minimized > .spacer {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .container > .container-minimized .filter-title {
			font-size: 12px;
			color: @lines;
			margin-left: 15px;
			margin-right: 8px;
		}
		:scope > .container > .container-minimized .filter-value {
			font-size: 14px;
			color: #000000;
			margin-right: 15px;
		}
		:scope > .container > .container-minimized .empty {
			height: 20px;
			min-height: 20px;
		}
		:scope > .minimize-button {
			position: absolute;
			top: 0;
			right: 10px;
			border: 1px solid @lines;
			background-color: white;
			border-radius: 50%;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var filterMinimized = false;
		var periodCombo, teacherCombo, programCombo, courseCombo;
		var classCombo, weekCombo, viewCombo;
		var applyFilterButton, resetFilterButton;
		var applyWhenLoaded;
		var originalPeriods = [], selectedPeriods = [];
		var originalTeachers = [], selectedTeachers = [];
		var originalPrograms = [], selectedPrograms = [];
		var originalCourses = [], selectedCourses = [];
		var originalClasses = [], selectedClasses = [];
		var originalWeeks = [], selectedWeeks = [];

		tag.currentPeriods = "";
		tag.currentTeachers = "";
		tag.currentPrograms = "";
		tag.currentCourses = "";
		tag.currentClasses = "";
		tag.currentWeeks = "";
		tag.currentView = "";

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl','after-mount');

		function updateFilterState(minimized) {
			if(filterMinimized != minimized) {
				filterMinimized = minimized;
				if(filterMinimized) {
					tag.refs["container"].classList.add("minimized");
				} else {
					tag.refs["container"].classList.remove("minimized");
				}
			}
		}

		function updateFilterStatus() {
			tag.currentView.length > 0 ? applyFilterButton.enable() : applyFilterButton.disable();
			resetFilterButton.enable();
			tag.refs["container-maximized"].update();
		}

		function updateCombos() {
			periodCombo.setText(tag.currentPeriodText());
			teacherCombo.setText(tag.currentTeacherText());
			programCombo.setText(tag.currentProgramText());
			courseCombo.setText(tag.currentCourseText());
			classCombo.setText(tag.currentClassText());
			weekCombo.setText(tag.currentWeekText());
			viewCombo.setText(tag.currentView);
		}

		function formatMultiValueText(values, field) {
			var resultText = "";
			for (var i = 0; i < values.length; i++) {
				if (i > 0) {
					resultText += ", ";
				}
				if(typeof field !== "undefined") {
					resultText += values[i][field];
				} else {
					resultText += values[i];
				}
			}
			return resultText;
		}

		function updatePeriodsText() {
			tag.currentPeriods = formatMultiValueText(selectedPeriods);
		}

		function updateTeachersText() {
			tag.currentTeachers = formatMultiValueText(selectedTeachers, "name");
		}

		function updateProgramsText() {
			tag.currentPrograms = formatMultiValueText(selectedPrograms);
		}

		function updateCoursesText() {
			tag.currentCourses = formatMultiValueText(selectedCourses);
		}

		function updateClassesText() {
			tag.currentClasses = formatMultiValueText(selectedClasses);
		}

		function updateWeeksText() {
			tag.currentWeeks = formatMultiValueText(selectedWeeks);
		}

		function minimizeClickHandler(e) {
			tag.refs["minimize-button"].toggle();
			tag.trigger('filter-minimized', tag.refs["minimize-button"].isToggled());
			updateFilterState(tag.refs["minimize-button"].isToggled());
		}

		function periodSelectHandler(item, itemTag) {
			selectedPeriods.push(item);
			selectedPeriods = originalPeriods.filter(function(e) {
				return selectedPeriods.indexOf(e) >= 0;
			});
			updatePeriodsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			savePeriodsFilter();
		}

		function periodDeselectHandler(item, itemTag) {
			var index = selectedPeriods.indexOf(item);
			if(index != -1) {
				selectedPeriods.splice(index, 1);
			}
			updatePeriodsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			savePeriodsFilter();
		}

		function teacherSelectHandler(item, itemTag) {
			selectedTeachers.push(item);
			selectedTeachers = originalTeachers.filter(function(e) {
				for(var i=0; i<selectedTeachers.length; i++) {
					if(selectedTeachers[i].email === e.email) {
						return true;
					}
				}
				return false;
			});
			updateTeachersText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveTeachersFilter();
		}

		function teacherDeselectHandler(item, itemTag) {
			var index = selectedTeachers.map(function(teacher) {return teacher.email}).indexOf(item.email);
			if(index != -1) {
				selectedTeachers.splice(index, 1);
			}
			updateTeachersText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveTeachersFilter();
		}

		function programSelectHandler(item, itemTag) {
			selectedPrograms.push(item);
			selectedPrograms = originalPrograms.filter(function(e) {
				return selectedPrograms.indexOf(e) >= 0;
			});
			updateProgramsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveProgramsFilter();
		}

		function programDeselectHandler(item, itemTag) {
			var index = selectedPrograms.indexOf(item);
			if(index != -1) {
				selectedPrograms.splice(index, 1);
			}
			updateProgramsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveProgramsFilter();
		}

		function courseSelectHandler(item, itemTag) {
			selectedCourses.push(item);
			selectedCourses = originalCourses.filter(function(e) {
				return selectedCourses.indexOf(e) >= 0;
			});
			updateCoursesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveCoursesFilter();
		}

		function courseDeselectHandler(item, itemTag) {
			var index = selectedCourses.indexOf(item);
			if(index != -1) {
				selectedCourses.splice(index, 1);
			}
			updateCoursesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveCoursesFilter();
		}

		function classSelectHandler(item, itemTag) {
			selectedClasses.push(item);
			selectedClasses = originalClasses.filter(function(e) {
				return selectedClasses.indexOf(e) >= 0;
			});
			updateClassesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveClassesFilter();
		}

		function classDeselectHandler(item, itemTag) {
			var index = selectedClasses.indexOf(item);
			if(index != -1) {
				selectedClasses.splice(index, 1);
			}
			updateClassesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveClassesFilter();
		}

		function weekSelectHandler(item, itemTag) {
			selectedWeeks.push(item);
			selectedWeeks = originalWeeks.filter(function(e) {
				return selectedWeeks.indexOf(e) >= 0;
			});
			updateWeeksText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveWeeksFilter();
		}

		function weekDeselectHandler(item, itemTag) {
			var index = selectedWeeks.indexOf(item);
			if(index != -1) {
				selectedWeeks.splice(index, 1);
			}
			updateWeeksText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveWeeksFilter();
		}

		function viewComboClickHandler(item, itemTag) {
			tag.currentView = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveViewFilter();
		}

		function applyFilterClickHandler(e, button) {
			guf.console.log("apply filter clicked");
			applyFilterButton.disable();
			tag.trigger("apply", tag.currentView, selectedPeriods);
			tag.refs["minimize-button"].setToggle(true);
			tag.trigger('filter-minimized', true);
			updateFilterState(tag.refs["minimize-button"].isToggled());
			tag.refs["container-minimized"].update();
		}

		function resetFilterClickHandler(e, button) {
			resetFilterButton.disable();
			app.ajax.post("api/reporting/filters/reset", {
			}, function(response, xhr) {
				guf.console.log("reset filter success", response);
				var data = response.data;
				originalPeriods = [];
				selectedPeriods = [];
				originalTeachers = [];
				selectedTeachers = [];
				originalPrograms = [];
				selectedPrograms = [];
				originalCourses = [];
				selectedCourses = [];
				originalClasses = [];
				selectedClasses = [];
				originalWeeks = [];
				selectedWeeks = [];
				tag.currentPeriods = "";
				tag.currentTeachers = "";
				tag.currentPrograms = "";
				tag.currentCourses = "";
				tag.currentClasses = "";
				tag.currentWeeks = "";
				tag.currentView = "";
				if (data != null) {
					selectedPeriods = data.periods ? data.periods : [];
					selectedTeachers = data.teachers ? data.teachers : [];
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedClasses = data.classes ? data.classes : [];
					selectedWeeks = data.weeks ? data.weeks : [];
					tag.currentView = data.view ? data.view : "";
					if (data.applied) {
						applyWhenLoaded = true;
					}
				}
				updateCombos();
				initCombosMinus(null);
				updateFilterStatus();
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error resetting filter", response);
			});
		}

		function resetSearch() {
			tag.trigger("reset");
		}

		function initCombosMinus(aCombo) {
			tag.refs["container-maximized"].refs["overlay"].classList.remove("hidden");
			var promises = [];
			if(aCombo != periodCombo) {
				promises.push(initPeriodCombo());
			}
			if(aCombo != teacherCombo) {
				promises.push(initTeacherCombo());
			}
			if(aCombo != programCombo) {
				promises.push(initProgramCombo());
			}
			if(aCombo != courseCombo) {
				promises.push(initCourseCombo());
			}
			if(aCombo != classCombo) {
				promises.push(initClassCombo());
			}
			if(aCombo != weekCombo) {
				promises.push(initWeekCombo());
			}
			if(aCombo != viewCombo) {
				promises.push(initViewCombo());
			}
			Promise.all(promises).then(function(result) {
				tag.refs["container-maximized"].refs["overlay"].classList.add("hidden");
				tag.refs["container-minimized"].update();
				if (applyWhenLoaded) {
					applyFilterClickHandler();
					applyWhenLoaded = false;
				}
			});
		}

		// Combos init

		function initPeriodCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/periods", {
				}, function(response, xhr) {
					periodCombo.setOptions(response.data);
					originalPeriods = response.data;
					if (selectedPeriods) {
						updatePeriodsText();
						periodCombo.setText(tag.currentPeriodText());
						periodCombo.setSelectedOptions(selectedPeriods);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting periods", response);
					resolve(false);
				});
			});
		}

		function initTeacherCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/teachers", {
				}, function(response, xhr) {
					teacherCombo.setOptions(response.data);
					originalTeachers = response.data;
					if (selectedTeachers) {
						if(selectedTeachers.length && typeof selectedTeachers[0] !== "object") {
							selectedTeachers = originalTeachers.filter(function(e) {
								for(var i=0; i<selectedTeachers.length; i++) {
									if(selectedTeachers[i] === e.email) {
										return true;
									}
								}
								return false;
							});
						}
						updateTeachersText();
						teacherCombo.setText(tag.currentTeacherText());
						teacherCombo.setSelectedOptions(selectedTeachers);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting teachers", response);
					resolve(false);
				});
			});
		}

		function initProgramCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/programs", {
				}, function(response, xhr) {
					programCombo.setOptions(response.data);
					originalPrograms = response.data;
					if (selectedPrograms) {
						updateProgramsText();
						programCombo.setText(tag.currentProgramText());
						programCombo.setSelectedOptions(selectedPrograms);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting programs", response);
					resolve(false);
				});
			});
		}

		function initCourseCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/courses", {
				}, function(response, xhr) {
					courseCombo.setOptions(response.data);
					originalCourses = response.data;
					if (selectedCourses) {
						updateCoursesText();
						courseCombo.setText(tag.currentCourseText());
						courseCombo.setSelectedOptions(selectedCourses);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting courses", response);
					resolve(false);
				});
			});
		}

		function initClassCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/classes", {
				}, function(response, xhr) {
					classCombo.setOptions(response.data);
					originalClasses = response.data;
					if (selectedClasses) {
						updateClassesText();
						classCombo.setText(tag.currentClassText());
						classCombo.setSelectedOptions(selectedClasses);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting classes", response);
					resolve(false);
				});
			});
		}

		function initWeekCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/weeks", {
				}, function(response, xhr) {
					weekCombo.setOptions(response.data);
					originalWeeks = response.data;
					if (selectedWeeks) {
						updateWeeksText();
						weekCombo.setText(tag.currentWeekText());
						weekCombo.setSelectedOptions(selectedWeeks);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting weeks", response);
					resolve(false);
				});
			});
		}

		function initViewCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/reporting/filters/views", {
				}, function(response, xhr) {
					viewCombo.setOptions(response.data);
					if (tag.currentView) {
						viewCombo.setText(tag.currentView);
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting views", response);
					resolve(false);
				});
			});
		}

		// Combos save

		function savePeriodsFilter() {
			app.ajax.put("api/reporting/filters/periods", {
				periods: selectedPeriods
			}, function(response, xhr) {
				guf.console.log("save periods success", response);
				updateFilterStatus();
				initCombosMinus(periodCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving periods", response);
			});
		}

		function saveTeachersFilter() {
			var teachersEmails = selectedTeachers.map(function(item) {return item.email;});
			app.ajax.put("api/reporting/filters/teachers", {
				teachers: teachersEmails
			}, function(response, xhr) {
				guf.console.log("save teachers success", response);
				updateFilterStatus();
				initCombosMinus(teacherCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving teachers", response);
			});
		}

		function saveProgramsFilter() {
			app.ajax.put("api/reporting/filters/programs", {
				programs: selectedPrograms
			}, function(response, xhr) {
				guf.console.log("save programs success", response);
				updateFilterStatus();
				initCombosMinus(programCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving programs", response);
			});
		}

		function saveCoursesFilter() {
			app.ajax.put("api/reporting/filters/courses", {
				courses: selectedCourses
			}, function(response, xhr) {
				guf.console.log("save courses success", response);
				updateFilterStatus();
				initCombosMinus(courseCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving courses", response);
			});
		}

		function saveClassesFilter() {
			app.ajax.put("api/reporting/filters/classes", {
				classes: selectedClasses
			}, function(response, xhr) {
				guf.console.log("save classes success", response);
				updateFilterStatus();
				initCombosMinus(classCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving classes", response);
			});
		}

		function saveWeeksFilter() {
			app.ajax.put("api/reporting/filters/weeks", {
				weeks: selectedWeeks
			}, function(response, xhr) {
				guf.console.log("save weeks success", response);
				updateFilterStatus();
				initCombosMinus(weekCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving weeks", response);
			});
		}

		function saveViewFilter() {
			app.ajax.put("api/reporting/filters/view", {
				view: tag.currentView
			}, function(response, xhr) {
				guf.console.log("save view success", response);
				updateFilterStatus();
				initCombosMinus(viewCombo);
				resetSearch();
			}, function(response, xhr) {
				guf.console.error("Error saving view", response);
			});
		}

		function initView() {
			periodCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["period-combo"];
			teacherCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["teacher-combo"];
			programCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["program-combo"];
			courseCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["course-combo"];
			classCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["class-combo"];
			weekCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["week-combo"];
			viewCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["view-combo"];
			applyFilterButton = tag.refs["container-maximized"].refs["actions"].refs["apply-filter"];
			resetFilterButton = tag.refs["container-maximized"].refs["actions"].refs["reset-filter"];
		}

		function initEvents() {
			tag.refs["minimize-button"].on("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.addEventListener("click", minimizeClickHandler);
			periodCombo.on("option-select", periodSelectHandler);
			periodCombo.on("option-deselect", periodDeselectHandler);
			teacherCombo.on("option-select", teacherSelectHandler);
			teacherCombo.on("option-deselect", teacherDeselectHandler);
			programCombo.on("option-select", programSelectHandler);
			programCombo.on("option-deselect", programDeselectHandler);
			courseCombo.on("option-select", courseSelectHandler);
			courseCombo.on("option-deselect", courseDeselectHandler);
			classCombo.on("option-select", classSelectHandler);
			classCombo.on("option-deselect", classDeselectHandler);
			weekCombo.on("option-select", weekSelectHandler);
			weekCombo.on("option-deselect", weekDeselectHandler);
			viewCombo.on("menu-click", viewComboClickHandler);
			applyFilterButton.on("click", applyFilterClickHandler);
			resetFilterButton.on("click", resetFilterClickHandler);
		}

		function removeEvents() {
			tag.refs["minimize-button"].off("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.removeEventListener("click", minimizeClickHandler);
			periodCombo.off("option-select", periodSelectHandler);
			periodCombo.off("option-deselect", periodDeselectHandler);
			teacherCombo.off("option-select", teacherSelectHandler);
			teacherCombo.off("option-deselect", teacherDeselectHandler);
			programCombo.off("option-select", programSelectHandler);
			programCombo.off("option-deselect", programDeselectHandler);
			courseCombo.off("option-select", courseSelectHandler);
			courseCombo.off("option-deselect", courseDeselectHandler);
			classCombo.off("option-select", classSelectHandler);
			classCombo.off("option-deselect", classDeselectHandler);
			weekCombo.off("option-select", weekSelectHandler);
			weekCombo.off("option-deselect", weekDeselectHandler);
			viewCombo.off("menu-click", viewComboClickHandler);
			applyFilterButton.off("click", applyFilterClickHandler);
			resetFilterButton.off("click", resetFilterClickHandler);
		}

		tag.currentPeriodText = function() {
			return tag.currentPeriods === "" ? guf.i18n.get("app.all_periods") : tag.currentPeriods;
		};

		tag.currentTeacherText = function() {
			return tag.currentTeachers === "" ? guf.i18n.get("app.all_teachers") : tag.currentTeachers;
		};

		tag.currentProgramText = function() {
			return tag.currentPrograms === "" ? guf.i18n.get("app.all_programs") : tag.currentPrograms;
		};

		tag.currentCourseText = function() {
			return tag.currentCourses === "" ? guf.i18n.get("app.all_courses") : tag.currentCourses;
		};

		tag.currentClassText = function() {
			return tag.currentClasses === "" ? guf.i18n.get("app.all_classes") : tag.currentClasses;
		};

		tag.currentWeekText = function() {
			return tag.currentWeeks === "" ? guf.i18n.get("app.all_weeks") : tag.currentWeeks;
		};

		tag.on("after-mount", function() {
			initView();
			initEvents();
			app.ajax.get("api/reporting/filters/currentContext", {
			}, function(response, xhr) {
				var data = response.data;
				if (data != null) {
					selectedPeriods = data.periods ? data.periods : [];
					selectedTeachers = data.teachers ? data.teachers : [];
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedClasses = data.classes ? data.classes : [];
					selectedWeeks = data.weeks ? data.weeks : [];
					tag.currentView = data.view ? data.view : "";
					if (data.applied) {
						applyWhenLoaded = true;
					}
				}
				initCombosMinus(null);
				updateFilterStatus();
			}, function(response, xhr) {
				guf.console.error("Error getting current filter context", response);
			});
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-reporting-filter>