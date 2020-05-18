(function() {
	var serverLimitsMonitoring = [];// array of students

	// EVENTS


	// METHODS

	function init() {
		serverLimitsMonitoring = [];
	}

	function release() {
		serverLimitsMonitoring = [];
	}

	function loadLimitsMonitoring() {
		return new Promise(function(resolve, reject) {
			app.ajax.get("api/absencesdetail", {
			}, function(response, xhr) {
				serverLimitsMonitoring = guf.utils.cloneObject(response.data);
				resolve(serverLimitsMonitoring);
			}, function(response, xhr) {
				guf.console.error("Error getting limits monitoring", response);
				reject();
			});
		});
	}

	function loadForStudent() {
		return new Promise(function (resolve, reject) {
			app.ajax.get("api/absencesdetail/student", {
			}, function (response, xhr) {
				serverLimitsMonitoring = guf.utils.cloneObject(response.data);
				resolve(serverLimitsMonitoring);
			}, function (response, xhr) {
				guf.console.error("Error getting limits monitoring for student", response);
				reject();
			});
		});
	}

	function loadBySemesterYearStudentId(semester, studentId, year) {
		var params = {
			semester: semester,
			studentId: studentId,
			year: year
		}
		return new Promise(function (resolve, reject) {
			app.ajax.get("api/absencesdetail/studentDetails", params, 
			function (response, xhr) {
				serverLimitsMonitoring = guf.utils.cloneObject(response.data);
				resolve(serverLimitsMonitoring);
			}, function (response, xhr) {
				guf.console.error("Error getting limits monitoring for student details", response);
				reject();
			});
		});
	}

	function updateMeeting(notification, newScheduleDate, newRealDate, newComment, origin, studentData) {
		return new Promise(function(resolve, reject) {
			var params = {
				id: notification.id
			};
			if(newScheduleDate.length) {
				params["meetingScheduledDate"] = newScheduleDate;
			}
			if(newRealDate.length) {
				params["meetingRealDate"] = newRealDate;
			}
			if(newComment.length) {
				params["meetingComments"] = newComment;
			}
			app.ajax.put("api/absencesdetail/updateMeeting", params, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error updating meeting", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function updateAdjustments(studentId, newAdjustmentLate, newMaxAbsencesRetake, newMaxAbsencesContract, origin, studentData) {
		return new Promise(function(resolve, reject) {
			var params = {
				studentId: studentId
			};
			if(newAdjustmentLate.length) {
				params["adjustmentLate"] = newAdjustmentLate;
			}
			if(newMaxAbsencesRetake.length) {
				params["maxAbsencesRetake"] = newMaxAbsencesRetake;
			}
			if(newMaxAbsencesContract.length) {
				params["maxAbsencesContract"] = newMaxAbsencesContract;
			}
			var period = getYearAndSemesterFromPeriod(studentData.period);
			if (period.year != "" && period.semester != "") {
				params["year"] = period.year;
				params["semester"] = period.semester;
			}
			app.ajax.post("api/absencesdetail/updateAdjustments", params, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error updating adjustments", response);
				reject();
			});
		})
	}

	function getNotifications(studentId) {
		return new Promise(function(resolve, reject) {
			app.ajax.get("api/absencesdetail/notifications", {
				studentId: studentId
			}, function(response, xhr) {
				if(response.success) {
					resolve(response.data);
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error getting notifications", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function sendNotifications(notifications, origin, studentData) {
		return new Promise(function(resolve, reject) {
			app.ajax.post("api/absencesdetail/sendNotifications", notifications, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error sending notifications", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function sendRetake(studentId, origin, studentData) {
		var period = getYearAndSemesterFromPeriod(studentData.period);
		return new Promise(function(resolve, reject) {
			app.ajax.post("api/absencesdetail/sendRetake", {
				semester: period.semester,
				studentId: studentId,
				year: period.year
			}, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error sending retake", response);
				reject();
			});
		});
	}

	function sendLate(studentId, origin, studentData) {
		var period = getYearAndSemesterFromPeriod(studentData.period);
		return new Promise(function(resolve, reject) {
			app.ajax.post("api/absencesdetail/sendLate", {
				semester: period.semester,
				studentId: studentId,
				year: period.year
			}, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error sending late", response);
				reject();
			});
		});
	}

	function sendContract(studentId, origin, studentData) {
		var period = getYearAndSemesterFromPeriod(studentData.period);
		return new Promise(function(resolve, reject) {
			app.ajax.post("api/absencesdetail/sendContract", {
				semester: period.semester,
				studentId: studentId,
				year: period.year
			}, function(response, xhr) {
				if(response.success) {
					load(origin, studentData).then(function() {
						app.limitsMonitoring.trigger("updated");
						resolve(response.success);
					}).catch(function() {
						reject();
					});
				} else {
					resolve(false);
				}
			}, function(response, xhr) {
				guf.console.error("Error sending contract", response);
				reject();
			});
		});
	}


	// CACHE METHODS. No network involved

	function getStudent(studentId) {
		if (Array.isArray(serverLimitsMonitoring)) {
			for(var i=0; i<serverLimitsMonitoring.length; i++) {
				if(serverLimitsMonitoring[i].studentId == studentId) {
					return serverLimitsMonitoring[i];
				}
			}
		} else {
			if (serverLimitsMonitoring.studentId == studentId) {
				return serverLimitsMonitoring;
			}
		}
		return null;
	}

	// UTILS
	function getYearAndSemesterFromPeriod(period) {
		var split = [''];
		if (typeof period !== 'undefined') {
			split = period.split('.');
		}
		return (split[0] != '') ? 
		{year: split[0], semester: split[1]} : 
		{year:"", semester:""};
	}
	
	function load(origin, studentData) {
		switch (origin) {
			case app.STUDENT_DETAIL_ORIGIN.LIMITS_MONITORING:
				return loadLimitsMonitoring();			
			case app.STUDENT_DETAIL_ORIGIN.REPORTING:
				var period = getYearAndSemesterFromPeriod(studentData.period);
				return loadBySemesterYearStudentId(period.semester, studentData.studentId, period.year);
			case app.STUDENT_DETAIL_ORIGIN.STUDENT_LOGIN:
				return loadForStudent();
		}
	}


	// PUBLIC INTERFACE

	app.limitsMonitoring = {
		init: init,
		release: release,
		load: loadLimitsMonitoring,
		updateMeeting: updateMeeting,
		updateAdjustments: updateAdjustments,
		getNotifications: getNotifications,
		sendNotifications: sendNotifications,
		sendRetake: sendRetake,
		sendLate: sendLate,
		sendContract: sendContract,
		get: function() { return serverLimitsMonitoring; },
		getStudent: getStudent,
		loadForStudent: loadForStudent,
		loadBySemesterYearStudentId: loadBySemesterYearStudentId
	};
	riot.observable(app.limitsMonitoring);
})();