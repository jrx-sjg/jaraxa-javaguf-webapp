(function() {
	var serverRollCall = [];// array of classrooms
	var markedRollCall = null;// array of classrooms

	// EVENTS


	// METHODS

	function init() {
		serverRollCall = [];
		initMarked();
	}

	function release() {
		serverRollCall = [];
		releaseMarked();
	}

	function load() {
		return new Promise(function(resolve, reject) {
			app.ajax.get("api/rollcall", {
			}, function(response, xhr) {
				guf.console.log("rollcall results", response.data);
				serverRollCall = guf.utils.cloneObject(response.data);
				addLocalInfoRollCallToData(serverRollCall);
				guf.console.log("rollcall processed", serverRollCall);
				resolve(serverRollCall);
			}, function(response, xhr) {
				guf.console.error("Error getting roll call", response);
				reject();
			});
		});
	}

	function initMarked() {
		markedRollCall = null;
	}

	function releaseMarked() {
		markedRollCall = null;
	}

	function saveAbsences(classData, studentsData, absencesData, comment) {
		var savedAbsences = createSavedAbsencesFromData(absencesData);
		return new Promise(function(resolve, reject) {
			app.ajax.put("api/rollcall/save", getServerAbsencesFromData(classData, studentsData, savedAbsences, comment)
			, function(response, xhr) {
				for(var i=0; i<studentsData.length; i++) {
					var serverAbsences = createServerAbsencesFromLocalAbsences(savedAbsences);
					studentsData[i].localAbsences = savedAbsences;
					studentsData[i].absences = serverAbsences;
					if(comment != null) {
						studentsData[i].comment = comment;
					}
					var student = getStudent(classData.className, studentsData[i].id);
					if(student) {
						student.localAbsences = savedAbsences;
						student.absences = serverAbsences;
						if(comment != null) {
							student.comment = comment;
						}
					}
					updateMarkedRollCallAfterSavingAbsences(classData.className, studentsData[i].id, savedAbsences, serverAbsences);
				}
				resolve();
			}, function(response, xhr) {
				guf.console.error("Error saving rollcall", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function deleteAbsences(classData, studentData, absencesData) {
		var deletedAbsences = createDeletedAbsencesFromData(absencesData);
		return new Promise(function(resolve, reject) {
			app.ajax.put("api/rollcall/save", getServerAbsencesFromData(classData, [studentData], deletedAbsences, null)
			, function(response, xhr) {
				var serverAbsences = createServerAbsencesFromLocalAbsences(deletedAbsences);
				studentData.localAbsences = deletedAbsences;
				studentData.absences = serverAbsences;
				var student = getStudent(classData.className, studentData.id);
				if(student) {
					student.localAbsences = deletedAbsences;
					student.absences = serverAbsences;
				}
				updateMarkedRollCallAfterSavingAbsences(classData.className, studentData.id, deletedAbsences, serverAbsences);
				resolve();
			}, function(response, xhr) {
				guf.console.error("Error deleting absence", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function submitAbsences(classData, studentData, absencesData) {
		var submittedAbsences = createSubmittedAbsencesFromData(classData, studentData, absencesData);
		return new Promise(function(resolve, reject) {
			app.ajax.put("api/rollcall/save", getServerAbsencesFromData(classData, [studentData], submittedAbsences, null)
			, function(response, xhr) {
				var serverAbsences = createServerAbsencesFromLocalAbsences(submittedAbsences);
				studentData.localAbsences = submittedAbsences;
				studentData.absences = serverAbsences;
				var student = getStudent(classData.className, studentData.id);
				if(student) {
					student.localAbsences = submittedAbsences;
					student.absences = serverAbsences;
				}
				updateMarkedRollCallAfterSavingAbsences(classData.className, studentData.id, submittedAbsences, serverAbsences);
				resolve();
			}, function(response, xhr) {
				guf.console.error("Error submitting rollcall", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function saveAllAbsences(rollCallData) {
		var students = [];
		var serverData = [];
		for(var classIndex=0; classIndex<rollCallData.length; classIndex++) {
			var classData = rollCallData[classIndex];
			for(var studentIndex=0; studentIndex<classData.students.length; studentIndex++) {
				var studentData = classData.students[studentIndex];
				var savedAbsences = createSavedAbsencesFromData(studentData.markedAbsences);
				var serverAbsences = getServerAbsencesFromData(classData, [studentData], savedAbsences, null)[0];
				serverData.push(serverAbsences);
				students.push({
					className: classData.className,
					studentId: studentData.id,
					newAbsences: savedAbsences
				});
			}	
		}
		return new Promise(function(resolve, reject) {
			app.ajax.put("api/rollcall/save", serverData
			, function(response, xhr) {
				for(var i=0; i<students.length; i++) {
					var serverAbsences = createServerAbsencesFromLocalAbsences(students[i].newAbsences);
					var student = getStudent(students[i].className, students[i].studentId);
					if(student) {
						student.localAbsences = students[i].newAbsences;
						student.absences = serverAbsences;
					}
					updateMarkedRollCallAfterSavingAbsences(students[i].className, students[i].studentId, students[i].newAbsences, serverAbsences);
				}
				resolve();
			}, function(response, xhr) {
				guf.console.error("Error saving all rollcall", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}

	function submitAllAbsences(rollCallData) {
		var students = [];
		var serverData = [];
		for(var classIndex=0; classIndex<rollCallData.length; classIndex++) {
			var classData = rollCallData[classIndex];
			for(var studentIndex=0; studentIndex<classData.students.length; studentIndex++) {
				var studentData = classData.students[studentIndex];
				var submittedAbsences = createSubmittedAbsencesFromData(classData, studentData, studentData.markedAbsences);
				var serverAbsences = getServerAbsencesFromData(classData, [studentData], submittedAbsences, null)[0];
				serverData.push(serverAbsences);
				students.push({
					className: classData.className,
					studentId: studentData.id,
					newAbsences: submittedAbsences
				});
			}	
		}
		return new Promise(function(resolve, reject) {
			app.ajax.put("api/rollcall/save", serverData
			, function(response, xhr) {
				for(var i=0; i<students.length; i++) {
					var serverAbsences = createServerAbsencesFromLocalAbsences(students[i].newAbsences);
					var student = getStudent(students[i].className, students[i].studentId);
					if(student) {
						student.localAbsences = students[i].newAbsences;
						student.absences = serverAbsences;
					}
					updateMarkedRollCallAfterSavingAbsences(students[i].className, students[i].studentId, students[i].newAbsences, serverAbsences);
				}
				resolve();
			}, function(response, xhr) {
				guf.console.error("Error submitting all rollcall", response);
				reject();
			}, {
				"Content-Type": "application/json"
			});
		});
	}


	// CACHE METHODS. No network involved

	function getLocalStudentState(student) {
		for(var i=0; i<student.localAbsences.length; i++) {
			if(student.localAbsences[i].state !== app.ABSENCE_STATE.NONE) {
				return app.STUDENT_STATE.ALREADY_USED;
			}
		}
		return app.STUDENT_STATE.DEFAULT;
	}

	function getLocalAbsences(student) {
		return guf.utils.cloneObject(student.localAbsences);
	}

	function getServerAbsences(student) {
		return createAbsencesData(student.localAbsences, [student]);
	}

	function getMarked() {
		if(markedRollCall) {
			return markedRollCall;
		}
		var resultMarked = guf.utils.cloneObject(serverRollCall);
		for(var classIndex=0; classIndex<resultMarked.length; classIndex++) {
			var classData = resultMarked[classIndex];
			var students = classData.students.filter(function(student) {
				return getLocalStudentState(student) == app.STUDENT_STATE.ALREADY_USED;
			});
			resultMarked[classIndex].students = students;
		}
		markedRollCall = resultMarked.filter(function(classRoom) {
			return classRoom.students.length > 0;
		});
		return markedRollCall;
	}

	function canDeleteAbsences(currentAbsencesList, newAbsencesList) {
		for(var i=0; i<newAbsencesList.length; i++) {
			if(newAbsencesList[i].state != app.ABSENCE_STATE.NONE && !newAbsencesList[i].submitted && newAbsencesList[i].canModify) {
				return true;
			}
		}
		return false;
	}

	function canSaveAbsences(currentAbsencesList, newAbsencesList) {
		var result = false;
		for(var i=0; i<newAbsencesList.length; i++) {
			var absence = newAbsencesList[i];
			for(var j=0; j<currentAbsencesList.length; j++) {
				if(currentAbsencesList[j].startingHour == absence.startingHour && currentAbsencesList[j].endingHour == absence.endingHour) {
					if(currentAbsencesList[j].state != absence.state && !absence.submitted && absence.canModify) {
						return true;
					}
				}
			}
		}
		return false;
	}

	function canSubmitAbsences(currentAbsencesList, newAbsencesList) {
		for(var i=0; i<newAbsencesList.length; i++) {
			var absence = newAbsencesList[i];
			for(var j=0; j<currentAbsencesList.length; j++) {
				if(currentAbsencesList[j].startingHour == absence.startingHour && currentAbsencesList[j].endingHour == absence.endingHour) {
					if(currentAbsencesList[j].state != absence.state && absence.submitted && absence.canModifySubmitted) {
						return true;
					} else if(absence.state != app.ABSENCE_STATE.NONE && !absence.submitted && absence.canModify) {
						return true;
					} else if(absence.state == app.ABSENCE_STATE.NONE && absence.submitted && absence.canModifySubmitted) {
						return true;
					}
				}
			}
		}
		return false;
	}

	function canSaveAllAbsences(classRooms) {
		for(var classIndex=0; classIndex<classRooms.length; classIndex++) {
			var students = classRooms[classIndex].students;
			for(var studentIndex=0; studentIndex<students.length; studentIndex++) {
				var student = students[studentIndex];
				if(canSaveAbsences(getServerAbsences(student), student.markedAbsences)) {
					return true;
				}
			}
 		}
 		return false;
	}


	function canSubmitAllAbsences(classRooms) {
		for(var classIndex=0; classIndex<classRooms.length; classIndex++) {
			var students = classRooms[classIndex].students;
			for(var studentIndex=0; studentIndex<students.length; studentIndex++) {
				var student = students[studentIndex];
				if(canSubmitAbsences(student.localAbsences, student.markedAbsences)) {
					return true;
				}
			}
 		}
 		return false;
	}

	// UTILS

	function addLocalInfoRollCallToData(data) {
		for(var classIndex=0; classIndex<data.length; classIndex++) {
			var classData = data[classIndex];
			for(var studentIndex=0; studentIndex<classData.students.length; studentIndex++) {
				var localAbsences = createAbsencesData(classData.timePeriods, [classData.students[studentIndex]]);
				classData.students[studentIndex].localAbsences = localAbsences;
			}	
		}
	}

	function createServerAbsencesFromLocalAbsences(absences) {
		var result = [];
		for(var i=0; i<absences.length; i++) {
			var type = getAbsenceTypeFromState(absences[i].state);
			if(type != null) {
				var period = {
					startingHour: absences[i].startingHour,
					endingHour: absences[i].endingHour,
					type: type,
					submitted: absences[i].submitted
				};
				result.push(period);
			}
		}
		return result;
	}

	function createAbsencesData(timePeriods, students) {
		var result = [];
		for(var i=0; i<timePeriods.length; i++) {
			var period = {
				startingHour: timePeriods[i].startingHour,
				endingHour: timePeriods[i].endingHour,
				state: getAbsenceStateFromStudents(students, timePeriods[i]),
				submitted: getSubmittedFromStudents(students, timePeriods[i]),
				canModify: students[0].canModify,
				canModifySubmitted: students[0].canModifySubmitted,
				blockedByExceptionRollCall: students[0].blockedByExceptionRollCall
			};
			result.push(period);
		}
		return result;
	}

	function getAbsenceTypeFromState(state) {
		switch(state) {
			case app.ABSENCE_STATE.ABSENCE:
				return "A";
			case app.ABSENCE_STATE.LATE:
				return "L";
		}
		return null;
	}

	function getAbsenceStateFromStudents(students, period) {
		if(students.length === 1) {
			var absences = students[0].absences;
			for(var i=0; i<absences.length; i++) {
				if(absences[i].startingHour === period.startingHour && absences[i].endingHour === period.endingHour) {
					switch(absences[i].type) {
						case "A":
							return app.ABSENCE_STATE.ABSENCE;
						case "L":
							return app.ABSENCE_STATE.LATE;
					}
				}
			}
		}
		return app.ABSENCE_STATE.NONE;
	}

	function getSubmittedFromStudents(students, period) {
		if(students.length === 1) {
			var absences = students[0].absences;
			for(var i=0; i<absences.length; i++) {
				if(absences[i].startingHour === period.startingHour && absences[i].endingHour === period.endingHour) {
					return absences[i].submitted;
				}
			}
		}
		return false;
	}

	function getServerAbsenceFromState(state) {
		switch(state) {
			case app.ABSENCE_STATE.ABSENCE:
				return "A";
			case app.ABSENCE_STATE.LATE:
				return "L";
		}
		return null;
	}

	function getServerAbsencesFromData(classData, studentsData, absencesData, comment) {
		var result = [];
		for(var i=0; i<studentsData.length; i++) {
			var studentInfo = {
				className: classData.className,
				studentId: studentsData[i].id
			};
			if(comment != null) {
				studentInfo.comment = comment;
			} else {
				studentInfo.comment = studentsData[i].comment;
			}
			var absences = [];
			for(var j=0; j<absencesData.length; j++) {
				var absence = {
					startTime: absencesData[j].startingHour,
					endTime: absencesData[j].endingHour,
					absence: getServerAbsenceFromState(absencesData[j].state),
					submit: absencesData[j].submitted
				};
				absences.push(absence);
			}
			studentInfo.absences = absences;
			result.push(studentInfo);
		}
		return result;
	}

	function createSavedAbsencesFromData(absencesData) {
		for(var i=0; i<absencesData.length; i++) {
			if(absencesData[i].state === app.ABSENCE_STATE.NONE) {
				absencesData[i].submitted = false;
			}
		}
		return absencesData;
	}

	function createDeletedAbsencesFromData(absencesData) {
		for(var i=0; i<absencesData.length; i++) {
			if(absencesData[i].state !== app.ABSENCE_STATE.NONE && !absencesData[i].submitted) {
				absencesData[i].state = app.ABSENCE_STATE.NONE;
			}
		}
		return absencesData;
	}

	function createSubmittedAbsencesFromData(classData, studentData, absencesData) {
		for(var i=0; i<absencesData.length; i++) {
			if(absencesData[i].state === app.ABSENCE_STATE.NONE) {
				absencesData[i].submitted = false;
			} else {
				absencesData[i].submitted = true;
			}
		}
		return absencesData;
	}

	function getStudent(className, studentId) {
		var classData = null;
		var student = null;
		for(var classIndex=0; classIndex<serverRollCall.length; classIndex++) {
			if(serverRollCall[classIndex].className === className) {
				classData = serverRollCall[classIndex];
				break;
			}
		}
		if(classData) {
			for(var studentIndex=0; studentIndex<classData.students.length; studentIndex++) {
				if(classData.students[studentIndex].id === studentId) {
					student = classData.students[studentIndex];
					break;
				}
			}
		}
		return student;
	}

	function updateMarkedRollCallAfterSavingAbsences(className, studentId, absences, serverAbsences) {
		if(markedRollCall) {
			var classData = null;
			var student = null;
			var classIndex = -1;
			var studentIndex = -1;
			for(var index=0; index<markedRollCall.length; index++) {
				if(markedRollCall[index].className === className) {
					classIndex = index;
					classData = markedRollCall[index];
					break;
				}
			}
			if(classData) {
				for(var index=0; index<classData.students.length; index++) {
					if(classData.students[index].id === studentId) {
						studentIndex = index;
						student = classData.students[index];
						student.localAbsences = absences;
						student.absences = serverAbsences;
						break;
					}
				}
				if(student) {
					var state = getLocalStudentState(student);
					if(state != app.STUDENT_STATE.ALREADY_USED) {
						// Student won't be shown in marked roll call
						classData.students.splice(studentIndex, 1);
						if(classData.students.length <= 0) {
							// Classroom won't be shown in marked roll call
							markedRollCall.splice(classIndex, 1);
						}
					}
				}
			}
		}
	}

	// PUBLIC INTERFACE

	app.rollCall = {
		init: init,
		release: release,
		load: load,
		initMarked: initMarked,
		releaseMarked: releaseMarked,
		saveAbsences: saveAbsences,
		deleteAbsences: deleteAbsences,
		submitAbsences: submitAbsences,
		saveAllAbsences: saveAllAbsences,
		submitAllAbsences: submitAllAbsences,
		get: function() { return serverRollCall; },
		getStudentState: getLocalStudentState,
		getAbsences: getLocalAbsences,
		getServerAbsences: getServerAbsences,
		getMarked: getMarked,
		canDeleteAbsences: canDeleteAbsences,
		canSaveAbsences: canSaveAbsences,
		canSubmitAbsences: canSubmitAbsences,
		canSaveAllAbsences: canSaveAllAbsences,
		canSubmitAllAbsences: canSubmitAllAbsences
	};
	riot.observable(app.rollCall);
})();