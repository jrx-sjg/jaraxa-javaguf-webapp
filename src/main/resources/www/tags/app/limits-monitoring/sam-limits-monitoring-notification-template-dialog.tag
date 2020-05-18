<sam-limits-monitoring-notification-template-dialog>
	<button ref="focus-gain" autofocus="true" class="focus-gain"></button>
	<guf-linear-layout ref="horizontal-wrapper" orientation="horizontal" h-align="center" class="horizontal-wrapper">
		<div class="overlay"></div>
		<guf-linear-layout ref="vertical-wrapper" orientation="vertical" v-align="center" class="vertical-wrapper">
			<guf-linear-layout ref="dialog" orientation="vertical" class="dialog">
				<guf-linear-layout ref="header" orientation="horizontal" v-align="center" class="header">
					<div class="dialog-title">{guf.i18n.get('app.notification_letter')}</div>
					<div class="flex1"></div>
					<guf-button ref="close-button" type="icon" icon="close" dcss-text-color="@lighttext"></guf-button>
				</guf-linear-layout>
				<guf-linear-layout ref="content" orientation="vertical" class="content">
					<iframe ref="embedded" class="embedded flex1"></iframe>
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
			min-height: @minHeight;
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
			margin-bottom: 20px;
		}
		:scope > .horizontal-wrapper > .vertical-wrapper > .dialog > .content > .embedded {
			border: 1px solid @lines;
			border-radius: 8px;
		}
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .content {
			overflow-y: auto;
		}
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .dialog-title,
		:scope > .horizontal-wrapper.scrollable > .vertical-wrapper > .dialog > .content > * {
			flex-shrink: 0;
		}
		:scope > .horizontal-wrapper.scrollable.top-scroll-divider > .vertical-wrapper > .dialog > .dialog-title {
			border-bottom: 1px solid #dcdcdc;
		}
	</style>
	<script type="text/javascript">
		var tag = this;
		var groupImg = "img/group/" + app.getMe().campus.groupId + "-header.png";
		var signature = "img/email/" + app.getMe().campus.groupId + "/signature_director_student_services_and_operations.png";

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
			"minWidth": "650px",
			"minHeight": "500px",
			"background": "#fff",
			"headerBackground": "@primary",
			"headerPadding": "24px 24px 20px 24px",
			"headerColor": "#000",
			"fsHeaderColor": "#fff",
			"contentPadding": "0 24px 0px 24px",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};

		// Mixins
		tag.mixin('mdl');

		// Methods
		tag.content = function () {
			return content;
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
				content.refs["embedded"].contentWindow.document.open();
				content.refs["embedded"].contentWindow.document.write(notification.letter.replace("cid:logo", groupImg).replace("cid:signature", signature));
				content.refs["embedded"].contentWindow.document.close();
			}
		};

		// References
		var dialog = null;
		var content = null;
		var closeButton = null;

		function initReferences() {
			dialog = tag.refs["horizontal-wrapper"].refs["vertical-wrapper"].refs["dialog"];
			content = dialog.refs["content"];
			closeButton = dialog.refs["header"].refs["close-button"];
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

		// Events
		function closeButtonClickHandler() {
			tag.trigger("close", tag);
		}

		function dismissHandler(event) {
			if (!dialog.root.contains(event.target)) closeButtonClickHandler();
		}

		function escPressHandler(event) {
			if ((event.key!==null && event.key.toLowerCase()==="escape") || event.keyCode == 27) {
				event.preventDefault();
				event.stopPropagation();
				closeButtonClickHandler();
			}
		}

		function initEvents() {
			closeButton.on('click', closeButtonClickHandler);
			if (tag.dismissible) {
				tag.root.addEventListener('click', dismissHandler);
				document.addEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.addEventListener("backbutton", closeButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.addEventListener('scroll', tag.updateScrollBorders);
				window.addEventListener('resize', tag.updateScrollBorders);
			}
		}

		function removeEvents() {
			closeButton.off('click', closeButtonClickHandler);
			if (tag.dismissible) {
				tag.root.removeEventListener('click', dismissHandler);
				document.removeEventListener('keydown', escPressHandler);
				if (guf.device.isAndroid) document.removeEventListener("backbutton", closeButtonClickHandler);
			}
			if (tag.scrollable) {
				content.root.removeEventListener('scroll', tag.updateScrollBorders);
				window.removeEventListener('resize', tag.updateScrollBorders);
			}
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
</sam-limits-monitoring-notification-template-dialog>