window.app = (function(){

	var MODULE = {
		NONE: "none",
		ROLL_CALL: "rollcall",
		CLASS_RECORDS: "classrecords",
		PENDING_CLASS_RECORDS: "pendingclassrecords",
		LIMITS_MONITORING: "absencesmonitoring",
		REPORTING: "reporting",
		IMPORT_FILES: "import_files",
		USERS_MAINTENANCE: "users_maintenance"
	};

	var AUTHORITY = {
		ROLL_CALL: "roll_call",
		CLASS_RECORDS: "class_record",
		PENDING_CLASS_RECORDS: "pending_class_record",
		LIMITS_MONITORING: "absences_detail",
		USERS_MANAGEMENT: "users_management",
		CHANGE_ABSENCE: "change_absence",
		FILE_UPLOAD: "file_upload",
		UPDATE_ADJUSTMENTS: "update_adjustments",
		SEND_NOTIFICATION: "send_notification",
		SEND_RETAKE: "send_retake",
		SEND_LATE: "send_late",
		GENERATE_CONTRACT: "generate_contract"
	};

	var ROLE = {
		LRM_ADMIN: "ROLE_lrm_admin",
		STUDENT: "ROLE_student"
	};

	var STUDENT_STATE = {
		DEFAULT: "default",
		SELECTED: "selected",
		ALREADY_USED: "already_used"
	};

	var ABSENCE_STATE = {
		NONE: "none",
		ABSENCE: "absence",
		LATE: "late"
	};

	var ROLL_CALL_LIST_SELECTOR = {
		FILTERED: "filtered",
		MARKED: "marked"
	};

	var TABLE = {
		TEACHER_COURSE_CLASS_STUDENT: "teacherCourseClassStudent",
		AUXILIAR_YEAR_SEMESTER_DATES: "auxiliarYearSemesterDates",
		TIME_PERIODS: "timePeriods",
		ABSENCES_LIMITS: "absencesLimits",
		EXCEPTIONS_ROLL_CALL: "exceptionsRollCall",
		STUDENTS_NOT_NOTIFIED: "studentsNotNotified"
	};

	var LIMITS_MONITORING_VIEW = {
		SCHOOL: "SCHOOL",
		PROGRAM: "PROGRAM",
		COURSE: "COURSE"
	};

	var LIMITS_MONITORING_EXCEED = {
		YES: "YES",
		NO: "NO",
		ALL: "ALL"
	};

	var EXCEED_WARNING = {
		LEVEL_1: "1",
		LEVEL_2: "2",
		LEVEL_3: "3",
		CONTRACT: "C"
	};

	var REPORTING_VIEW = {
		STUDENT: "Student",
		CLASS_COURSE: "Class/Course",
		DATE_WEEK: "Date/Week"
	};

	var STUDENT_DETAIL_ORIGIN = {
		LIMITS_MONITORING: "absencesMonitoring",
		REPORTING: "reporting",
		STUDENT_LOGIN: "studentLogin"
	};

	guf.dcss.overrideTheme({
		primary: '#BE9459',
		darktext: '#2E2925',
		accent: '#EC2127',
		lines: '#C7C8CA',
		background: '#F1F2F2',
		lighttext: '#636466',
		icon: '#939598',
		lightestbackground: '#FFF',
		disabled: 'rgba(0,0,0,0.26)'
	});
	guf.console.configure(guf.console.level.DEBUG, guf.console.level.INFO, false, guf.console.level.INFO, true);
	var _exitAppWarning = false;
	var _backTimeoutHandler = null;
	var _baseUrl = "";
	var _me = null;

	function hashChangeHandler(evt) {
		var oldUrl = evt.oldURL;
		var oldHash = "";
		if (oldUrl && oldUrl.indexOf("#") != -1) {
			oldHash = oldUrl.substring(oldUrl.indexOf("#") + 1);
		}
		if (guf.route.get() == "exit" && !_exitAppWarning) {
			guf.createDialog(guf.i18n.get('app.title'), guf.i18n.get('app.exit_app'), guf.i18n.get('guf.no'), guf.i18n.get('guf.yes'),
				function () {
					_exitAppWarning = false;
					guf.route.to(oldHash, undefined, false);
				},
				function () {
					_exitAppWarning = false;
/*					if (guf.device.isMobile) {
						navigator.app.exitApp();
					} else {*/
						window.addEventListener('unload', unloadHandler);
						var steps = window.history.length;
						var times = 0;
						_backTimeoutHandler = guf.setInterval(function(){
							if (times > steps) {
								guf.clearInterval(_backTimeoutHandler);
								try	{
									window.location.href = "about:home";
								} catch(e) {
									window.location.href = "about:blank";
								}
							} else {
								window.history.back();
								times++;
							}
						}, 200);
					//}
				}
			);
			_exitAppWarning = true;
		} else {
			switch (guf.route.getCollection()) {
				default:
					//FIXME
					break;
			}
		}
	}

	function unloadHandler() {
		guf.clearInterval(_backTimeoutHandler);
		window.removeEventListener('unload', unloadHandler);
	}

	function initHistoryEvents() {
		var currentRoute = guf.route.get();
		if (currentRoute != "exit") {
			guf.route.to("exit", undefined, true);
		}
		guf.route.to(currentRoute, undefined, false);
		window.addEventListener('hashchange', hashChangeHandler);
	}

	function removeHistoryEvents() {
		window.removeEventListener('hashchange', hashChangeHandler);
	}

	function hasAuthority(authority) {
		if (!_me) {
			return false;
		}
		for (var i = 0; i < _me.authorities.length; i++) {
			if (authority == _me.authorities[i].authority) {
				return true;
			}
		}
		return false;
	}

	function hasRole(role) {
		if (!_me) {
			return false;
		}
		for (var i = 0; i < _me.authorities.length; i++) {
			if (role == _me.authorities[i].authority) {
				return true;
			}
		}
		return false;
	}

	function highlightInString(string, value) {
		string += "";
		var startIndex = string.toLowerCase().indexOf(value.toLowerCase());
		if (startIndex != -1) {
			var endIndex = startIndex + value.length;
			return string.substring(0, startIndex) + "<span class=\"highlight\">" + string.substring(startIndex, endIndex) + "</span>" + string.substring(endIndex);
		}
		return string;
	}

	guf.on("ready", function() {
		riot.observable(app);
		guf.storage.setPrefix("sommet-");
		guf.storage.setStorage(guf.storage.LOCAL);
		app.ajax.setContentType("application/x-www-form-urlencoded");
		if (document.location.hostname == "localhost" && document.location.port == "8001") {
			app.ajax.setWithCredentials(true);
			app.setBaseUrl("https://absences-management.jx-sommet-develop.netd.io/");
			// app.setBaseUrl("http://localhost:8080/");
			//app.setBaseUrl("http://192.168.1.134:8080/");
		}
		if (guf.route.getCollection() == "exit") {
			guf.route.to("", undefined, true);
		}
		initHistoryEvents();
		if (guf.device.isIos) {
			var updateDocumentHeight = function () {
				guf.setTimeout(function() {
					var vpH = window.innerHeight;
					document.documentElement.style.height = vpH.toString() + "px";
					document.body.style.height = vpH.toString() + "px";
				}, 100);
			}
			guf.on("orientation-change", updateDocumentHeight);
			var vpH = window.innerHeight;
			document.documentElement.style.height = vpH.toString() + "px";
			document.body.style.height = vpH.toString() + "px";
			//TODO: Check https://www.bram.us/2016/05/02/prevent-overscroll-bounce-in-ios-mobilesafari-pure-css/
			/*var freezeVp = function(e) {
				e.preventDefault();
			};
			document.body.addEventListener("touchmove", freezeVp, false);*/
		}
	});

	return {
		MODULE: MODULE,
		AUTHORITY: AUTHORITY,
		ROLE: ROLE,
		STUDENT_STATE: STUDENT_STATE,
		ABSENCE_STATE: ABSENCE_STATE,
		ROLL_CALL_LIST_SELECTOR: ROLL_CALL_LIST_SELECTOR,
		TABLE: TABLE,
		LIMITS_MONITORING_VIEW: LIMITS_MONITORING_VIEW,
		LIMITS_MONITORING_EXCEED: LIMITS_MONITORING_EXCEED,
		EXCEED_WARNING: EXCEED_WARNING,
		REPORTING_VIEW: REPORTING_VIEW,
		STUDENT_DETAIL_ORIGIN: STUDENT_DETAIL_ORIGIN,
		getBaseUrl: function() { return _baseUrl; },
		setBaseUrl: function(baseUrl) { _baseUrl = baseUrl; },
		setMe: function(me) { _me = me; },
		clearMe: function() { _me = null; },
		getMe: function() { return _me; },
		capitalizeFirstLetter : function(string) { return string.charAt(0).toUpperCase() + string.slice(1);},
		hasAuthority: hasAuthority,
		hasRole: hasRole,
		SNACKBAR_DEFAULT_TIMEOUT: 3000,
		highlightInString: highlightInString
	};
})();