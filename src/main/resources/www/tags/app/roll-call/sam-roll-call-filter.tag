<sam-roll-call-filter>
	<div ref="container" class="{container: 1, advanced: guf.ancestor(this, 'sam-roll-call-filter').isAdvancedUser}">
		<guf-linear-layout ref="container-maximized" class="container-maximized" orientation="vertical">
			<guf-linear-layout ref="filter-title" orientation="horizontal" v-align="center">
				<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-top" orientation="horizontal" v-align="center">
				<guf-combo-box ref="period-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.period')} *"></guf-combo-box>
				<guf-combo-box ref="program-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.program')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="course-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.course')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="class-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.class')}" item-tag="sam-class-combo-box-item"></guf-combo-box>
				<guf-datetimepicker ref="date-combo" type="date" inputtype="button" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.date')} *" format="L" autoclose="true" cancel="{guf.i18n.get('guf.cancel')}" class="last"></guf-datetimepicker>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos-bottom" orientation="horizontal" v-align="center">
				<guf-combo-box ref="student-combo" if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.student')} *" item-tag="sam-student-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="teacher-combo" if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.teacher')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-linear-layout ref="actions" class="actions" orientation="horizontal" h-align="right">
					<guf-button ref="reset-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled">{guf.i18n.get('app.reset_filter')}</guf-button>
					<guf-button ref="apply-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled" disabled="true">{guf.i18n.get('app.apply_filter')}</guf-button>
				</guf-linear-layout>
			</guf-linear-layout>
			<div ref="overlay" class="overlay hidden"></div>
		</guf-linear-layout>
		<guf-linear-layout ref="container-minimized" class="container-minimized" orientation="horizontal" v-align="center">
			<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			<div class="spacer"></div>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.period')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentPeriod}</div>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.student')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentStudentText()}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.program')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentProgram}</div>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.teacher')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentTeacherName}</div>
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.course')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentCourse}</div>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" orientation="horizontal" v-align="center" class="empty">
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.class')}</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentClassText()}</div>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" orientation="horizontal" v-align="center" class="empty">
				</guf-linear-layout>
			</guf-linear-layout>
			<guf-linear-layout orientation="vertical">
				<guf-linear-layout orientation="horizontal" v-align="center">
					<div class="filter-title">{guf.i18n.get('app.date')} *</div>
					<div class="filter-value">{guf.ancestor(this,'sam-roll-call-filter').currentDate}</div>
				</guf-linear-layout>
				<guf-linear-layout if="{guf.ancestor(this,'sam-roll-call-filter').isAdvancedUser}" orientation="horizontal" v-align="center" class="empty">
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
			min-width: 700px;
		}
		:scope > .container {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			margin-top: 12px;
			border: 1px solid @lines;
			border-radius: 10px;
			min-height: 150px;
			max-height: 150px;
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
		:scope > .container.advanced {
			min-height: 175px;
			max-height: 175px;
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
		:scope > .container.advanced > .container-maximized {
			min-height: 195px;
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
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-datetimepicker,
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-bottom"] > guf-combo-box {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			margin-right: 16px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-combo-box.last,
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-top"] > guf-datetimepicker.last {
			margin-right: 0px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-bottom"] > guf-linear-layout[ref="actions"] {
			margin-left: 32px;
			-webkit-flex: 3;
			-ms-flex: 3;
			flex: 3;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos-bottom"] > guf-linear-layout[ref="actions"] > guf-button {
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
			PROGRAM: "program",
			COURSE: "course",
			CLASS: "class",
			DATE: "date",
			STUDENT: "student",
			TEACHER: "teacher"
		};

		var filterMinimized = false;
		var periodCombo, courseCombo, classCombo, dateCombo, programCombo, studentCombo, teacherCombo;
		var applyFilterButton, resetFilterButton;
		var selectedClasses = [], originalClasses = [];
		var selectedStudents = [], originalStudents = [];
		var applyWhenLoaded;
		var teachers = [];

		tag.currentPeriod = "";
		tag.currentProgram = "";
		tag.currentCourse = "";
		tag.currentClass = "";
		tag.currentDate = "";
		tag.currentStudents = "";
		tag.currentTeacher = "";
		tag.currentTeacherName = "";

		tag.programDisabled = true;
		tag.courseDisabled = true;
		tag.classDisabled = true;
		tag.isAdvancedUser = app.hasAuthority(app.AUTHORITY.CHANGE_ABSENCE);

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
			tag.programDisabled = tag.currentPeriod.length <= 0;
			tag.courseDisabled = tag.programDisabled || tag.currentProgram.length <= 0;
			tag.classDisabled = tag.courseDisabled || tag.currentCourse.length <= 0;
			var applyFilterEnabled = !tag.classDisabled && tag.currentDate.length > 0;
			if (tag.isAdvancedUser) applyFilterEnabled = applyFilterEnabled && tag.currentTeacher.length > 0;
			applyFilterEnabled ? applyFilterButton.enable() : applyFilterButton.disable();
			resetFilterButton.enable();
			tag.refs["container-maximized"].update();
		}

		function updateCombos() {
			periodCombo.setText(tag.currentPeriod);
			programCombo.setText(tag.currentProgram);
			courseCombo.setText(tag.currentCourse);
			classCombo.setText(tag.currentClassText());
			dateCombo.setValue(tag.currentDate);
			if (tag.isAdvancedUser) studentCombo.setText(tag.currentStudentText());
			if (tag.isAdvancedUser) teacherCombo.setText(tag.currentTeacherName);
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

		function updateClassesText() {
			tag.currentClass = formatMultiValueText(selectedClasses);
		}

		function updateStudentsText() {
			tag.currentStudents = formatMultiValueText(selectedStudents, "id");
		}

		function buildRangesFromArray(anArray) {
			var result = [];
			if(!!anArray) {
				for(var i=0; i<anArray.length; i++) {
					var range = {
						start: moment(anArray[i].start, "YYYY-MM-DD"),
						end: moment(anArray[i].end, "YYYY-MM-DD")
					};
					result.push(range);
				}
			}
			return result;
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

		function programComboClickHandler(item, itemTag) {
			tag.currentProgram = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveProgramFilter();
		}

		function courseComboClickHandler(item, itemTag) {
			tag.currentCourse = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveCourseFilter();
		}

		function classSelectHandler(aClass, itemTag) {
			selectedClasses.push(aClass);
			selectedClasses = originalClasses.filter(function(e) {
				return selectedClasses.indexOf(e) >= 0;
			});
			updateClassesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveClassesFilter();
		}

		function classDeselectHandler(aClass, itemTag) {
			var index = selectedClasses.indexOf(aClass);
			if(index != -1) {
				selectedClasses.splice(index, 1);
			}
			updateClassesText();
			updateCombos();
			tag.refs["container-minimized"].update();
			saveClassesFilter();
		}

		function dateComboClickHandler(dateValue, picker) {
			tag.currentDate = dateValue;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveDateFilter();
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

		function teacherComboClickHandler(item, itemTag) {
			tag.currentTeacherName = item;
			for (var i = 0; i < teachers.length; i++) {
				if (teachers[i].name == item) {
					tag.currentTeacher = teachers[i].email;
				}
			}
			updateCombos();
			tag.refs["container-minimized"].update();
			saveTeacherFilter();
		}

		function applyFilterClickHandler(e, button) {
			applyFilterButton.disable();
			tag.trigger("apply");
			tag.refs["minimize-button"].setToggle(true);
			tag.trigger('filter-minimized', true);
			updateFilterState(tag.refs["minimize-button"].isToggled());
			tag.refs["container-minimized"].update();
		}

		function resetFilterClickHandler(e, button) {
			resetFilterButton.disable();
			app.ajax.put("api/rollcall/filters/reset", {
			}, function(response, xhr) {
				var data = response.data;
				originalClasses = [];
				selectedClasses = [];
				originalStudents = [];
				selectedStudents = [];
				tag.currentPeriod = "";
				tag.currentProgram = "";
				tag.currentCourse = "";
				tag.currentDate = "";
				tag.currentTeacher = "";
				tag.currentTeacherName = "";
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentProgram = data.program ? data.program : "";
					tag.currentCourse = data.course ? data.course : "";
					selectedStudents = data.students ? data.students : [];
					tag.currentTeacher = data.teacher ? data.teacher : "";
					tag.currentTeacherName = data.teacherName ? data.teacherName : "";
					selectedClasses = data.classes ? data.classes : [];
					tag.currentDate = data.date ? data.date : "";
					if (tag.currentDate) {
						var dateMoment = moment(tag.currentDate,"YYYY-MM-DD");
						tag.currentDate = dateMoment.format("L");
						dateCombo.setValue(tag.currentDate, dateMoment);
					}
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
						case COMBO.PROGRAM:
							if(!tag.currentProgram) {
								tag.currentProgram = data.options[0];
								programCombo.setText(tag.currentProgram);
								promises.push(saveProgramFilter(true));
							}
							break;
						case COMBO.COURSE:
							if(!tag.currentCourse) {
								tag.currentCourse = data.options[0];
								courseCombo.setText(tag.currentCourse);
								promises.push(saveCourseFilter(true));
							}
							break;
						case COMBO.TEACHER:
							if(!tag.currentTeacher) {
								tag.currentTeacher = data.options[0].email;
								tag.currentTeacherName = data.options[0].name;
								teacherCombo.setText(tag.currentTeacherName);
								promises.push(saveTeacherFilter(true));
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
			if(aCombo != programCombo) {
				promises.push(initProgramCombo());
			}
			if(aCombo != courseCombo) {
				promises.push(initCourseCombo());
			}
			if(aCombo != classCombo) {
				promises.push(initClassCombo());
			}
			if(tag.isAdvancedUser && aCombo != studentCombo) {
				promises.push(initStudentCombo());
			}
			if(tag.isAdvancedUser && aCombo != teacherCombo) {
				promises.push(initTeacherCombo());
			}
			Promise.all(promises).then(function(combos) {
				Promise.all(autoSelectUnitaryCombos(combos)).then(function(result) {
					var postPromises = [];
					if(aCombo == periodCombo) {
						postPromises.push(initPeriodCombo());
					}
					if(aCombo == programCombo) {
						postPromises.push(initProgramCombo());
					}
					if(aCombo == courseCombo) {
						postPromises.push(initCourseCombo());
					}
					if(aCombo == classCombo) {
						postPromises.push(initClassCombo());
					}
					if(tag.isAdvancedUser && aCombo == studentCombo) {
						postPromises.push(initStudentCombo());
					}
					if(tag.isAdvancedUser && aCombo == teacherCombo) {
						postPromises.push(initTeacherCombo());
					}
					// always get the dates last to ensure they have data
					postPromises.push(initDateCombo());
					return Promise.all(postPromises);
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
				app.ajax.get("api/rollcall/filters/periods", {
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

		function initProgramCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/rollcall/filters/programs", {
				}, function(response, xhr) {
					programCombo.setOptions(response.data);
					if (tag.currentProgram) {
						programCombo.setText(tag.currentProgram);
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
				app.ajax.get("api/rollcall/filters/courses", {
				}, function(response, xhr) {
					courseCombo.setOptions(response.data);
					if (tag.currentCourse) {
						courseCombo.setText(tag.currentCourse);
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

		function initClassCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/rollcall/filters/classes", {
				}, function(response, xhr) {
					classCombo.setOptions(response.data);
					originalClasses = response.data;
					if (selectedClasses) {
						updateClassesText();
						classCombo.setText(tag.currentClassText());
						classCombo.setSelectedOptions(selectedClasses);
					}
					resolve({
						success: true,
						combo: COMBO.CLASS,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting classes", response);
					resolve({
						success: false,
						combo: COMBO.CLASS
					});
				});
			});
		}

		function initDateCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/rollcall/filters/dates", {
				}, function(response, xhr) {
					if(!!response.data.startDate) {
						dateCombo.setPastDate(moment(response.data.startDate, "YYYY-MM-DD"));
					} else {
						dateCombo.setPastDate(moment());
					}
					if(!!response.data.endDate) {
						dateCombo.setFutureDate(moment(response.data.endDate, "YYYY-MM-DD"));
					} else {
						dateCombo.setFutureDate(moment());
					}
					var ranges = buildRangesFromArray(response.data.ranges);
					dateCombo.setValidRanges(ranges);
					if (tag.currentDate) {
						dateCombo.setValue(tag.currentDate);
					}
					resolve({
						success: true,
						combo: COMBO.DATE,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting dates", response);
					resolve({
						success: false,
						combo: COMBO.DATE
					});
				});
			});
		}

		function initStudentCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/rollcall/filters/students", {
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

		function initTeacherCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/rollcall/filters/teachers", {
				}, function(response, xhr) {
					teachers = response.data;
					var teacherNames = [];
					for (var i = 0; i < teachers.length; i++) {
						teacherNames.push(teachers[i].name);
					}
					teacherCombo.setOptions(teacherNames);
					if (tag.currentTeacherName) {
						teacherCombo.setText(tag.currentTeacherName);
					}
					resolve({
						success: true,
						combo: COMBO.TEACHER,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting teachers", response);
					resolve({
						success: false,
						combo: COMBO.TEACHER
					});
				});
			});
		}

		// Combos save

		function savePeriodFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/rollcall/filters/period", {
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

		function saveProgramFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/rollcall/filters/program", {
					program: tag.currentProgram
				}, function(response, xhr) {
					guf.console.log("save program success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(programCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving period", response);
					resolve(false);
				});
			});
		}

		function saveCourseFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/rollcall/filters/course", {
					course: tag.currentCourse
				}, function(response, xhr) {
					guf.console.log("save course success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(courseCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving course", response);
					resolve(false);
				});
			});
		}

		function saveClassesFilter() {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/rollcall/filters/classes", {
					classes: selectedClasses
				}, function(response, xhr) {
					guf.console.log("save classes success", response);
					updateFilterStatus();
					initCombosMinus(classCombo);
					resetSearch();
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving classes", response);
					resolve(false);
				});
			});
		}

		function saveDateFilter() {
			return new Promise(function(resolve, reject) {
				var currentDate = moment(tag.currentDate, "L").format("YYYY-MM-DD");
				app.ajax.put("api/rollcall/filters/date", {
					date: currentDate
				}, function(response, xhr) {
					guf.console.log("save date success", response);
					updateFilterStatus();
					initCombosMinus(dateCombo);
					resetSearch();
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving date", response);
					resolve(false);
				});
			});
		}

		function saveStudentsFilter() {
			return new Promise(function(resolve, reject) {
				var studentsIds = selectedStudents.map(function(item) {return item.id;});
				app.ajax.put("api/rollcall/filters/students", {
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

		function saveTeacherFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/rollcall/filters/teacher", {
					teacher: tag.currentTeacher
				}, function(response, xhr) {
					guf.console.log("save teacher success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(teacherCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving teacher", response);
					resolve(false);
				});
			});
		}

		function initView() {
			periodCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["period-combo"];
			programCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["program-combo"];
			courseCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["course-combo"];
			classCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["class-combo"];
			dateCombo = tag.refs["container-maximized"].refs["filter-combos-top"].refs["date-combo"];
			if (tag.isAdvancedUser) studentCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["student-combo"];
			if (tag.isAdvancedUser) teacherCombo = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["teacher-combo"];
			applyFilterButton = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["actions"].refs["apply-filter"];
			resetFilterButton = tag.refs["container-maximized"].refs["filter-combos-bottom"].refs["actions"].refs["reset-filter"];
		}

		function initEvents() {
			tag.refs["minimize-button"].on("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.addEventListener("click", minimizeClickHandler);
			periodCombo.on("menu-click", periodComboClickHandler);
			programCombo.on("menu-click", programComboClickHandler);
			courseCombo.on("menu-click", courseComboClickHandler);
			classCombo.on("option-select", classSelectHandler);
			classCombo.on("option-deselect", classDeselectHandler);
			dateCombo.on("date-change", dateComboClickHandler);
			if (tag.isAdvancedUser) studentCombo.on("option-select", studentSelectHandler);
			if (tag.isAdvancedUser) studentCombo.on("option-deselect", studentDeselectHandler);
			if (tag.isAdvancedUser) teacherCombo.on("menu-click", teacherComboClickHandler);
			applyFilterButton.on("click", applyFilterClickHandler);
			resetFilterButton.on("click", resetFilterClickHandler);
		}

		function removeEvents() {
			tag.refs["minimize-button"].off("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.removeEventListener("click", minimizeClickHandler);
			periodCombo.off("menu-click", periodComboClickHandler);
			programCombo.off("menu-click", programComboClickHandler);
			courseCombo.off("menu-click", courseComboClickHandler);
			classCombo.off("option-select", classSelectHandler);
			classCombo.off("option-deselect", classDeselectHandler);
			dateCombo.off("date-change", dateComboClickHandler);
			if (tag.isAdvancedUser) studentCombo.off("option-select", studentSelectHandler);
			if (tag.isAdvancedUser) studentCombo.off("option-deselect", studentDeselectHandler);
			if (tag.isAdvancedUser) teacherCombo.off("menu-click", teacherComboClickHandler);
			applyFilterButton.off("click", applyFilterClickHandler);
			resetFilterButton.off("click", resetFilterClickHandler);
		}

		tag.currentClassText = function() {
			return tag.currentClass === "" ? guf.i18n.get("app.all_classes") : tag.currentClass;
		};

		tag.currentStudentText = function() {
			return tag.currentStudents === "" ? guf.i18n.get("app.all_students") : tag.currentStudents;
		};

		tag.on("after-mount", function() {
			initView();
			initEvents();
			app.ajax.get("api/rollcall/filters/currentContext", {
			}, function(response, xhr) {
				var data = response.data;
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentProgram = data.program ? data.program : "";
					tag.currentCourse = data.course ? data.course : "";
					selectedStudents = data.students ? data.students : [];
					tag.currentTeacher = data.teacher ? data.teacher : "";
					tag.currentTeacherName = data.teacherName ? data.teacherName : "";
					selectedClasses = data.classes ? data.classes : [];
					tag.currentDate = data.date ? data.date : "";
					if (tag.currentDate) {
						var dateMoment = moment(tag.currentDate,"YYYY-MM-DD");
						tag.currentDate = dateMoment.format("L");
						dateCombo.setValue(tag.currentDate, dateMoment);
					}
					if (data.applied) {
						applyWhenLoaded = true;
					}
				}
				initCombosMinus(null);
				updateFilterStatus();
			}, function(response, xhr) {
				guf.console.error("Error getting current filter context", response);
				initCombosMinus(null);
				updateFilterStatus();
			});			
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-roll-call-filter>