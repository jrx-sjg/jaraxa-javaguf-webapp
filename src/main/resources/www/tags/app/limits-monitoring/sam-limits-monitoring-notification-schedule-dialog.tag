<sam-limits-monitoring-notification-schedule-dialog>
	<button ref="focus-gain" autofocus="true" class="focus-gain"></button>
	<guf-linear-layout ref="horizontal-wrapper" orientation="horizontal" h-align="center" class="horizontal-wrapper">
		<div class="overlay"></div>
		<guf-linear-layout ref="vertical-wrapper" orientation="vertical" v-align="center" class="vertical-wrapper">
			<guf-linear-layout ref="dialog" orientation="vertical" class="dialog">
				<guf-linear-layout ref="header" orientation="horizontal" v-align="center" class="header">
					<div class="dialog-title">{guf.i18n.get('app.notification_details')}</div>
				</guf-linear-layout>
				<guf-linear-layout ref="content" orientation="vertical" class="content">
					<guf-linear-layout ref="schedule-date-container" class="date-container" orientation="horizontal">
						<guf-datetimepicker ref="schedule-date-combo" class="flex1" type="date" inputtype="button" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.schedule_date')}" format="L" autoclose="true" cancel="{guf.i18n.get('guf.cancel')}" disabled="{!guf.ancestor(this, 'sam-limits-monitoring-notification-schedule-dialog').showOk}"></guf-datetimepicker>
						<guf-button ref="schedule-date-clear-button" type="icon" icon="cancel" dcss-text-color="@primary"></guf-button>
					</guf-linear-layout>
					<guf-linear-layout ref="real-date-container" class="date-container" orientation="horizontal">
						<guf-datetimepicker ref="real-date-combo" class="flex1" type="date" inputtype="button" button-type="outline" full-width="true" label="floating" trailing-icon="arrow_drop_down" placeholder="{guf.i18n.get('app.real_date')}" format="L" autoclose="true" cancel="{guf.i18n.get('guf.cancel')}" disabled="{!guf.ancestor(this, 'sam-limits-monitoring-notification-schedule-dialog').showOk}"></guf-datetimepicker>
						<guf-button ref="real-date-clear-button" type="icon" icon="cancel" dcss-text-color="@primary"></guf-button>
					</guf-linear-layout>
					<guf-textarea ref="comment" label="v2-outlined" placeholder="{guf.i18n.get(guf.i18n.PLURAL, 'app.comment')}" rows="4" readonly="{!guf.ancestor(this, 'sam-limits-monitoring-notification-schedule-dialog').showOk}"></guf-textarea>
				</guf-linear-layout>
				<guf-linear-layout ref="action-buttons" orientation="horizontal" h-align="right" class="action-buttons">
					<guf-button ref="nok" type="flat" ripple="true" color="true">{guf.i18n.get('guf.cancel')}</guf-button>
					<guf-button if="{guf.ancestor(this, 'sam-limits-monitoring-notification-schedule-dialog').showOk}" ref="ok" type="color-flat" ripple="true" color="true" disabled="true">{guf.i18n.get('guf.accept')}</guf-button>
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
		:scope,
		:scope > .horizontal-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog,
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			min-width: @minWidth;
			min-height: 0;
		}
		:scope > .horizontal-wrapper {
			padding: 24px;
			position: relative;
		}
		:scope > .horizontal-wrapper:not(.scrollable) {
			-webkit-flex: 1 0 auto;
			-ms-flex: 1 0 auto;
			flex: 1 0 auto;
		}
		:scope > .horizontal-wrapper > .overlay {
			position: fixed;
			top: 0;
			right: 0;
			bottom: 0;
			left: 0;
			z-index: 999999998;
			background-color: @overlayColor;
		}
		.guf-device-ios :scope > .horizontal-wrapper > .overlay {
			position: absolute;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog {
			background-color: @background;
			z-index: 999999999;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog {
			-webkit-border-radius: 8px;
			-moz-border-radius: 8px;
			border-radius: 8px;
			box-shadow: 0 9px 46px 8px rgba(0,0,0,.14), 0 11px 15px -7px rgba(0,0,0,.12), 0 24px 38px 3px rgba(0,0,0,.2);
		}
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog {
			max-height: 100%;
			min-height: @minHeight;
			-webkit-flex: 0 1 auto;
			-ms-flex: 0 1 auto;
			flex: 0 1 auto;
		}
		:scope > .horizontal-wrapper:not(.scrollable) > .vertical-wrapper > .dialog {
			-webkit-flex: 0 0 auto;
			-ms-flex: 0 0 auto;
			flex: 0 0 auto;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .header {
			padding: 16px 24px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .header > .dialog-title {
			font-size: 20px;
			line-height: 28px;
			color: @headerColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .dialog-title {
			padding: @headerPadding;
			font-size: 20px;
			line-height: 28px;
			color: @headerColor;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content {
			padding: @contentPadding;
		}
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .content {
			overflow-y: auto;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons {
			padding: 0px 24px 24px 24px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .action-buttons > guf-button:not(:first-child) {
			margin-left: 8px;
		}
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .dialog-title,
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .content > *,
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .action-buttons {
			flex-shrink: 0;
		}
		:scope > .horizontal-wrapper.scrollable.top-scroll-divider > .vertical-wrapper > .dialog > .dialog-title {
			border-bottom: 1px solid #dcdcdc;
		}
		:scope > .horizontal-wrapper.scrollable.bottom-scroll-divider > .vertical-wrapper > .dialog > .action-buttons {
			border-top: 1px solid #dcdcdc;
		}

		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content > .date-container {
			margin-bottom: 0px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content > .date-container > guf-button {
			margin-top: 16px;
			margin-left: 10px;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		/*
		 * Parameters:
		 *	boolean: 	opts.scrollable
		 * 	boolean: 	opts.dismissible
		 */

		// Properties
		tag.scrollable = guf.param.booleanExpr(opts, "scrollable", false);
		tag.dialogTitle = guf.param.string(opts.title, "");
		tag.dismissible = guf.param.booleanExpr(opts, "dismissible", false);
		tag.showOk = guf.param.booleanExpr(opts, "showOk", true);

		// Dcss
		tag.defaultDcss = {
			// - material default values
			"overlayColor": "rgba(0, 0, 0, 0.3)",
			"minWidth": "450px",
			"minHeight": "190px",
			"background": "#fff",
			"headerBackground": "@primary",
			"headerPadding": "24px 24px 20px 24px",
			"headerColor": "#000",
			"fsHeaderColor": "#fff",
			"contentPadding": "0 24px 0px 24px",
			"lighttext": "@lighttext"
		};
		tag["actionsColor"] = guf.param.string(opts.dcssActionsColor, null);
		tag["fsActionsColor"] = guf.param.string(opts.dcssFsActionsColor, "white");

		// Mixins
		tag.mixin('mdl');

		// Methods
		tag.content = function () {
			return content;
		};

		tag.enableOkButton = function() {
			if(tag.showOk) {
				okButton.enable();
			}
		};

		tag.disableOkButton = function() {
			if(tag.showOk) {
				okButton.disable();
			}
		};

		tag.enableNokButton = function() {
			nokButton.enable();
		};

		tag.disableNokButton = function() {
			nokButton.disable();
		};

		tag.updateScrollBorders = function () {
			if (content) {
				var container = content.root;
				if (container.scrollTop > 0) tag.refs["horizontal-wrapper"].root.classList.add('top-scroll-divider');
				else tag.refs["horizontal-wrapper"].root.classList.remove('top-scroll-divider');
				if ((container.offsetHeight + container.scrollTop )< container.scrollHeight) tag.refs["horizontal-wrapper"].root.classList.add('bottom-scroll-divider');
				else tag.refs["horizontal-wrapper"].root.classList.remove('bottom-scroll-divider');
			}
		};

		tag.setData = function(notification) {
			if(content) {
				if(notification.meetingScheduledDate) {
					var scheduledDateMoment = moment(notification.meetingScheduledDate,"YYYY-MM-DD");
					var formattedScheduledDate = scheduledDateMoment.format("L");
					scheduleDateCombo.setValue(formattedScheduledDate, scheduledDateMoment);
				}
				if(notification.meetingActualDate) {
					var realDateMoment = moment(notification.meetingActualDate,"YYYY-MM-DD");
					var formattedRealDate = realDateMoment.format("L");
					realDateCombo.setValue(formattedRealDate, realDateMoment);
				}
				commentInput.setValue(notification.meetingComments);
			}
		};

		// References
		var dialog = null;
		var content = null;
		var okButton = null;
		var nokButton = null;
		var scheduleDateCombo = null;
		var scheduleDateClearButton = null;
		var realDateCombo = null;
		var realDateClearButton = null;
		var commentInput = null;

		function initReferences() {
			dialog = tag.refs["horizontal-wrapper"].refs["vertical-wrapper"].refs["dialog"];
			content = dialog.refs["content"];
			if(tag.showOk) {
				okButton = dialog.refs["action-buttons"].refs["ok"];
			}
			nokButton = dialog.refs["action-buttons"].refs["nok"];
			scheduleDateCombo = content.refs["schedule-date-container"].refs["schedule-date-combo"];
			scheduleDateClearButton = content.refs["schedule-date-container"].refs["schedule-date-clear-button"];
			realDateCombo = content.refs["real-date-container"].refs["real-date-combo"];
			realDateClearButton = content.refs["real-date-container"].refs["real-date-clear-button"];
			commentInput = content.refs["comment"];
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

		function updateButtonState() {
			tag.enableOkButton();
		}

		// Events
		function okButtonClickHandler() {
			var scheduleDate = scheduleDateCombo.getValue();
			var realDate = realDateCombo.getValue();
			if(scheduleDate.length > 0) {
				scheduleDate = moment(scheduleDate,"L").format("YYYY-MM-DD");
			}
			if(realDate.length > 0) {
				realDate = moment(realDate,"L").format("YYYY-MM-DD");
			}
			tag.trigger("ok", tag, scheduleDate, realDate, commentInput.getValue());
		}

		function nokButtonClickHandler() {
			tag.trigger("nok", tag);
		}

		function dismissHandler(event) {
			if (!dialog.root.contains(event.target)) nokButtonClickHandler();
		}

		function escPressHandler(event) {
			if ((event.key!==null && event.key.toLowerCase()==="escape") || event.keyCode == 27) {
				event.preventDefault();
				event.stopPropagation();
				nokButtonClickHandler();
			}
		}

		function scheduleDateChangeHandler(newDate, combo) {
			updateButtonState();
		}

		function scheduleDateClearHandler() {
			scheduleDateCombo.setValue("");
			updateButtonState();
		}

		function realDateChangeHandler(newDate, combo) {
			updateButtonState();
		}

		function realDateClearHandler() {
			realDateCombo.setValue("");
			updateButtonState();
		}

		function commentInputHandler() {
			updateButtonState();
		}

		function initEvents() {
			if(tag.showOk) {
				okButton.on('click', okButtonClickHandler);
			}
			nokButton.on('click', nokButtonClickHandler);
			if (tag.dismissible) {
				tag.root.addEventListener('click', dismissHandler);
				document.addEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.addEventListener("backbutton", nokButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.addEventListener('scroll', tag.updateScrollBorders);
				window.addEventListener('resize', tag.updateScrollBorders);
			}
			scheduleDateCombo.on("date-change", scheduleDateChangeHandler);
			scheduleDateClearButton.on("click", scheduleDateClearHandler);
			realDateCombo.on("date-change", realDateChangeHandler);
			realDateClearButton.on("click", realDateClearHandler);
			commentInput.on("input", commentInputHandler);
		}

		function removeEvents() {
			if(tag.showOk) {
				okButton.off('click', okButtonClickHandler);
			}
			nokButton.off('click', nokButtonClickHandler);
			if (tag.dismissible) {
				tag.root.addEventListener('click', dismissHandler);
				document.addEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.addEventListener("backbutton", nokButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.removeEventListener('scroll', tag.updateScrollBorders);
				window.removeEventListener('resize', tag.updateScrollBorders);
			}
			scheduleDateCombo.off("date-change", scheduleDateChangeHandler);
			scheduleDateClearButton.off("click", scheduleDateClearHandler);
			realDateCombo.off("date-change", realDateChangeHandler);
			realDateClearButton.off("click", realDateClearHandler);
			commentInput.off("input", commentInputHandler);
		}

		tag.on('mount', function () {
			initView();
			initReferences();
			initEvents();
		});

		tag.on('before-unmount', function () {
			removeEvents();
			closeView();
		});
	</script>
</sam-limits-monitoring-notification-schedule-dialog>