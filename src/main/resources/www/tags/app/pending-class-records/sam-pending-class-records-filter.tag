<sam-pending-class-records-filter>
	<div ref="container" class="container">
		<guf-linear-layout ref="container-maximized" class="container-maximized" orientation="vertical">
			<guf-linear-layout ref="filter-title" orientation="horizontal" v-align="center">
				<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos" orientation="horizontal" v-align="center">
				<guf-combo-box ref="period-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.period')} *"></guf-combo-box>
				<guf-combo-box ref="program-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-class-combo-box-item" placeholder="{guf.i18n.get('app.program')} *"></guf-combo-box>
				<guf-combo-box ref="course-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.course')} *" item-tag="sam-class-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="class-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.class')} *" item-tag="sam-class-combo-box-item"></guf-combo-box>
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
			<div class="filter-title">{guf.i18n.get('app.period')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-pending-class-records-filter').currentPeriodText()}</div>
			<div class="filter-title">{guf.i18n.get('app.program')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-pending-class-records-filter').currentProgramText()}</div>
			<div class="filter-title">{guf.i18n.get('app.course')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-pending-class-records-filter').currentCourseText()}</div>
			<div class="filter-title">{guf.i18n.get('app.class')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-pending-class-records-filter').currentClassText()}</div>
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
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos"] > guf-combo-box {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			margin-right: 16px;
		}
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos"] > guf-combo-box:last-child {
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
		:scope > .container > .container-minimized > .filter-title {
			font-size: 12px;
			color: @lines;
			margin-left: 15px;
			margin-right: 8px;
		}
		:scope > .container > .container-minimized > .filter-value {
			font-size: 14px;
			color: #000000;
			margin-right: 15px;
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
		var periodCombo, programCombo, courseCombo, classCombo;
		var applyFilterButton, resetFilterButton;
		var applyWhenLoaded;
		var originalPeriods = [], selectedPeriods = [];
		var originalPrograms = [], selectedPrograms = [];
		var originalCourses = [], selectedCourses = [];
		var originalClasses = [], selectedClasses = [];

		tag.currentPeriods = "";
		tag.currentPrograms = "";
		tag.currentCourses = "";
		tag.currentClasses = "";

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
			var applyButtonEnabled = tag.currentPeriods.length > 0;
			applyButtonEnabled ? applyFilterButton.enable() : applyFilterButton.disable();
			resetFilterButton.enable();
		}

		function updateCombos() {
			periodCombo.setText(tag.currentPeriodText());
			programCombo.setText(tag.currentProgramText());
			courseCombo.setText(tag.currentCourseText());
			classCombo.setText(tag.currentClassText());
		}

		function formatMultiValueText(values) {
			var resultText = "";
			for (var i = 0; i < values.length; i++) {
				if (i > 0) {
					resultText += ", ";
				}
				resultText += values[i];
			}
			return resultText;
		}

		function updatePeriodsText() {
			tag.currentPeriods = formatMultiValueText(selectedPeriods);
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

		function applyFilterClickHandler(e, button) {
			guf.console.log("apply filter clicked");
			applyFilterButton.disable();
			tag.trigger("apply");
			tag.refs["minimize-button"].setToggle(true);
			tag.trigger('filter-minimized', true);
			updateFilterState(tag.refs["minimize-button"].isToggled());
			tag.refs["container-minimized"].update();
		}

		function resetFilterClickHandler(e, button) {
			resetFilterButton.disable();
			app.ajax.post("api/pendingclassrecords/filters/reset", {
			}, function(response, xhr) {
				guf.console.log("reset filter success", response);
				var data = response.data;
				originalPeriods = [];
				selectedPeriods = [];
				originalPrograms = [];
				selectedPrograms = [];
				originalCourses = [];
				selectedCourses = [];
				originalClasses = [];
				selectedClasses = [];
				tag.currentPeriods = "";
				tag.currentPrograms = "";
				tag.currentCourses = "";
				tag.currentClasses = "";
				if (data != null) {
					selectedPeriods = data.periods ? data.periods : [];
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedClasses = data.classes ? data.classes : [];
					if (data.applied) {
						applyWhenLoaded = true;
					}
				}
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
			if(aCombo != programCombo) {
				promises.push(initProgramCombo());
			}
			if(aCombo != courseCombo) {
				promises.push(initCourseCombo());
			}
			if(aCombo != classCombo) {
				promises.push(initClassCombo());
			}
			Promise.all(promises).then(function(result) {
				guf.console.log("promises result", result);
				tag.refs["container-maximized"].refs["overlay"].classList.add("hidden");
				if (applyWhenLoaded) {
					applyFilterClickHandler();
					applyWhenLoaded = false;
				}
			});
		}

		function initPeriodCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/pendingclassrecords/filters/periods", {
				}, function(response, xhr) {
					periodCombo.setOptions(response.data);
					originalPeriods = response.data;
					if (selectedPeriods) {
						updatePeriodsText();
						periodCombo.setText(tag.currentPeriodText());
						periodCombo.setSelectedOptions(selectedPeriods);
						updateFilterStatus();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error getting periods", response);
					resolve(false);
				});
			});
		}

		function initProgramCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/pendingclassrecords/filters/programs", {
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
				app.ajax.get("api/pendingclassrecords/filters/courses", {
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
				app.ajax.get("api/pendingclassrecords/filters/classes", {
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

		function savePeriodsFilter() {
			app.ajax.put("api/pendingclassrecords/filters/periods", {
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

		function saveProgramsFilter() {
			app.ajax.put("api/pendingclassrecords/filters/programs", {
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
			app.ajax.put("api/pendingclassrecords/filters/courses", {
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
			app.ajax.put("api/pendingclassrecords/filters/classes", {
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
		
		function userCantPerformClassRecords() {
			guf.createDialog(
				guf.i18n.get("app.message"), 
				guf.i18n.get("app.this_user_cant_perform_class_records"), 
				guf.i18n.get("guf.ok"), 
				null, 
				function() {
					tag.trigger("go-out");
				}
			);
		}

		function initView() {
			periodCombo = tag.refs["container-maximized"].refs["filter-combos"].refs["period-combo"];
			programCombo = tag.refs["container-maximized"].refs["filter-combos"].refs["program-combo"];
			courseCombo = tag.refs["container-maximized"].refs["filter-combos"].refs["course-combo"];
			classCombo = tag.refs["container-maximized"].refs["filter-combos"].refs["class-combo"];
			applyFilterButton = tag.refs["container-maximized"].refs["actions"].refs["apply-filter"];
			resetFilterButton = tag.refs["container-maximized"].refs["actions"].refs["reset-filter"];
		}

		function initEvents() {
			tag.refs["minimize-button"].on("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.addEventListener("click", minimizeClickHandler);
			periodCombo.on("option-select", periodSelectHandler);
			periodCombo.on("option-deselect", periodDeselectHandler);
			programCombo.on("option-select", programSelectHandler);
			programCombo.on("option-deselect", programDeselectHandler);
			courseCombo.on("option-select", courseSelectHandler);
			courseCombo.on("option-deselect", courseDeselectHandler);
			classCombo.on("option-select", classSelectHandler);
			classCombo.on("option-deselect", classDeselectHandler);
			applyFilterButton.on("click", applyFilterClickHandler);
			resetFilterButton.on("click", resetFilterClickHandler);
		}

		function removeEvents() {
			tag.refs["minimize-button"].off("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.removeEventListener("click", minimizeClickHandler);
			periodCombo.off("option-select", periodSelectHandler);
			periodCombo.off("option-deselect", periodDeselectHandler);
			programCombo.off("option-select", programSelectHandler);
			programCombo.off("option-deselect", programDeselectHandler);
			courseCombo.off("option-select", courseSelectHandler);
			courseCombo.off("option-deselect", courseDeselectHandler);
			classCombo.off("option-select", classSelectHandler);
			classCombo.off("option-deselect", classDeselectHandler);
			applyFilterButton.off("click", applyFilterClickHandler);
			resetFilterButton.off("click", resetFilterClickHandler);
		}

		tag.currentPeriodText = function() {
			return tag.currentPeriods === "" ? guf.i18n.get("app.all_periods") : tag.currentPeriods;
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

		tag.on("after-mount", function() {
			initView();
			initEvents();
			app.ajax.get("api/pendingclassrecords/filters/currentContext", {
			}, function(response, xhr) {
				var data = response.data;
				if (data != null) {
					selectedPeriods = data.periods ? data.periods : [];
					selectedPrograms = data.programs ? data.programs : [];
					selectedCourses = data.courses ? data.courses : [];
					selectedClasses = data.classes ? data.classes : [];
					if (data.applied) {
						applyWhenLoaded = true;
					}
					if (data.adminTeacher === false) {
						userCantPerformClassRecords();
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
</sam-pending-class-records-filter>