<sam-limits-monitoring-details>
	<div class="container flex1">
		<div class="scrollable-content">
			<guf-linear-layout if="{guf.ancestor(this, 'sam-limits-monitoring-details').showActions}" ref="actions" orientation="horizontal" class="actions">
				<guf-button ref="back-button" type="flat" color="true" icon="arrow_back" icon-outlined="true" dcss-border="1px solid @lines">{guf.i18n.get('guf.back')}</guf-button>
				<div class="flex1"></div>
				<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-details').showUpdateAdjustments}" ref="update-adjustments" id="limits-monitoring-update-adjustments" type="icon" icon="edit" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
				<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').showUpdateAdjustments}" class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-update-adjustments">{guf.i18n.get('app.update_adjustments')}</div>
				<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendNotifications}" ref="send-notification" id="limits-monitoring-send-notification" type="icon" icon="mail" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
				<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendNotifications}" class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-send-notification">{guf.i18n.get('app.send_notifications')}</div>
				<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendRetake}" ref="send-retake" id="limits-monitoring-send-retake" type="icon" icon="refresh" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
				<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendRetake}" class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-send-retake">{guf.i18n.get('app.send_retake')}</div>
				<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendLate}" ref="send-late" id="limits-monitoring-send-late" type="icon" icon="schedule" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
				<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendLate}" class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-send-late">{guf.i18n.get('app.send_late')}</div>
				<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendContract}" ref="send-contract" id="limits-monitoring-send-contract" type="icon" icon="insert_drive_file" icon-outlined="true" dcss-text-color="@primary" dcss-text-color-disabled="@lines"></guf-button>
				<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').showSendContract}" class="mdl-tooltip mdl-tooltip--large" for="limits-monitoring-send-contract">{guf.i18n.get('app.send_contract')}</div>
			</guf-linear-layout>
			<div class="{student-container:1, no-actions:!guf.ancestor(this, 'sam-limits-monitoring-details').showActions}">
				<sam-limits-monitoring-student-details class="flex1" student="{guf.ancestor(this, 'sam-limits-monitoring-details').student}">
				</sam-limits-monitoring-student-details>
				<sam-limits-monitoring-notification-list if="{guf.ancestor(this, 'sam-limits-monitoring-details').showNotificationHistory}" class="flex1" notifications="{guf.ancestor(this, 'sam-limits-monitoring-details').sectionNotificationHistory}">
				</sam-limits-monitoring-notification-list>
				<sam-empty if="{!guf.ancestor(this, 'sam-limits-monitoring-details').showNotificationHistory}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.notification_history_empty_text')}"></sam-empty>
			</div>
			<sam-limits-monitoring-absences-detail if="{guf.ancestor(this, 'sam-limits-monitoring-details').showAbsences}" each={item in guf.ancestor(this, 'sam-limits-monitoring-details').sectionAbsencesDetails} view="{guf.ancestor(this, 'sam-limits-monitoring-details').selectedView}"></sam-limits-monitoring-absences-detail>
			<sam-empty if="{!guf.ancestor(this, 'sam-limits-monitoring-details').showAbsences}" class="flex1" icon="filter_list" text="{guf.i18n.get('app.limits_monitoring_student_no_absences')}"></sam-empty>
			<div if="{guf.ancestor(this, 'sam-limits-monitoring-details').selectedView === app.LIMITS_MONITORING_VIEW.SCHOOL}" class="section">
				<guf-linear-layout orientation="vertical" class="resume-container">
					<guf-linear-layout orientation="horizontal" v-align="center" class="resume-row">
						<div class="item-title">{guf.i18n.get('app.total_absences_semester')}:</div>
						<div class="item-value">{guf.ancestor(this, 'sam-limits-monitoring-details').schoolTotalAbsences}</div>
					</guf-linear-layout>
					<guf-linear-layout orientation="horizontal" v-align="center" class="resume-row">
						<div class="item-title">{guf.i18n.get('app.total_absences_left')}:</div>
						<div class="item-value">{guf.ancestor(this, 'sam-limits-monitoring-details').student.absencesLeft}</div>
					</guf-linear-layout>
				</guf-linear-layout>
			</div>
		</div>
	</div>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			background-color: @lightestbackground;
			overflow: auto;
		}
		:scope > .container {
			min-width: 1100px;
			padding: 0px 26px;
		}
		:scope > .container > .scrollable-content > *:last-child {
			margin-bottom: 20px;
		}
		body.guf-rendering-engine-webkit :scope > .container > .scrollable-content > *:last-child,
		body.guf-rendering-engine-gecko :scope > .container > .scrollable-content > *:last-child,
		body.guf-rendering-engine-msedge :scope > .container > .scrollable-content > *:last-child,
		body.guf-rendering-engine-msie :scope > .container > .scrollable-content > *:last-child {
			margin-bottom: 0px;
			padding-bottom: 20px;
		}
		:scope > .container > .scrollable-content > .actions {
			padding: 10px 0px 16px;
			position: -webkit-sticky;
			position: sticky;
			top: 0px;
			background: @lightestbackground;
			z-index: 1;
		}
		:scope > .container > .scrollable-content > .student-container {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			-ms-flex-align: start;
			-webkit-box-align: start;
			-webkit-align-items: flex-start;
			align-items: flex-start;
			margin-bottom: 16px;
		}
		:scope > .container > .scrollable-content > .student-container.no-actions {
			margin-top: 16px;
		}
		:scope > .container > .scrollable-content > .student-container > sam-limits-monitoring-student-details {
			margin-right: 50px;
		}
		:scope > .container > .scrollable-content > .student-container > sam-empty {
			align-self: center;
		}
		:scope > .container > .scrollable-content > sam-limits-monitoring-absences-detail {
			margin-top: 26px;
		}
		:scope > .container > .scrollable-content > .section > .resume-container {
			border: 1px solid @lines;
			border-radius: 10px;
			margin-top: 26px;
		}
		:scope > .container > .scrollable-content > .section > .resume-container > .resume-row {
			height: 40px;
			padding: 0 10px;
			font-size: 14px;
		}
		:scope > .container > .scrollable-content > .section > .resume-container > .resume-row:not(:last-child) {
			border-bottom: 1px solid @lines;
		}
		:scope > .container > .scrollable-content > .section > .resume-container > .resume-row > .item-title {
			color: @lighttext;
			margin-right: 5px;
		}
		:scope > .container > .scrollable-content > .section > .resume-container > .resume-row > .item-value {
			color: @primary;
		}

		@media screen and (max-width: 600px) {
			:scope > .container {
				min-width: 0px;
				padding: 0px 16px;
			}
			:scope > .container > .scrollable-content > .student-container {
				-ms-box-orient: vertical;
				-webkit-flex-direction: column;
				-moz-flex-direction: column;
				-ms-flex-direction: column;
				flex-direction: column;
				-ms-flex-align: stretch;
				-webkit-box-align: stretch;
				-webkit-align-items: stretch;
				align-items: stretch;
			}
			:scope > .container > .scrollable-content > .student-container > sam-limits-monitoring-student-details {
				margin-right: 0px;
				margin-bottom: 26px;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var updateAdjustmentsButton = null;
		var sendNotificationButton = null;
		var sendRetakeButton = null;
		var sendLateButton = null;
		var sendContractButton = null;
		var notificationsList = null;
		var currentDialog = null;

		tag.student = opts.student;
		tag.studentDetailOrigin = opts.origin;
		tag.selectedView = opts.selectedView;
		tag.schoolTotalAbsences = tag.student.totalAbsences + "/" + tag.student.maxAbsencesSchool;
		tag.sectionNotificationHistory = tag.student.sectionNotificationHistory || [];
		tag.sectionAbsencesDetails = tag.student.sectionAbsencesDetails || [];
		tag.showNotificationHistory = tag.sectionNotificationHistory.length > 0;
		tag.showUpdateAdjustments = app.hasAuthority(app.AUTHORITY.UPDATE_ADJUSTMENTS);
		tag.showSendNotifications = app.hasAuthority(app.AUTHORITY.SEND_NOTIFICATION);
		tag.showSendRetake = app.hasAuthority(app.AUTHORITY.SEND_RETAKE);
		tag.showSendLate = app.hasAuthority(app.AUTHORITY.SEND_LATE);
		tag.showSendContract = app.hasAuthority(app.AUTHORITY.GENERATE_CONTRACT);
		tag.showActions = !app.hasAuthority(app.ROLE.STUDENT) || tag.studentDetailOrigin == app.STUDENT_DETAIL_ORIGIN.REPORTING;
		tag.showAbsences = tag.sectionAbsencesDetails.length > 0;
		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl', 'after-mount');

		function backClickHandler() {
			tag.trigger("back-click", tag);
		}

		function updateAdjustmentsClickHandler() {
			var updateAdjustmentsDom = document.createElement("sam-limits-monitoring-update-adjustments-dialog");
			document.body.appendChild(updateAdjustmentsDom);
			riot.compile(function(){
				var updateAdjustmentsDialog = riot.mount(updateAdjustmentsDom, "sam-limits-monitoring-update-adjustments-dialog", {
				})[0];
				updateAdjustmentsDialog.setData(tag.student.sectionStudentDetails, tag.studentDetailOrigin);
				updateAdjustmentsDialog.on("cancel", function(updateAdjustmentsDialogTag) {
					updateAdjustmentsDialog.unmount();
					currentDialog = null;
				});
				updateAdjustmentsDialog.on("updated", function(updateAdjustmentsDialogTag) {
					updateAdjustmentsDialog.unmount();
					guf.createSnackbar(guf.i18n.get("app.adjustments_updated"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
					currentDialog = null;
				});
				currentDialog = updateAdjustmentsDialog;
			});
		}

		function sendNotificationClickHandler() {
			var sendNotificationsDom = document.createElement("sam-limits-monitoring-send-notifications");
			document.body.appendChild(sendNotificationsDom);
			riot.compile(function(){
				var sendNotificationsDialog = riot.mount(sendNotificationsDom, "sam-limits-monitoring-send-notifications", {
				})[0];
				sendNotificationsDialog.setData(tag.student.studentId, tag.student.sectionStudentDetails, tag.studentDetailOrigin);
				sendNotificationsDialog.on("back", function(sendNotificationsDialogTag) {
					sendNotificationsDialog.unmount();
					currentDialog = null;
				});
				sendNotificationsDialog.on("sent", function(sendNotificationsDialogTag) {
					sendNotificationsDialog.unmount();
					guf.createSnackbar(guf.i18n.get("app.notifications_sent"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
					currentDialog = null;
				});
				currentDialog = sendNotificationsDialog;
			});
		}

		function sendRetakeClickHandler() {
			if(tag.student.sectionStudentDetails.maxAbsencesRetake != null) {
				guf.createDialog(guf.i18n.get("app.notification_sending_confirmation"), guf.i18n.get("app.notification_sending_confirmation_msg"), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
					sendRetakeButton.disable();
					app.limitsMonitoring.sendRetake(tag.student.studentId, tag.studentDetailOrigin, tag.student.sectionStudentDetails)
					.then(function(success) {
						if(success) {
							guf.createSnackbar(guf.i18n.get("app.send_retake_success"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						} else {
							guf.createSnackbar(guf.i18n.get("app.send_retake_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						}
						sendRetakeButton.enable();
					}).catch(function() {
						guf.createSnackbar(guf.i18n.get("app.send_retake_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						sendRetakeButton.enable();
					});
				}, function() {
					// Do nothing
				});				
			} else {
				guf.createDialog(guf.i18n.get("guf.info"), guf.i18n.get("app.notification_cant_be_sent_message"), guf.i18n.get("guf.ok"));
			}
		}

		function sendLateClickHandler() {
			if(tag.student.sectionStudentDetails.maxLateAdjustment != null) {
				guf.createDialog(guf.i18n.get("app.notification_sending_confirmation"), guf.i18n.get("app.notification_sending_confirmation_msg"), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
					sendLateButton.disable();
					app.limitsMonitoring.sendLate(tag.student.studentId, tag.studentDetailOrigin, tag.student.sectionStudentDetails).then(function(success) {
						if(success) {
							guf.createSnackbar(guf.i18n.get("app.send_late_success"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						} else {
							guf.createSnackbar(guf.i18n.get("app.send_late_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						}
						sendLateButton.enable();
					}).catch(function() {
						guf.createSnackbar(guf.i18n.get("app.send_late_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						sendLateButton.enable();
					});
				}, function() {
					// Do nothing
				});
			} else {
				guf.createDialog(guf.i18n.get("guf.info"), guf.i18n.get("app.notification_cant_be_sent_message"), guf.i18n.get("guf.ok"));
			}
		}

		function sendContractClickHandler() {
			if(tag.student.sectionStudentDetails.maxAbsencesContract != null) {
				guf.createDialog(guf.i18n.get("app.notification_sending_confirmation"), guf.i18n.get("app.notification_sending_confirmation_msg"), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
					sendContractButton.disable();
					app.limitsMonitoring.sendContract(tag.student.studentId, tag.studentDetailOrigin, tag.student.sectionStudentDetails).then(function(success) {
						if(success) {
							guf.createSnackbar(guf.i18n.get("app.send_contract_success"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						} else {
							guf.createSnackbar(guf.i18n.get("app.send_contract_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						}
						sendContractButton.enable();
					}).catch(function() {
						guf.createSnackbar(guf.i18n.get("app.send_contract_error"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
						sendContractButton.enable();
					});
				}, function() {
					// Do nothing
				});
			} else {
				guf.createDialog(guf.i18n.get("guf.info"), guf.i18n.get("app.notification_cant_be_sent_message"), guf.i18n.get("guf.ok"));
			}
		}

		function notificationClickHandler(notification) {
			var templateDom = document.createElement("sam-limits-monitoring-notification-template-dialog");
			if(guf.device.isPhone) {
				templateDom.setAttribute("dcss-min-width", "200px");
				templateDom.setAttribute("dcss-min-height", "400px");
			}
			document.body.appendChild(templateDom);
			riot.compile(function(){
				var templateDialog = riot.mount(templateDom, "sam-limits-monitoring-notification-template-dialog", {
				})[0];
				templateDialog.setData(notification);
				templateDialog.on("close", function(templateDialogTag) {
					templateDialog.unmount();
					currentDialog = null;
				});
				currentDialog = templateDialog;
			});
		}

		function meetingClickHandler(notification) {
			var scheduleDom = document.createElement("sam-limits-monitoring-notification-schedule-dialog");
			if(guf.device.isPhone) {
				scheduleDom.setAttribute("dcss-min-width", "200px");
				scheduleDom.setAttribute("dcss-min-height", "400px");
			}
			document.body.appendChild(scheduleDom);
			riot.compile(function(){
				var scheduleDialog = riot.mount(scheduleDom, "sam-limits-monitoring-notification-schedule-dialog", {
					showOk: notification.canModify
				})[0];
				scheduleDialog.setData(notification);
				scheduleDialog.on("nok", function(scheduleDialogTag) {
					scheduleDialog.unmount();
					currentDialog = null;
				});
				scheduleDialog.on("ok", function(scheduleDialogTag, scheduleDate, realDate, comment) {
					app.limitsMonitoring.updateMeeting(notification, scheduleDate, realDate, comment, tag.studentDetailOrigin, tag.student.sectionStudentDetails).then(function(success) {
						if(success) {
							scheduleDialog.unmount();
							guf.createSnackbar(guf.i18n.get("app.meeting_updated"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
							currentDialog = null;
						}
					});
				});
				currentDialog = scheduleDialog;
			});
		}

		function limitsMonitoringUpdatedHandler() {
			var studentId = app.limitsMonitoring.getStudent(tag.student.studentId); 
			tag.setStudent(app.limitsMonitoring.getStudent(tag.student.studentId));
		}

		function initView() {
			if(tag.showUpdateAdjustments) {
				updateAdjustmentsButton = tag.refs["actions"].refs["update-adjustments"];
			}
			if(tag.showSendNotifications) {
				sendNotificationButton = tag.refs["actions"].refs["send-notification"];
			}
			if(tag.showSendRetake) {
				sendRetakeButton = tag.refs["actions"].refs["send-retake"];
			}
			if(tag.showSendLate) {
				sendLateButton = tag.refs["actions"].refs["send-late"];
			}
			if(tag.showSendContract) {
				sendContractButton = tag.refs["actions"].refs["send-contract"];
			}
			if(tag.showNotificationHistory) {
				notificationsList = tag.tags["sam-limits-monitoring-notification-list"];
			}
		}

		function initNotificationHistoryEvents() {
			if(tag.showNotificationHistory) {
				notificationsList.on("notification-click", notificationClickHandler);
				notificationsList.on("meeting-click", meetingClickHandler);
			}
		}

		function removeNotificationHistoryEvents() {
			if(tag.showNotificationHistory) {
				notificationsList.off("notification-click", notificationClickHandler);
				notificationsList.off("meeting-click", meetingClickHandler);
			}
		}

		function initEvents() {
			if(tag.showActions) {
				tag.refs["actions"].refs["back-button"].on("click", backClickHandler);
			}
			if(tag.showUpdateAdjustments) {
				updateAdjustmentsButton.on("click", updateAdjustmentsClickHandler);
			}
			if(tag.showSendNotifications) {
				sendNotificationButton.on("click", sendNotificationClickHandler);
			}
			if(tag.showSendRetake) {
				sendRetakeButton.on("click", sendRetakeClickHandler);
			}
			if(tag.showSendLate) {
				sendLateButton.on("click", sendLateClickHandler);
			}
			if(tag.showSendContract) {
				sendContractButton.on("click", sendContractClickHandler);
			}
			app.limitsMonitoring.on("updated", limitsMonitoringUpdatedHandler);
			initNotificationHistoryEvents();
		}

		function removeEvents() {
			if(tag.showActions) {
				tag.refs["actions"].refs["back-button"].off("click", backClickHandler);
			}
			if(tag.showUpdateAdjustments) {
				updateAdjustmentsButton.off("click", updateAdjustmentsClickHandler);
			}
			if(tag.showSendNotifications) {
				sendNotificationButton.off("click", sendNotificationClickHandler);
			}
			if(tag.showSendRetake) {
				sendRetakeButton.off("click", sendRetakeClickHandler);
			}
			if(tag.showSendLate) {
				sendLateButton.off("click", sendLateClickHandler);
			}
			if(tag.showSendContract) {
				sendContractButton.off("click", sendContractClickHandler);
			}
			app.limitsMonitoring.off("updated", limitsMonitoringUpdatedHandler);
			removeNotificationHistoryEvents();
		}

		tag.setStudent = function(student) {
			removeNotificationHistoryEvents();
			tag.student = student;
			tag.schoolTotalAbsences = tag.student.totalAbsences + "/" + tag.student.maxAbsencesSchool;
			tag.sectionNotificationHistory = tag.student.sectionNotificationHistory || [];
			tag.sectionAbsencesDetails = tag.student.sectionAbsencesDetails || [];
			tag.showNotificationHistory = tag.sectionNotificationHistory.length > 0;
			tag.showAbsences = tag.sectionAbsencesDetails.length > 0;
			tag.update();
			if(tag.showNotificationHistory) {
				notificationsList = tag.tags["sam-limits-monitoring-notification-list"];
			}
			initNotificationHistoryEvents();
		};

		tag.on("mount", function() {
			initView();
			initEvents();
		});

		tag.on("after-mount", function() {
			var nodes = tag.root.querySelectorAll(".mdl-tooltip");
			for(var i=0; i<nodes.length; i++) {
				componentHandler.upgradeElement(nodes[i]);
			}
		});

		tag.on("before-unmount", function() {
			removeEvents();
			if(currentDialog && currentDialog.isMounted) {
				currentDialog.unmount();
			}
		});
	</script>
</sam-limits-monitoring-details>