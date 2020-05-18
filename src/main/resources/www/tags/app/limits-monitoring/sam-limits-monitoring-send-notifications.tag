<sam-limits-monitoring-send-notifications>
	<button ref="focus-gain" autofocus="true" class="focus-gain"></button>
	<guf-linear-layout ref="horizontal-wrapper" orientation="horizontal" class="horizontal-wrapper fullscreen">
		<guf-linear-layout ref="vertical-wrapper" orientation="vertical" class="vertical-wrapper">
			<guf-linear-layout ref="dialog" orientation="vertical" class="dialog">
				<div class="dialog-title">{guf.i18n.get('app.send_notifications')}</div>
				<guf-linear-layout ref="action-buttons" orientation="horizontal" v-align="center" class="action-buttons">
					<guf-button ref="back-button" type="flat" color="true" icon="arrow_back" dcss-border="1px solid @lines">{guf.i18n.get('guf.back')}</guf-button>
					<div class="flex1"></div>
					<guf-button ref="send-button" ripple="true" type="color-flat" color="true" dcss-text-color-disabled="@disabled" disabled="true">{guf.i18n.get('app.send')}</guf-button>
				</guf-linear-layout>
				<guf-linear-layout ref="content" orientation="vertical" class="content">
					<sam-limits-monitoring-send-notifications-list-header></sam-limits-monitoring-send-notifications-list-header>
					<sam-limits-monitoring-send-notifications-list-row each={item in guf.ancestor(this, 'sam-limits-monitoring-send-notifications').notifications}>
					</sam-limits-monitoring-send-notifications-list-row>
				</guf-linear-layout>
			</guf-linear-layout>
		</guf-linear-layout>
	</guf-linear-layout>
	<style scoped type="text/dcss">
		:scope {
			position: absolute;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			z-index: 1;
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
		}
		:scope > .focus-gain {
			opacity: 0;
			position: absolute;
			top: -90000px;
		}
		.guf-device-ios :scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content {
			-webkit-overflow-scrolling: touch;
		}
		.guf-device-ios :scope > div.ios-statusbar {
			display: block;
			background-color: @headerBackground;
			z-index: 101;
		}
		:scope,
		:scope > .horizontal-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			min-width: 0;
			min-height: 0;
		}
		:scope > .horizontal-wrapper.fullscreen,
		:scope > .horizontal-wrapper > .vertical-wrapper,
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog,
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content {
			-webkit-flex: 1;
			-ms-flex: 1;
			flex: 1;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog {
			background-color: @background;
			z-index: 999999999;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			background-color: @headerBackground;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row {
			padding-left: 40px;
		}
		.guf-screen-narrow :scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row {
			padding-left: 16px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row > .close {
			margin-right: 16px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > header > .mdl-layout__header-row > .dialog-title {
			-webkit-flex: 0 1 auto;
			-ms-flex: 0 1 auto;
			flex: 0 1 auto;
			color: @fsHeaderColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .dialog-title {
			padding: @headerPadding;
			font-size: 20px;
			line-height: 28px;
			color: @headerColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			color: @contentColor;
			padding: @contentPadding;
		}
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content {
			overflow-y: auto;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons {
			padding: 8px 24px 24px 24px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons > guf-button:not(:first-child) {
			margin-left: 8px;
		}
		:scope > .horizontal-wrapper.fullscreen > .vertical-wrapper > .dialog > .content > * {
			flex-shrink: 0;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content > sam-limits-monitoring-send-notifications-list-row:last-child {
			border-bottom-left-radius: 10px;
			border-bottom-right-radius: 10px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		// Dcss
		tag.defaultDcss = {
			// - material default values
			"background": "#fff",
			"headerBackground": "@primary",
			"headerPadding": "24px 24px 20px 24px",
			"headerColor": "#000",
			"contentColor": "rgba(0,0,0,.54)",
			"contentPadding": "0 24px 24px 24px",
			// - custom
			"maxWidth": "600px",
			"primary": "@primary",
			"lines": "@lines",
			"lightestbackground": "@lightestbackground",
			"lighttext": "@lighttext"
		};

		// Mixins
		tag.mixin('mdl');

		tag.notifications = [];

		// References
		var dialog = null;
		var content = null;
		var backButton = null;
		var sendButton = null;
		var studentId = null;
		var selectedNotifications = [];
		var originalNotifications = [];
		var studentDetailOrigin;
		var studentDataObject = {};

		function initReferences() {
			dialog = tag.refs["horizontal-wrapper"].refs["vertical-wrapper"].refs["dialog"];
			content = dialog.refs["content"];
			backButton = dialog.refs["action-buttons"].refs["back-button"];
			sendButton = dialog.refs["action-buttons"].refs["send-button"];
		}

		// Private
		function _safeBlur(element) {
			if (element && element.blur && element != document.body) {
				element.blur();
			}
		}

		function _focusHandler(event) {
			if (!tag.root.contains(event.target)) {
				event.preventDefault();
				event.stopPropagation();
				_safeBlur(event.target);
			}
		}

		function blockDocument() {
			document.body.addEventListener('focus', _focusHandler, true);
		}

		function unblockDocument() {
			document.body.removeEventListener('focus', _focusHandler, true);
		}

		function blurDocument() {
			_safeBlur(document.activeElement);
			tag.refs["focus-gain"].focus();
		}

		function initView() {
			blurDocument();
			if (guf.device.isIos) guf.disableMomentumScrolling(true);
			blockDocument();
		}

		function closeView() {
			if (guf.device.isIos) guf.disableMomentumScrolling(false);
			unblockDocument();
		}

		function loadData() {
			app.limitsMonitoring.getNotifications(studentId).then(function(notifications) {
				if(notifications) {
					originalNotifications = notifications;
					tag.notifications = notifications;
					removeListEvents();
					content.update();
					initListEvents();
				}
			});
		}

		function updateSendButtonStatus() {
			if(selectedNotifications.length > 0) {
				sendButton.enable();
			} else {
				sendButton.disable();
			}
 		}

		// Events
		function backButtonClickHandler() {
			tag.trigger("back", tag);
		}

		function sendButtonClickHandler() {
			guf.createDialog(guf.i18n.get("app.notification_sending_confirmation"), guf.i18n.get("app.notification_sending_confirmation_msg"), guf.i18n.get("guf.yes"), guf.i18n.get("guf.no"), function() {
				sendButton.disable();
				app.limitsMonitoring.sendNotifications(selectedNotifications, studentDetailOrigin, studentDataObject)
				.then(function(success) {
					if(success) {
						tag.trigger("sent");
					} else {
						sendButton.enable();
					}
				}).catch(function() {
					sendButton.enable();
				});
			}, function() {
				// Do nothing
			});
		}

		function dismissHandler(event) {
			if (!dialog.root.contains(event.target)) nokButtonClickHandler();
		}

		function itemSelectedHandler(itemTag, item) {
			selectedNotifications.push(item);
			selectedNotifications = originalNotifications.filter(function(e) {
				for(var i=0; i<selectedNotifications.length; i++) {
					if(selectedNotifications[i].notificationId === e.notificationId) {
						return true;
					}
				}
				return false;
			});
			updateSendButtonStatus();
		}

		function itemDeselectedHandler(itemTag, item) {
			var index = selectedNotifications.map(function(notification) {return notification.notificationId}).indexOf(item.notificationId);
			if(index != -1) {
				selectedNotifications.splice(index, 1);
			}
			updateSendButtonStatus();
		}

		function initListEvents() {
			var items = guf.tagsAsArray(content.tags["sam-limits-monitoring-send-notifications-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].on("selected", itemSelectedHandler);
				items[i].on("deselected", itemDeselectedHandler);
			}
		}

		function removeListEvents() {
			var items = guf.tagsAsArray(content.tags["sam-limits-monitoring-send-notifications-list-row"]);
			for(var i=0; i<items.length; i++) {
				items[i].off("selected", itemSelectedHandler);
				items[i].off("deselected", itemDeselectedHandler);
			}
		}

		function initEvents() {
			backButton.on('click', backButtonClickHandler);
			sendButton.on('click', sendButtonClickHandler);
			initListEvents();
		}

		function removeEvents() {
			backButton.off('click', backButtonClickHandler);
			sendButton.off('click', sendButtonClickHandler);
			removeListEvents();
		}

		tag.setData = function(id, studentData, origin) {
			studentId = id;
			studentDataObject = studentData;
			studentDetailOrigin = origin;
			loadData();
		};

		tag.on("mount", function() {
			initView();
			initReferences();
			initEvents();
		});

		tag.on("before-unmount", function() {
			removeEvents();
			closeView();
		});
	</script>
</sam-limits-monitoring-send-notifications>