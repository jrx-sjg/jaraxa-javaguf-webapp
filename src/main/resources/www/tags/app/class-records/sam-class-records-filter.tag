<sam-class-records-filter>
	<div ref="container" class="container">
		<guf-linear-layout ref="container-maximized" class="container-maximized" orientation="vertical">
			<guf-linear-layout ref="filter-title" orientation="horizontal" v-align="center">
				<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			</guf-linear-layout>
			<guf-linear-layout ref="filter-combos" orientation="horizontal" v-align="center">
				<guf-combo-box ref="period-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.period')} *"></guf-combo-box>
				<guf-combo-box ref="program-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" item-tag="sam-multiline-combo-box-item" placeholder="{guf.i18n.get('app.program')} *"></guf-combo-box>
				<guf-combo-box ref="course-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.course')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="class-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.class')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
				<guf-combo-box ref="week-combo" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.week')} *" item-tag="sam-multiline-combo-box-item"></guf-combo-box>
			</guf-linear-layout>
			<guf-linear-layout ref="actions" class="actions" orientation="horizontal" h-align="right">
				<guf-button ref="reset-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled">{guf.i18n.get('app.reset_filter')}</guf-button>
				<guf-button ref="apply-filter" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled" disabled="true">{guf.i18n.get('app.apply_filter')}</guf-button>
			</guf-linear-layout>
			<div ref="overlay" class="overlay hidden"></div>
		</guf-linear-layout>
		<guf-linear-layout ref="container-minimized" class="container-minimized" orientation="horizontal" v-align="center">
			<i class="material-icons">filter_list</i><div>{guf.i18n.get('app.filters').toUpperCase()}</div>
			<div class="spacer"></div>
			<div class="filter-title">{guf.i18n.get('app.period')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-class-records-filter').currentPeriod}</div>
			<div class="filter-title">{guf.i18n.get('app.program')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-class-records-filter').currentProgram}</div>
			<div class="filter-title">{guf.i18n.get('app.course')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-class-records-filter').currentCourse}</div>
			<div class="filter-title">{guf.i18n.get('app.class')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-class-records-filter').currentClass}</div>
			<div class="filter-title">{guf.i18n.get('app.week')} *</div>
			<div class="filter-value">{guf.ancestor(this,'sam-class-records-filter').currentWeek}</div>
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
		:scope > .container > .container-maximized > guf-linear-layout[ref="filter-combos"] > guf-combo-box[ref="week-combo"] {
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

		var COMBO = {
			PERIOD: "period",
			PROGRAM: "program",
			COURSE: "course",
			CLASS: "class",
			WEEK: "week"
		};

		var filterMinimized = false;
		var periodCombo, programCombo, courseCombo, classCombo, weekCombo;
		var applyFilterButton, resetFilterButton;
		var applyWhenLoaded;

		tag.currentPeriod = "";
		tag.currentProgram = "";
		tag.currentCourse = "";
		tag.currentClass = "";
		tag.currentWeek = "";

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
			var applyButtonEnabled = tag.currentPeriod.length > 0 && tag.currentProgram.length > 0 && tag.currentCourse.length > 0 && tag.currentClass.length > 0 && tag.currentWeek.length > 0;
			applyButtonEnabled ? applyFilterButton.enable() : applyFilterButton.disable();
			resetFilterButton.enable();
			tag.refs["container-maximized"].update();
		}

		function updateCombos() {
			periodCombo.setText(tag.currentPeriod);
			programCombo.setText(tag.currentProgram);
			courseCombo.setText(tag.currentCourse);
			classCombo.setText(tag.currentClass);
			weekCombo.setText(tag.currentWeek);
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

		function classComboClickHandler(item, itemTag) {
			tag.currentClass = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveClassFilter();
		}

		function weekComboClickHandler(item, itemTag) {
			tag.currentWeek = item;
			updateCombos();
			tag.refs["container-minimized"].update();
			saveWeekFilter();
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
			app.ajax.post("api/classrecords/filters/reset", {
			}, function(response, xhr) {
				var data = response.data;
				tag.currentPeriod = "";
				tag.currentProgram = "";
				tag.currentCourse = "";
				tag.currentClass = "";
				tag.currentWeek = "";
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentProgram = data.program ? data.program : "";
					tag.currentCourse = data.course ? data.course : "";
					tag.currentClass = data.className ? data.className : "";
					tag.currentWeek = data.week !== null ? "" + data.week : "";
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
						case COMBO.CLASS:
							if(!tag.currentClass) {
								tag.currentClass = data.options[0];
								classCombo.setText(tag.currentClass);
								promises.push(saveClassFilter(true));
							}
							break;
						case COMBO.WEEK:
							if(!tag.currentWeek) {
								tag.currentWeek = data.options[0];
								weekCombo.setText(tag.currentWeek);
								promises.push(saveWeekFilter(true));
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
			if(aCombo != weekCombo) {
				promises.push(initWeekCombo());
			}
			Promise.all(promises).then(function(combos) {
				Promise.all(autoSelectUnitaryCombos(combos)).then(function(result) {
					if(aCombo == periodCombo) {
						return initPeriodCombo();
					}
					if(aCombo == programCombo) {
						return initProgramCombo();
					}
					if(aCombo == courseCombo) {
						return initCourseCombo();
					}
					if(aCombo == classCombo) {
						return initClassCombo();
					}
					if(aCombo == weekCombo) {
						return initWeekCombo();
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
				app.ajax.get("api/classrecords/filters/periods", {
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
				app.ajax.get("api/classrecords/filters/programs", {
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
				app.ajax.get("api/classrecords/filters/courses", {
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
				app.ajax.get("api/classrecords/filters/classes", {
				}, function(response, xhr) {
					classCombo.setOptions(response.data);
					if (tag.currentClass) {
						classCombo.setText(tag.currentClass);
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

		function initWeekCombo() {
			return new Promise(function(resolve, reject) {
				app.ajax.get("api/classrecords/filters/weeks", {
				}, function(response, xhr) {
					var weeks = [];
					for(var i=0; i<response.data.length; i++) {
						weeks[i] = "" + response.data[i];
					}
					weekCombo.setOptions(weeks);
					if (tag.currentWeek) {
						weekCombo.setText(tag.currentWeek);
					}
					resolve({
						success: true,
						combo: COMBO.WEEK,
						options: response.data
					});
				}, function(response, xhr) {
					guf.console.error("Error getting classes", response);
					resolve({
						success: false,
						combo: COMBO.WEEK
					});
				});
			});
		}

		// Combos save

		function savePeriodFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/classrecords/filters/period", {
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
				app.ajax.put("api/classrecords/filters/program", {
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
					guf.console.error("Error saving program", response);
					resolve(false);
				});
			});
		}

		function saveCourseFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/classrecords/filters/course", {
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

		function saveClassFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/classrecords/filters/class", {
					className: tag.currentClass
				}, function(response, xhr) {
					guf.console.log("save class success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(classCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving classes", response);
					resolve(false);
				});
			});
		}

		function saveWeekFilter(noCascade) {
			return new Promise(function(resolve, reject) {
				app.ajax.put("api/classrecords/filters/week", {
					week: tag.currentWeek
				}, function(response, xhr) {
					guf.console.log("save week success", response);
					updateFilterStatus();
					if(!noCascade) {
						initCombosMinus(weekCombo);
						resetSearch();
					}
					resolve(true);
				}, function(response, xhr) {
					guf.console.error("Error saving week", response);
					resolve(false);
				});
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
			weekCombo = tag.refs["container-maximized"].refs["filter-combos"].refs["week-combo"];
			applyFilterButton = tag.refs["container-maximized"].refs["actions"].refs["apply-filter"];
			resetFilterButton = tag.refs["container-maximized"].refs["actions"].refs["reset-filter"];
		}

		function initEvents() {
			tag.refs["minimize-button"].on("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.addEventListener("click", minimizeClickHandler);
			periodCombo.on("menu-click", periodComboClickHandler);
			programCombo.on("menu-click", programComboClickHandler);
			courseCombo.on("menu-click", courseComboClickHandler);
			classCombo.on("menu-click", classComboClickHandler);
			weekCombo.on("menu-click", weekComboClickHandler);
			applyFilterButton.on("click", applyFilterClickHandler);
			resetFilterButton.on("click", resetFilterClickHandler);
		}

		function removeEvents() {
			tag.refs["minimize-button"].off("click", minimizeClickHandler);
			tag.refs["container-minimized"].root.removeEventListener("click", minimizeClickHandler);
			periodCombo.off("menu-click", periodComboClickHandler);
			programCombo.off("menu-click", programComboClickHandler);
			courseCombo.off("menu-click", courseComboClickHandler);
			classCombo.off("menu-click", classComboClickHandler);
			weekCombo.off("menu-click", weekComboClickHandler);
			applyFilterButton.off("click", applyFilterClickHandler);
			resetFilterButton.off("click", resetFilterClickHandler);
		}

		tag.on("after-mount", function() {
			initView();
			initEvents();
			app.ajax.get("api/classrecords/filters/currentContext", {
			}, function(response, xhr) {
				var data = response.data;
				if (data != null) {
					tag.currentPeriod = data.period ? data.period : "";
					tag.currentProgram = data.program ? data.program : "";
					tag.currentCourse = data.course ? data.course : "";
					tag.currentClass = data.className ? data.className : "";
					tag.currentWeek = data.week !== null ? "" + data.week : "";
					if (data.applied) {
						applyWhenLoaded = true;
					}
					if (data.adminTeacher === false) {
						userCantPerformClassRecords();
						applyFilterButton.disable();
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
</sam-class-records-filter>