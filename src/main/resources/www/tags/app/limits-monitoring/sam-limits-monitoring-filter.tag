<sam-limits-monitoring-filter>
	<div ref="container" class="container">
		<guf-linear-layout ref="container-maximized" class="container-maximized" orientation="vertical">
			<guf-linear-layout ref="filter-title" orientation="horizontal" v-align="center">
				<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-top" orientation="horizontal" v-align="center">
				<guf-combo-box ref="period-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.period')} *"></guf-combo-box>
				<guf-combo-box ref="view-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.view')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="program-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.program')} *" disabled="{guf.ancestor(this,'sam-limits-monitoring-filter').programDisabled}"></guf-combo-box>
				<guf-combo-box ref="course-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.course')} *" item-tag="sam-class-combo-box-item" disabled="{guf.ancestor(this,'sam-limits-monitoring-filter').courseDisabled}"></guf-combo-box>
				<guf-combo-box ref="student-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-student-combo-box-item" placeholder="{guf.i18n.get('app.student')}"></guf-combo-box>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-bottom" orientation="horizontal" v-align="center">
				<guf-combo-box ref="exceed-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.exceed')}"></guf-combo-box>
				<guf-combo-box ref="exceed-courses-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.exceed_courses')}"></guf-combo-box>
				<guf-combo-box ref="notification-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.notification')}" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="meeting-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.meeting')}" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box show="{guf.ancestor(this,'sam-limits-monitoring-filter').showAbsences}" ref="absences-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.absences')}" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<div if="{!guf.ancestor(this,'sam-limits-monitoring-filter').showAbsences}" class="flex1"></div>
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
					<div class="filter-title">{guf.i18n.get('app.period')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentPeriod}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.exceed')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentExceed}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.view')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentView}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.exceed_courses')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentExceedCourses}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.program')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentProgramText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.notification')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentNotification}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.course')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentCourseText()}</div>
				</guf-linear-layout>
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.meeting')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentMeeting}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.student')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentStudentText()}</div>
				</guf-linear-layout>
				<guf-linear-layout show="{guf.ancestor(this,'sam-limits-monitoring-filter').showAbsences}" orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.absences')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-limits-monitoring-filter').currentAbsences}</div>
				</guf-linear-layout>
				<guf-linear-layout show="{!guf.ancestor(this,'sam-limits-monitoring-filter').showAbsences}" orientation="horizontal" v-align="center" class="empty">
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
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-combo-box:last-child,
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-bottom"] > guf-combo-box:last-child {
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

		var COMBO = {
			PERIOD: "period",
			VIEW: "view",
			PROGRAM: "program",
			COURSE: "course",
			STUDENT: "student",
			EXCEED: "exceed",
			EXCEED_COURSES: "exceed_courses",
			NOTIFICATION: "notification",
			MEETING: "meeting",
			ABSENCES: "absences"
		};

		var filterMinimized = false;
		var periodCombo, viewCombo, programCombo, courseCombo, studentCombo;
		var exceedCombo, exceedCoursesCombo, notificationCombo, meetingCombo;
		var applyFilterButton, resetFilterButton;
		var applyWhenLoaded;
		var originalPrograms = [], selectedPrograms = [];
		var originalCourses = [], selectedCourses = [];
		var originalStudents = [], selectedStudents = [];

		tag.currentPeriod = "";
		tag.currentView = "";
		tag.currentPrograms = "";
		tag.currentCourses = "";
		tag.currentStudents = "";
		tag.currentExceed = "";
		tag.currentExceedCourses = "";
		tag.currentNotification = "";
		tag.currentMeeting = "";
		tag.currentAbsences = "";
		tag.programDisabled = false;
		tag.courseDisabled = false;
		tag.showAbsences = false;

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
			tag.programDisabled = tag.currentView === app.LIMITS_MONITORING_VIEW.SCHOOL;
			tag.courseDisabled = tag.programDisabled || tag.currentView === app.LIMITS_MONITORING_VIEW.PROGRAM;
			tag.currentPeriod.length > 0 && tag.currentView.length > 0 ? applyFilterButton.enable() : applyFilterButton.disable();
			resetFilterButton.enable();
			tag.refs["container-maximized"].update();
		}

		function updateCombos() {
			periodCombo.setText(tag.currentPeriod);
			viewCombo.setText(tag.currentView);
			programCombo.setText(tag.currentProgramText());
			courseCombo.setText(tag.currentCourseText());
			studentCombo.setText(tag.currentStudentText());
			exceedCombo.setText(tag.currentExceed);
			exceedCoursesCombo.setText(tag.currentExceedCourses);
			notificationCombo.setText(tag.currentNotification);
			meetingCombo.setText(tag.currentMeeting);
			absencesCombo.setText(tag.currentAbsences);
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

		function updateProgramsText() {
			tag.currentPrograms = formatMultiValueText(selectedPrograms);
		}

		function updateCoursesText() {
			tag.currentCourses = formatMultiValueText(selectedCourses);
		}

		function updateStudentsText() {
			tag.currentStudents = formatMultiValueText(selectedStudents, "id");
		}

		function minimizeClickHandler(e) {
			tag.refs["minimize-button"].toggle();
			tag.trigger('filter-minimized', tag.refs["minimize-button"].isToggled());
			updateFilterState(tag.refs["minimize-button"].isToggled());
		}

		function periodComboClickHandler(item, itemTag) {
			tag.currentPeriod = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			savePeriodFilter();
		}

		function viewComboClickHandler(item, itemTag) {
			tag.currentView = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveViewFilter();
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

		function studentSelectHandler(item, itemTag) {
			selectedStudents.push(item);
			selectedStudents = originalStudents.filter(function(e) {
				for(var i=0; i<selectedStudents.length; i++) {
					if(selectedStudents[i].id === e.id) {
						return true;
					}
				}
				return false;
			});
			updateStudentsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveStudentsFilter();
		}

		function studentDeselectHandler(item, itemTag) {
			var index = selectedStudents.map(function(student) {return student.id}).indexOf(item.id);
			if(index != -1) {
				selectedStudents.splice(index, 1);
			}
			updateStudentsText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveStudentsFilter();
		}

		function exceedComboClickHandler(item, itemTag) {
			tag.currentExceed = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveExceedFilter();
		}

		function exceedCoursesComboClickHandler(item, itemTag) {
			tag.currentExceedCourses = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveExceedCoursesFilter();
		}

		function notificationComboClickHandler(item, itemTag) {
			tag.currentNotification = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveNotificationFilter();
		}

		function meetingComboClickHandler(item, itemTag) {
			tag.currentMeeting = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveMeetingFilter();
		}

		function absencesComboClickHandler(item, itemTag) {
			tag.currentAbsences = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveAbsencesFilter();
		}

		function applyFilterClickHandler(e, button) {
			guf.console.log("apply filter clicked");
			applyFilterButton.disable();
			tag.trigger("apply", tag.currentView, tag.currentExceed, tag.currentExceedCourses);
			tag.refs["minimize-button"].setToggle(true);
			tag.trigger('filter-minimized', true);
			updateFilterState(tag.refs["minimize-button"].isToggled());
			tag.refs["container-minimized"].update();
		}

		function resetFilterClickHandler(e, button) {
			resetFilterButton.disable();
			app.ajax.put("api/absencesdetail/filters/resetCurrentContext", {
			}, function(response, xhr) {
				guf.console.log("reset filter success", response);
				var data = response.data;
				originalPrograms = [];
				selectedPrograms = [];
				originalCourses = [];
				selectedCourses = [];
				originalStudents = [];
				selectedStudents = [];
				tag.currentPeriod = "";
				tag.currentView = "";
				tag.currentPrograms = "";
				tag.currentCourses = "";
				tag.currentStudents = "";
				tag.currentExceed = "";
				tag.currentExceedCourses = "";
				tag.currentNotification = "";
				tag.currentMeeting = "";
				tag.currentAbsences = "";
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentView = data.view ? data.view : "";
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedStudents = data.students ? data.students : [];
					tag.currentExceed = data.exceed ? data.exceed : "";
					tag.currentExceedCourses = data.exceedCourses ? data.exceedCourses : "";
					tag.currentNotification = data.notification ? data.notification : "";
					tag.currentMeeting = data.meeting ? data.meeting : "";
					tag.currentAbsences = data.absences ? data.absences : "";
					tag.showAbsences = data.lrmAdmin ? data.lrmAdmin : false;
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

		function autoSelectUnitaryCombos(combos) {
			var promises = [];
			for(var i=0; i<combos.length; i++) {
				var data = combos[i];
				if(data.success && data.options.length === 1) {
					switch(data.combo) {
						case COMBO.PERIOD:
							if(!tag.currentPeriod) {
								tag.currentPeriod = data.options[0];
								periodCombo.setText(tag.currentPeriod);
								promises.push(savePeriodFilter(true));
							}
							break;
						case COMBO.VIEW:
							if(!tag.currentView) {
								tag.currentView = data.options[0];
								viewCombo.setText(tag.currentView);
								promises.push(saveViewFilter(true));
							}
							break;
						case COMBO.EXCEED:
							if(!tag.currentExceed) {
								tag.currentExceed = data.options[0];
								exceedCombo.setText(tag.currentExceed);
								promises.push(saveExceedFilter(true));
							}
							break;
						case COMBO.EXCEED_COURSES:
							if(!tag.currentExceedCourses) {
								tag.currentExceedCourses = data.options[0];
								exceedCoursesCombo.setText(tag.currentExceedCourses);
								promises.push(saveExceedCoursesFilter(true));
							}
							break;
						case COMBO.NOTIFICATION:
							if(!tag.currentNotification) {
								tag.currentNotification = data.options[0];
								notificationCombo.setText(tag.currentNotification);
								promises.push(saveNotificationFilter(true));
							}
							break;
						case COMBO.MEETING:
							if(!tag.currentMeeting) {
								tag.currentMeeting = data.options[0];
								meetingCombo.setText(tag.currentMeeting);
								promises.push(saveMeetingFilter(true));
							}
							break;
						case COMBO.ABSENCES:
							if(!tag.currentAbsences) {
								tag.currentAbsences = data.options[0];
								absencesCombo.setText(tag.currentAbsences);
								promises.push(saveAbsencesFilter(true));
							}
							break;
					}
				}
			}
			return promises;
		}

		function initCombosMinus(aCombo) {
			tag.refs["container-maximized"].refs["overlay"].classList.remove("hidden");
			var promises = [];
			if(aCombo != periodCombo) {
				promises.push(initPeriodCombo());
			}
			if(aCombo != viewCombo) {
				promises.push(initViewCombo());
			}
			if(aCombo != programCombo) {
				promises.push(initProgramCombo());
			}
			if(aCombo != courseCombo) {
				promises.push(initCourseCombo());
			}
			if(aCombo != studentCombo) {
				promises.push(initStudentCombo());
			}
			if(aCombo != exceedCombo) {
				promises.push(initExceedCombo());
			}
			if(aCombo != exceedCoursesCombo) {
				promises.push(initExceedCoursesCombo());
			}
			if(aCombo != notificationCombo) {
				promises.push(initNotificationCombo());
			}
			if(aCombo != meetingCombo) {
				promises.push(initMeetingCombo());
			}
			if(aCombo != absencesCombo) {
				promises.push(initAbsencesCombo());
			}
			Promise.all(promises).then(function(combos) {
				Promise.all(autoSelectUnitaryCombos(combos)).then(function(result) {
					if(aCombo == periodCombo) {
						return initPeriodCombo();
					}
					if(aCombo == viewCombo) {
						return initViewCombo();
					}
					if(aCombo == programCombo) {
						return initProgramCombo();
					}
					if(aCombo == courseCombo) {
						return initCourseCombo();
					}
					if(aCombo == studentCombo) {
						return initStudentCombo();
					}
					if(aCombo == exceedCombo) {
						return initExceedCombo();
					}
					if(aCombo == exceedCoursesCombo) {
						return initExceedCoursesCombo();
					}
					if(aCombo == notificationCombo) {
						return initNotificationCombo();
					}
					if(aCombo == meetingCombo) {
						return initMeetingCombo();
					}
					if(aCombo == absencesCombo) {
						return initAbsencesCombo();
					}
					return true;
				}).then(function() {
					tag.refs["container-maximized"].refs["overlay"].classList.add("hidden");
					tag.refs["container-minimized"].update();
					if (applyWhenLoaded) {
						applyFilterClickHandler();
						applyWhenLoaded = false;
					}
				});
			});
		}

		// Combos init

		function initPeriodCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/periods", {
				}, function(response, xhr) {
					periodCombo.setOptions(response.data);
					if (tag.currentPeriod) {
						periodCombo.setText(tag.currentPeriod);
					}
					resolve({
						success: true,
						combo: COMBO.PERIOD,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting periods", response);
					resolve({
						success: false,
						combo: COMBO.PERIOD
					});
				});
			});
		}

		function initViewCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/views", {
				}, function(response, xhr) {
					viewCombo.setOptions(response.data);
					if (tag.currentView) {
						viewCombo.setText(tag.currentView);
					}
					resolve({
						success: true,
						combo: COMBO.VIEW,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting views", response);
					resolve({
						success: false,
						combo: COMBO.VIEW
					});
				});
			});
		}

		function initProgramCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/programs", {
				}, function(response, xhr) {
					programCombo.setOptions(response.data);
					originalPrograms = response.data;
					if (selectedPrograms) {
						updateProgramsText();
						programCombo.setText(tag.currentProgramText());
						programCombo.setSelectedOptions(selectedPrograms);
					}
					resolve({
						success: true,
						combo: COMBO.PROGRAM,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting programs", response);
					resolve({
						success: false,
						combo: COMBO.PROGRAM
					});
				});
			});
		}

		function initCourseCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/courses", {
				}, function(response, xhr) {
					courseCombo.setOptions(response.data);
					originalCourses = response.data;
					if (selectedCourses) {
						updateCoursesText();
						courseCombo.setText(tag.currentCourseText());
						courseCombo.setSelectedOptions(selectedCourses);
					}
					resolve({
						success: true,
						combo: COMBO.COURSE,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting courses", response);
					resolve({
						success: false,
						combo: COMBO.COURSE
					});
				});
			});
		}

		function initStudentCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/students", {
				}, function(response, xhr) {
					studentCombo.setOptions(response.data);
					originalStudents = response.data;
					if (selectedStudents) {
						if(selectedStudents.length && typeof selectedStudents[0] !== "object") {
							selectedStudents = originalStudents.filter(function(e) {
								for(var i=0; i<selectedStudents.length; i++) {
									if(selectedStudents[i] === e.id) {
										return true;
									}
								}
								return false;
							});
						}
						updateStudentsText();
						studentCombo.setText(tag.currentStudentText());
						studentCombo.setSelectedOptions(selectedStudents);
					}
					resolve({
						success: true,
						combo: COMBO.STUDENT,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting students", response);
					resolve({
						success: false,
						combo: COMBO.STUDENT
					});
				});
			});
		}

		function initExceedCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/exceed", {
				}, function(response, xhr) {
					exceedCombo.setOptions(response.data);
					if (tag.currentExceed) {
						exceedCombo.setText(tag.currentExceed);
					}
					resolve({
						success: true,
						combo: COMBO.EXCEED,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting exceed", response);
					resolve({
						success: false,
						combo: COMBO.EXCEED
					});
				});
			});
		}

		function initExceedCoursesCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/exceedCourses", {
				}, function(response, xhr) {
					exceedCoursesCombo.setOptions(response.data);
					if (tag.currentExceedCourses) {
						exceedCoursesCombo.setText(tag.currentExceedCourses);
					}
					resolve({
						success: true,
						combo: COMBO.EXCEED_COURSES,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting exceed courses", response);
					resolve({
						success: false,
						combo: COMBO.EXCEED_COURSES
					});
				});
			});
		}

		function initNotificationCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/notification", {
				}, function(response, xhr) {
					notificationCombo.setOptions(response.data);
					if (tag.currentNotification) {
						notificationCombo.setText(tag.currentNotification);
					}
					resolve({
						success: true,
						combo: COMBO.NOTIFICATION,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting notification", response);
					resolve({
						success: false,
						combo: COMBO.NOTIFICATION
					});
				});
			});
		}

		function initMeetingCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/meeting", {
				}, function(response, xhr) {
					meetingCombo.setOptions(response.data);
					if (tag.currentMeeting) {
						meetingCombo.setText(tag.currentMeeting);
					}
					resolve({
						success: true,
						combo: COMBO.MEETING,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting meeting", response);
					resolve({
						success: false,
						combo: COMBO.MEETING
					});
				});
			});
		}

		function initAbsencesCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/absencesdetail/filters/absences", {
				}, function(response, xhr) {
					absencesCombo.setOptions(response.data);
					if (tag.currentAbsences) {
						absencesCombo.setText(tag.currentAbsences);
					}
					resolve({
						success: true,
						combo: COMBO.ABSENCES,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting absences", response);
					resolve({
						success: false,
						combo: COMBO.ABSENCES
					});
				});
			});
		}

		// Combos save

		function savePeriodFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/period", {
					period: tag.currentPeriod
				}, function(response, xhr) {
					guf.console.log("save period success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(periodCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving period", response);
					resolve(false);
				});
			});
		}

		function saveViewFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/view", {
					view: tag.currentView
				}, function(response, xhr) {
					guf.console.log("save view success", response, noCascade);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(viewCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving view", response);
					resolve(false);
				});
			});
		}

		function saveProgramsFilter() {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/programs", {
					programs: selectedPrograms
				}, function(response, xhr) {
					guf.console.log("save programs success", response);
					updateFilterStatus();
					initCombosMinus(programCombo);
					resetSearch();
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving programs", response);
					resolve(false);
				});
			});
		}

		function saveCoursesFilter() {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/courses", {
					courses: selectedCourses
				}, function(response, xhr) {
					guf.console.log("save courses success", response);
					updateFilterStatus();
					initCombosMinus(courseCombo);
					resetSearch();
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving courses", response);
					resolve(false);
				});
			});
		}

		function saveStudentsFilter() {
			return new Promise(function(resolve, reject) {
				var studentsIds = selectedStudents.map(function(item) {return item.id;});
				app.ajax.put("api/absencesdetail/filters/students", {
					students: studentsIds
				}, function(response, xhr) {
					guf.console.log("save students success", response);
					updateFilterStatus();
					initCombosMinus(studentCombo);
					resetSearch();
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving students", response);
					resolve(false);
				});
			});
		}

		function saveExceedFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/exceed", {
					exceed: tag.currentExceed
				}, function(response, xhr) {
					guf.console.log("save exceed success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(exceedCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving exceed", response);
					resolve(false);
				});
			});
		}

		function saveExceedCoursesFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/exceedCourses", {
					exceedCourse: tag.currentExceedCourses
				}, function(response, xhr) {
					guf.console.log("save exceed courses success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(exceedCoursesCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving exceed courses", response);
					resolve(false);
				});
			});
		}

		function saveNotificationFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/notification", {
					notification: tag.currentNotification
				}, function(response, xhr) {
					guf.console.log("save notification success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(notificationCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving notification", response);
					resolve(false);
				});
			});
		}

		function saveMeetingFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/meeting", {
					meeting: tag.currentMeeting
				}, function(response, xhr) {
					guf.console.log("save meeting success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(meetingCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving meeting", response);
					resolve(false);
				});
			});
		}
		
		function saveAbsencesFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/absencesdetail/filters/absences", {
					absences: tag.currentAbsences
				}, function(response, xhr) {
					guf.console.log("save absences success", response);
					updateFilterStatus();
					if (!noCascade) {
						initCombosMinus(absencesCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving absences", response);
					resolve(false);
				});
			});
		}

		function initView() {
			periodCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["period-combo"];
			viewCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["view-combo"];
			programCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["program-combo"];
			courseCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["course-combo"];
			studentCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["student-combo"];
			exceedCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["exceed-combo"];
			exceedCoursesCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["exceed-courses-combo"];
			notificationCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["notification-combo"];
			meetingCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["meeting-combo"];
			applyFilterButton = tag.refs["container-maximized"].refs["actions"].refs["apply-filter"];
			resetFilterButton = tag.refs["container-maximized"].refs["actions"].refs["reset-filter"];
			absencesCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["absences-combo"];
		}

		function initEvents() {
			tag.refs["minimize-button"].on("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.addEventListener("click", minimizeClickHandler);
			periodCombo.on("menu-click", periodComboClickHandler);
			viewCombo.on("menu-click", viewComboClickHandler);
			programCombo.on("option-select", programSelectHandler);
			programCombo.on("option-deselect", programDeselectHandler);
			courseCombo.on("option-select", courseSelectHandler);
			courseCombo.on("option-deselect", courseDeselectHandler);
			studentCombo.on("option-select", studentSelectHandler);
			studentCombo.on("option-deselect", studentDeselectHandler);
			exceedCombo.on("menu-click", exceedComboClickHandler);
			exceedCoursesCombo.on("menu-click", exceedCoursesComboClickHandler);
			notificationCombo.on("menu-click", notificationComboClickHandler);
			meetingCombo.on("menu-click", meetingComboClickHandler);
			absencesCombo.on("menu-click", absencesComboClickHandler);
			applyFilterButton.on("click", applyFilterClickHandler);
			resetFilterButton.on("click", resetFilterClickHandler);
		}

		function removeEvents() {
			tag.refs["minimize-button"].off("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.removeEventListener("click", minimizeClickHandler);
			periodCombo.off("menu-click", periodComboClickHandler);
			viewCombo.off("menu-click", viewComboClickHandler);
			programCombo.off("option-select", programSelectHandler);
			programCombo.off("option-deselect", programDeselectHandler);
			courseCombo.off("option-select", courseSelectHandler);
			courseCombo.off("option-deselect", courseDeselectHandler);
			studentCombo.off("option-select", studentSelectHandler);
			studentCombo.off("option-deselect", studentDeselectHandler);
			exceedCombo.off("menu-click", exceedComboClickHandler);
			exceedCoursesCombo.off("menu-click", exceedCoursesComboClickHandler);
			notificationCombo.off("menu-click", notificationComboClickHandler);
			meetingCombo.off("menu-click", meetingComboClickHandler);
			absencesCombo.off("menu-click", absencesComboClickHandler);
			applyFilterButton.off("click", applyFilterClickHandler);
			resetFilterButton.off("click", resetFilterClickHandler);
		}

		tag.currentProgramText = function() {
			return tag.currentPrograms === "" ? guf.i18n.get("app.all_programs") : tag.currentPrograms;
		};

		tag.currentCourseText = function() {
			return tag.currentCourses === "" ? guf.i18n.get("app.all_courses") : tag.currentCourses;
		};

		tag.currentStudentText = function() {
			return tag.currentStudents === "" ? guf.i18n.get("app.all_students") : tag.currentStudents;
		};

		tag.on("after-mount", function() {
			initView();
			initEvents();
			app.ajax.get("api/absencesdetail/filters/currentContext", {
			}, function(response, xhr) {
				var data = response.data;
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentView = data.view ? data.view : "";
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedStudents = data.students ? data.students : [];
					tag.currentExceed = data.exceed ? data.exceed : "";
					tag.currentExceedCourses = data.exceedCourses ? data.exceedCourses : "";
					tag.currentNotification = data.notification ? data.notification : "";
					tag.currentMeeting = data.meeting ? data.meeting : "";
					tag.currentAbsences = data.absences ? data.absences : "";
					tag.showAbsences = data.lrmAdmin ? data.lrmAdmin : false;
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
</sam-limits-monitoring-filter>