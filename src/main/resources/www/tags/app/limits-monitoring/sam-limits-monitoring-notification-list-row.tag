<sam-limits-monitoring-notification-list-row>
	<div class="title-column flex1">{guf.ancestor(this, 'sam-limits-monitoring-notification-list-row').notificationTitle}</div>
	<div class="date-column">{guf.ancestor(this, 'sam-limits-monitoring-notification-list-row').notificationDate}</div>
	<div class="notification-column"><i ref="notification" class="material-icons-outlined">info</i></div>
	<div class="meeting-column"><i ref="meeting" class="material-icons">{guf.ancestor(this, 'sam-limits-monitoring-notification-list-row').meetingIcon}</i></div>
	<style scoped type="dcss">
		:scope {
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
			overflow: hidden;
			min-height: 35px;
		}
		:scope > div {
			color: @lighttext;
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			justify-content: center;
			font-size: 14px;
			padding-left: 10px;
			padding-right: 10px;
			border-right: 1px solid @background;
			word-break: break-word;
		}
		:scope > .title-column {
		}
		:scope > .date-column {
			width: 80px;
			text-align: center;
		}
		:scope > .notification-column {
			width: 50px;
			text-align: center;
		}
		:scope > .notification-column > i {
			cursor: pointer;
		}
		:scope > .meeting-column {
			width: 50px;
			text-align: center;
			border-right: 0px;
		}
		:scope > .meeting-column > i {
			cursor: pointer;
		}

		@media screen and (max-width: 600px) {
			:scope > div {
				font-size: 12px;
				line-height: 1.4;
				padding: 0 6px;
			}
			:scope > .title-column {
				min-width: 100px;
			}
			:scope > .date-column {
				width: 60px;
				font-size: 11px;
			}
			:scope > .notification-column {
				width: 30px;
			}
			:scope > .meeting-column {
				width: 30px;
			}
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"accent": "@accent",
			"background": "@background",
			"darktext": "@darktext",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};
		tag.mixin('mdl');

		tag.notificationTitle = tag.notification.notification;
		tag.notificationDate = moment(tag.notification.datetime,"YYYY-MM-DD").format("L");
		tag.meetingIcon = (tag.notification.meetingScheduledDate || "").length > 0 && (tag.notification.meetingActualDate || "").length > 0 ? "check" : "more_horiz";
		tag.relayEvents = ["meeting-click", "notification-click"];

		function meetingClickHandler() {
			tag.trigger("meeting-click", tag.notification);
		}

		function notificationClickHandler() {
			tag.trigger("notification-click", tag.notification);
		}

		function initEvents() {
			tag.refs["notification"].addEventListener("click", notificationClickHandler);
			tag.refs["meeting"].addEventListener("click", meetingClickHandler);
		}

		function removeEvents() {
			tag.refs["notification"].removeEventListener("click", notificationClickHandler);
			tag.refs["meeting"].removeEventListener("click", meetingClickHandler);
		}

		tag.on("mount", function() {
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
		});
	</script>
</sam-limits-monitoring-notification-list-row>