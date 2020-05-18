<sam-canvas>
	<!--<div if="{guf.device.isIos}" class="top-padding guf-safe-height-top"></div>-->
	<guf-canvas drawer="true" header="true" card-when-big="true" fixed-header="true" elevation="false" hide-top-padding="true" left-column-visible-for-popup="true">
		<yield to="header-content">
			<div class="campus-logo-container">
				<guf-image class="mdl-layout-title" width="{guf.device.isPhone ? 70 : 140}" height="{guf.device.isPhone ? 20 : 40}" imagesrc="img/group/{app.getMe().campus.groupId}-header.png"></guf-image>
				<div class="campus-text">{app.getMe().campus.campus}</div>
			</div>
			<div class="flex1"></div>
			<div class="campus-text">{app.getMe().name + ' (' + app.getMe().username + ')'}</div>
		</yield>
		<yield to="drawer-content">
			<guf-linear-layout orientation="vertical" v-align="center" h-align="center">
				<guf-image class="drawer-logo" width="150" height="50" imagesrc="img/group/{app.getMe().campus.groupId}-drawer.png"></guf-image>
				<div class="drawer-campus campus-text">{app.getMe().campus.campus}</div>
			</guf-linear-layout>
			<nav class="mdl-navigation guf-safe-padding-bottom">
				<guf-drawer-item ref="drawer-roll-call" icon="event_available" if="{app.hasAuthority(app.AUTHORITY.ROLL_CALL)}">
					<guf-i18n key="app.roll_call"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-class-records" icon="calendar_today" if="{app.hasAuthority(app.AUTHORITY.CLASS_RECORDS)}">
					<guf-i18n key="app.class_records"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-pending-class-records" icon="list" if="{app.hasAuthority(app.AUTHORITY.PENDING_CLASS_RECORDS)}">
					<guf-i18n key="app.pending_class_records"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-limits-monitoring" icon="info" if="{app.hasAuthority(app.AUTHORITY.LIMITS_MONITORING)}">
					<guf-i18n key="app.limits_monitoring"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-reporting" icon="bar_chart" if="{app.hasAuthority(app.AUTHORITY.LIMITS_MONITORING)}">
					<guf-i18n key="app.reporting"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-import-files" icon="cloud_upload" if="{app.hasAuthority(app.AUTHORITY.FILE_UPLOAD)}">
					<guf-i18n key="app.import_files"/>
				</guf-drawer-item>
				<guf-drawer-item ref="drawer-users-maintenance" icon="people" if="{app.hasAuthority(app.AUTHORITY.USERS_MANAGEMENT)}">
					<guf-i18n key="app.users_maintenance"/>
				</guf-drawer-item>
				<!--<guf-drawer-item ref="drawer-about" icon="info">
					<guf-i18n key="app.about"/>
				</guf-drawer-item>-->
				<guf-drawer-item ref="drawer-logout" icon="power_settings_new">
					<guf-i18n key="app.logout"/>
				</guf-drawer-item>
			</nav>
		</yield>
	</guf-canvas>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-flow: column;
			-moz-flex-flow: column;
			-ms-flex-flow: column;
			flex-flow: column;
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
			min-height: 242px;
			position: relative;
		}
		.guf-device-ios :scope > div.top-padding {
			display: block;
			background-color: @lightestbackground;
			z-index: 101;
		}
		:scope > guf-canvas {
			background-color: @background;
		}

		:scope > guf-canvas > div > div[ref="main-layout"] > header.mdl-layout__header {
			background-color: @lightestbackground;
			border-bottom: 1px solid @background;
		}

		:scope > guf-canvas > div > div[ref="main-layout"] > main {
			background-color: @lightestbackground;
		}

		:scope > guf-canvas header.mdl-layout__header .mdl-layout__drawer-button {
			color: @primary;
		}
		
		/* TODO: improve this */
		header.mdl-layout__header guf-profile .profile_button * {
			color: @lightestbackground;
		}
		header.mdl-layout__header guf-profile .profile_button span.profile_name { /* TODO: rethink if this has to be a new parameter for guf-profile */
			font-size: 13pt;
		}
		/* TODO: improve this */
		header.mdl-layout__header .mdl-button {
			text-transform: none;
		}
		:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row {
			padding-right: 26px;
		}
		.guf-screen-narrow :scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row > .mdl-layout-title {
			margin-left: 5px;
		}
		:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row > div.campus-logo-container > guf-image.mdl-layout-title {
			margin-right: 16px;
		}
		:scope div.campus-logo-container {
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
			-ms-flex-align: center;
			-webkit-box-align: center;
			-webkit-align-items: center;
			align-items: center;
			margin-right: 16px;
		}

		:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row > .campus-text {
			flex-shrink: 1;
			text-align: right;
		}
		:scope .campus-text {
			color: @lighttext;
		}
		:scope .drawer-campus {
			margin-top: 8px;
		}

		div[ref="drawer"] {
			background-color: @lightestbackground;
			border-right: 1px solid @lines;
		}

		div[ref="drawer"] > div > guf-linear-layout {
			margin-top: 30px;
			margin-bottom: 90px;
			height: 100px;
		}

		div[ref="drawer"] > div > nav.mdl-navigation {
			padding-left: 8px;
			padding-right: 8px;
		}

		div[ref="drawer"] .mdl-navigation > guf-drawer-item {
			margin-bottom: 16px;
		}

		div[ref="drawer"] .mdl-navigation .mdl-navigation__link {
			display: flex;
			padding: 8px 16px;
			color: @lighttext;
			border-radius: 4px;
		}

		div[ref="drawer"] .mdl-navigation__link:hover .mdl-badge--colored {
			background: @lightestbackground;
		}

		div[ref="drawer"] .mdl-navigation .mdl-navigation__link .material-icons {
			margin-right: 16px;
		}

		div[ref="drawer"] .mdl-navigation .mdl-navigation__link:hover{
			background-color: @primary;
			color: @lightestbackground;
		}

		div[ref="drawer"] .mdl-navigation .mdl-navigation__link:hover .material-icons{
			color: @lightestbackground;
		}

		@media screen {
			body.guf-screen-narrow :scope .mdl-layout__header-row {
				height: 56px;
				padding: 0 16px 0 56px;
			}
		}

		@media screen and (max-width: 600px) {
			:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row {
				padding-right: 16px;
			}
			:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row > div.campus-logo-container > guf-image.mdl-layout-title {
				margin-right: 0px;
			}
			:scope div.campus-logo-container {
				-ms-box-orient: vertical;
				-webkit-flex-direction: column;
				-moz-flex-direction: column;
				-ms-flex-direction: column;
				flex-direction: column;
			}
			:scope div[ref="main-layout"] > header.mdl-layout__header > .mdl-layout__header-row .campus-text {
				font-size: 12px;
				line-height: 1.4;
				word-break: break-word;
			}
		}
	</style>
	<script>
		var tag = this;
		var canvasTag = null;
		var currentModule = null;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"background": "@background",
			"lighttext": "@lighttext"
		};
		tag.mixin('mdl');

		function initEvents() {
			if (canvasTag.refs['drawer-roll-call']) canvasTag.refs['drawer-roll-call'].on("click", drawerRollCall);
			if (canvasTag.refs['drawer-class-records']) canvasTag.refs['drawer-class-records'].on("click", drawerClassRecords);
			if (canvasTag.refs['drawer-pending-class-records']) canvasTag.refs['drawer-pending-class-records'].on("click", drawerPendingClassRecords);
			if (canvasTag.refs['drawer-limits-monitoring']) canvasTag.refs['drawer-limits-monitoring'].on("click", drawerLimitsMonitoring);
			if (canvasTag.refs['drawer-reporting']) canvasTag.refs['drawer-reporting'].on("click", drawerReporting);
			if (canvasTag.refs['drawer-import-files']) canvasTag.refs['drawer-import-files'].on("click", drawerFilesUpload);
			if (canvasTag.refs['drawer-users-maintenance']) canvasTag.refs['drawer-users-maintenance'].on("click", drawerUsersMaintenance);
			canvasTag.refs['drawer-logout'].on("click", drawerLogout);
			guf.route.on("route", routeChange);
		}

		function removeEvents() {
			if (canvasTag.refs['drawer-roll-call']) canvasTag.refs['drawer-roll-call'].off("click", drawerRollCall);
			if (canvasTag.refs['drawer-class-records']) canvasTag.refs['drawer-class-records'].off("click", drawerClassRecords);
			if (canvasTag.refs['drawer-pending-class-records']) canvasTag.refs['drawer-pending-class-records'].off("click", drawerPendingClassRecords);
			if (canvasTag.refs['drawer-limits-monitoring']) canvasTag.refs['drawer-limits-monitoring'].off("click", drawerLimitsMonitoring);
			if (canvasTag.refs['drawer-reporting']) canvasTag.refs['drawer-reporting'].off("click", drawerReporting);
			if (canvasTag.refs['drawer-import-files']) canvasTag.refs['drawer-import-files'].off("click", drawerFilesUpload);
			if (canvasTag.refs['drawer-users-maintenance']) canvasTag.refs['drawer-users-maintenance'].off("click", drawerUsersMaintenance);
			canvasTag.refs['drawer-logout'].off("click", drawerLogout);
			guf.route.off("route", routeChange);
		}

		tag.on("mount", function() {
			canvasTag = tag.tags["guf-canvas"];
			routeChange(guf.route.getCollection(), guf.route.getId(), guf.route.getAction(), true);
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
			canvasTag = null;
		});

		function routeChange(collection, id, action, initial) {
			switch(collection) {
				case app.MODULE.ROLL_CALL:
					if (app.hasAuthority(app.AUTHORITY.ROLL_CALL)) {
						showRollCall();
						return;
					}
					break;
				case app.MODULE.CLASS_RECORDS:
					if (app.hasAuthority(app.AUTHORITY.CLASS_RECORDS)) {
						showClassRecords();
						return;
					}
					break;
				case app.MODULE.PENDING_CLASS_RECORDS:
					if (app.hasAuthority(app.AUTHORITY.PENDING_CLASS_RECORDS)) {
						showPendingClassRecords();
						return;
					}
					break;
				case app.MODULE.LIMITS_MONITORING:
					if (app.hasAuthority(app.AUTHORITY.LIMITS_MONITORING)) {
						if (app.hasAuthority(app.ROLE.STUDENT)) {
							showLimitsMonitoringForStudent();
						} else {
							showLimitsMonitoring();
						}
						return;
					}
					break;
				case app.MODULE.REPORTING:
					if (app.hasAuthority(app.AUTHORITY.LIMITS_MONITORING)) {
						showReporting();
						return;
					}
					break;
				case app.MODULE.IMPORT_FILES:
					if (app.hasAuthority(app.AUTHORITY.FILE_UPLOAD)) {
						showFilesUpload();
						return;
					}
					break;
				case app.MODULE.USERS_MAINTENANCE:
					if (app.hasAuthority(app.AUTHORITY.USERS_MANAGEMENT)) {
						showUsersMaintenance();
						return;
					}
					break;
				case "exit":
					return;
			}
			guf.route.to("", undefined, true);
			showEmpty();
		}

		function setMiddleColumnContent(dom, options, configFn, forceShow) {
			canvasTag.setMiddleColumnContent(dom, options, configFn, forceShow);
		}

		function setPopupColumnContent(dom, options, configFn, forceShow) {
			canvasTag.setPopupColumnContent(dom, options, configFn, forceShow);
		}

		function showEmpty() {
			currentModule = app.MODULE.NONE;
			var emptyDom = document.createElement("sam-empty");
			var options = {
				"text": guf.i18n.get('app.workspace_empty_text'),
				"icon": "menu"
			}
			emptyDom.setAttribute("class", "flex1");
			setMiddleColumnContent(emptyDom, options, function(emptyTag) {
				guf.setTimeout(openDrawer,100);
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showRollCall() {
			currentModule = app.MODULE.ROLL_CALL;
			var rollCallDom = document.createElement("sam-roll-call");
			var options = {
			};
			rollCallDom.setAttribute("class", "flex1");
			setMiddleColumnContent(rollCallDom, options, function(rollCallTag) {
				guf.route.to(app.MODULE.ROLL_CALL, undefined, true);
				rollCallTag.on("scroll", function(offset) {
					canvasTag.scrollColumn("middle", offset);
				});
				rollCallTag.on("scroll-delta", function(delta) {
					canvasTag.scrollDeltaColumn("middle", delta);
				});
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showClassRecords() {
			currentModule = app.MODULE.CLASS_RECORDS;
			var classRecordsDom = document.createElement("sam-class-records");
			var options = {
			};
			classRecordsDom.setAttribute("class", "flex1");
			setMiddleColumnContent(classRecordsDom, options, function(classRecordsTag) {
				guf.route.to(app.MODULE.CLASS_RECORDS, undefined, true);
				classRecordsTag.on("scroll-delta", function(delta) {
					canvasTag.scrollDeltaColumn("middle", delta);
				});
				classRecordsTag.on("go-out", function(){
					classRecordsTag.unmount();
					openDrawer();
					currentModule = null;
					guf.route.to("", undefined, true);
				});
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showPendingClassRecords() {
			currentModule = app.MODULE.PENDING_CLASS_RECORDS;
			var pendingClassRecordsDom = document.createElement("sam-pending-class-records");
			var options = {
			};
			pendingClassRecordsDom.setAttribute("class", "flex1");
			setMiddleColumnContent(pendingClassRecordsDom, options, function(pendingClassRecordsTag) {
				guf.route.to(app.MODULE.PENDING_CLASS_RECORDS, undefined, true);
				pendingClassRecordsTag.on("submit-click", showClassRecordsModal);
				pendingClassRecordsTag.on("scroll-delta", function(delta) {
					canvasTag.scrollDeltaColumn("middle", delta);
				});
				pendingClassRecordsTag.on("go-out", function(){
					pendingClassRecordsTag.unmount();
					openDrawer();
					currentModule = null;
					guf.route.to("", undefined, true);
				});
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showLimitsMonitoring() {
			currentModule = app.MODULE.LIMITS_MONITORING;
			var limitsMonitoringDom = document.createElement("sam-limits-monitoring");
			var options = {
			};
			limitsMonitoringDom.setAttribute("class", "flex1");
			setMiddleColumnContent(limitsMonitoringDom, options, function(limitsMonitoringTag) {
				guf.route.to(app.MODULE.LIMITS_MONITORING, undefined, true);
				limitsMonitoringTag.on("student-click", showLimitsMonitoringModal);
				limitsMonitoringTag.on("scroll", function(offset) {
					canvasTag.scrollColumn("middle", offset);
				});
				limitsMonitoringTag.on("scroll-delta", function(delta) {
					canvasTag.scrollDeltaColumn("middle", delta);
				});
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showLimitsMonitoringForStudent() {
			currentModule = app.MODULE.LIMITS_MONITORING;
			var limitsMonitoringDom = document.createElement("sam-limits-monitoring-details");
			var options = {
				student: {},
				selectedView: app.LIMITS_MONITORING_VIEW.SCHOOL,
				origin: app.STUDENT_DETAIL_ORIGIN.STUDENT_LOGIN
			};
			limitsMonitoringDom.setAttribute("class", "flex1");
			setMiddleColumnContent(limitsMonitoringDom, options, function(limitsMonitoringTag) {
				guf.route.to(app.MODULE.LIMITS_MONITORING, undefined, true);
				app.limitsMonitoring.loadForStudent().then(function(studentData) {
					limitsMonitoringTag.setStudent(studentData);
				});
			}, false);
			canvasTag.showColumn("middle", true);
		}		


		function showReporting() {
			currentModule = app.MODULE.REPORTING;
			var reportingDom = document.createElement("sam-reporting");
			var options = {
			};
			reportingDom.setAttribute("class", "flex1");
			setMiddleColumnContent(reportingDom, options, function(reportingTag) {
				guf.route.to(app.MODULE.REPORTING, undefined, true);
				reportingTag.on("scroll-delta", function(delta) {
					canvasTag.scrollDeltaColumn("middle", delta);
				});
				reportingTag.on("student-details-click", showLimitsMonitoringFromReportingModal);
				// reportingTag.on("student-click", showReportingModal);
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showFilesUpload() {
			currentModule = app.MODULE.IMPORT_FILES;
			var filesUploadDom = document.createElement("sam-import-files");
			var options = {
			};
			filesUploadDom.setAttribute("class", "flex1");
			setMiddleColumnContent(filesUploadDom, options, function(filesUploadTag) {
				guf.route.to(app.MODULE.IMPORT_FILES, undefined, true);
			}, false);
			canvasTag.showColumn("middle", true);
		}

		function showUsersMaintenance() {
			currentModule = app.MODULE.USERS_MAINTENANCE;
			var usersMaintenanceDom = document.createElement("sam-users-maintenance");
			var options = {
			};
			usersMaintenanceDom.setAttribute("class", "flex1");
			setMiddleColumnContent(usersMaintenanceDom, options, function(usersMaintenanceTag) {
				guf.route.to(app.MODULE.USERS_MAINTENANCE, undefined, true);
				usersMaintenanceTag.on("add-user-click", showCreateUserModal);
				usersMaintenanceTag.on("edit-user-click", showEditUserModal);
			}, false);
			canvasTag.showColumn("middle", true);
		}

		// Modal screens

		function showClassRecordsModal(pendingClassRecordsTag, itemData) {
			var classRecordsDom = document.createElement("sam-pending-class-records-details");
			var options = {
				filter: itemData
			};
			classRecordsDom.setAttribute("class", "flex1");
			setPopupColumnContent(classRecordsDom, options, function(classRecordsTag) {
				classRecordsTag.on("back-click", function(aTag) {
					classRecordsTag.unmount();
					canvasTag.showColumn("middle", true);
				});
				classRecordsTag.on("submitted", function(aTag, newItem) {
					classRecordsTag.unmount();
					canvasTag.showColumn("middle", true);
					if(pendingClassRecordsTag.isMounted) {
						pendingClassRecordsTag.updateItem(newItem);
					}
					guf.createSnackbar(guf.i18n.get("app.class_records_updated"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				});
			});
			canvasTag.showColumn("popup");
		}

		function showLimitsMonitoringModal(studentData, selectedView) {
			var limitsMonitoringDom = document.createElement("sam-limits-monitoring-details");
			
			var options = {
				student: studentData,
				selectedView: selectedView,
				origin: app.STUDENT_DETAIL_ORIGIN.LIMITS_MONITORING
			};
			limitsMonitoringDom.setAttribute("class", "flex1");
			setPopupColumnContent(limitsMonitoringDom, options, function(limitsMonitoringTag) {
				limitsMonitoringTag.on("back-click", function(aTag) {
					limitsMonitoringTag.unmount();
					canvasTag.showColumn("middle", true);
				});
			});
			canvasTag.showColumn("popup");
		}
		
		function showLimitsMonitoringFromReportingModal(semester, studentId, year) {
			var limitsMonitoringDom = document.createElement("sam-limits-monitoring-details");
			var options = {
				student: {},
				selectedView: app.LIMITS_MONITORING_VIEW.SCHOOL,
				origin: app.STUDENT_DETAIL_ORIGIN.REPORTING
			};
			limitsMonitoringDom.setAttribute("class", "flex1");
			setPopupColumnContent(limitsMonitoringDom, options, function(limitsMonitoringTag) {
				app.limitsMonitoring.loadBySemesterYearStudentId(semester, studentId, year)
				.then(function(studentData) {
					limitsMonitoringTag.setStudent(studentData);
				});
				limitsMonitoringTag.on("back-click", function(aTag) {
					limitsMonitoringTag.unmount();
					canvasTag.showColumn("middle", true);
				});
			});
			canvasTag.showColumn("popup");

		}

		function showCreateUserModal(umTag) {
			var createUserDom = document.createElement("sam-users-maintenance-create-user");
			var options = {
				campus: umTag.campus,
				roles: umTag.roles
			};
			createUserDom.setAttribute("class", "flex1");
			setPopupColumnContent(createUserDom, options, function(createUserTag) {
				createUserTag.on("cancel-click", function(aTag) {
					createUserTag.unmount();
					canvasTag.showColumn("middle", true);
				});
				createUserTag.on("created", function(aTag) {
					createUserTag.unmount();
					canvasTag.showColumn("middle", true);
					if(umTag.isMounted) {
						umTag.refreshData();
					}
					guf.createSnackbar(guf.i18n.get("app.user_created"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				});
			});
			canvasTag.showColumn("popup");
		}

		function showEditUserModal(umTag, userTag, userData) {
			var editUserDom = document.createElement("sam-users-maintenance-edit-user");
			var options = {
				campus: umTag.campus,
				roles: umTag.roles,
				user: userData
			};
			editUserDom.setAttribute("class", "flex1");
			setPopupColumnContent(editUserDom, options, function(editUserTag) {
				editUserTag.on("cancel-click", function(aTag) {
					editUserTag.unmount();
					canvasTag.showColumn("middle", true);
				});
				editUserTag.on("saved", function(aTag) {
					editUserTag.unmount();
					canvasTag.showColumn("middle", true);
					if(umTag.isMounted) {
						umTag.refreshData();
					}
					guf.createSnackbar(guf.i18n.get("app.user_edited"), null, null, app.SNACKBAR_DEFAULT_TIMEOUT);
				});
			});
			canvasTag.showColumn("popup");
		}

		function openDrawer() {
			var menu = canvasTag.refs['drawer'];
			if (!menu.classList.contains('is-visible')) {
				var layout = canvasTag.refs['main-layout'];
				layout.MaterialLayout.toggleDrawer();
			}
		}

		function closeDrawer() {
			var menu = canvasTag.refs['drawer'];
			if (menu.classList.contains('is-visible')) {
				var layout = canvasTag.refs['main-layout'];
				layout.MaterialLayout.toggleDrawer();
			}
		}

		function drawerRollCall() {
			closeDrawer();
			if (canvasTag.getPopupColumnContent()) canvasTag.getPopupColumnContent().unmount();
			if (currentModule != app.MODULE.ROLL_CALL) {
				showRollCall();
			}
		}

		function drawerClassRecords() {
			closeDrawer();
			if (canvasTag.getPopupColumnContent()) canvasTag.getPopupColumnContent().unmount();
			if (currentModule != app.MODULE.CLASS_RECORDS) {
				showClassRecords();
			}
		}

		function drawerPendingClassRecords() {
			closeDrawer();
			if (currentModule != app.MODULE.PENDING_CLASS_RECORDS) {
				showPendingClassRecords();
			}
		}

		function drawerLimitsMonitoring() {
			closeDrawer();
			if (currentModule != app.MODULE.LIMITS_MONITORING) {
				if (app.hasAuthority(app.ROLE.STUDENT)) {
					showLimitsMonitoringForStudent();
				} else {
					showLimitsMonitoring();
				}
			}
		}

		function drawerReporting() {
			closeDrawer();
			if (currentModule != app.MODULE.REPORTING) {
				showReporting();
			}
		}

		function drawerFilesUpload() {
			closeDrawer();
			if (canvasTag.getPopupColumnContent()) canvasTag.getPopupColumnContent().unmount();
			if (currentModule != app.MODULE.IMPORT_FILES) {
				showFilesUpload();
			}
		}

		function drawerUsersMaintenance() {
			closeDrawer();
			if (canvasTag.getPopupColumnContent()) canvasTag.getPopupColumnContent().unmount();
			if (currentModule != app.MODULE.USERS_MAINTENANCE) {
				showUsersMaintenance();
			}
		}

		function drawerLogout() {
			closeDrawer();
			guf.storage.removeItem(guf.storage.CURRENT, "wasLogged");				
			app.ajax.get("api/logout", {}, function(data, xhr) {
				guf.route.to("", undefined, true);
				tag.trigger("logged-out");
			}, function(data, xhr) { 
				guf.console.warn("When logging out", data, xhr);
				tag.trigger("logged-out");
			});
		}

	</script>
</sam-canvas>